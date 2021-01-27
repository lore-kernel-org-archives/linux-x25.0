From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB frames
Date: Wed, 27 Jan 2021 01:07:47 -0800
Message-ID: <20210127090747.364951-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W38Kq8YAmsgr/+CxAuWwYcuGViKuCoITh18icT+elsI=;
        b=RvDCPoT+bX1ytkELJsOF6lPH6bM+TVKJi40jhc3smzXdUbks6Hds9xtFNRqSm9+kk6
         eZW55fHL4lzumTYIpn9MNvPnTtaQMCdHMJAOlpGPRUcxnOf/pcGmWYtscxoHwGv9vd5q
         uwg3MmQqVpbjBOZWx97Z8xPVJSO8Zeq88x2MSxAjb1jbCey6xPrUQQ0JVpOegiCsKRb4
         0yAj/l++AaA05FQC3c9xU+z/3gD6tOw6Oq3uDz/xyLtEnVyXCAiknq38gLnosH5F/KVP
         zx8wiQNdq7WKR4wabLKxUuEUNwGzLBOGcAAEmpkweBE5B+tIpqEMAXW0+cLVSNE4ltWs
         Z0GA==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: Xie He <xie.he.0141@gmail.com>

An HDLC hardware driver may call netif_stop_queue to temporarily stop
the TX queue when the hardware is busy sending a frame, and after the
hardware has finished sending the frame, call netif_wake_queue to
resume the TX queue.

However, the LAPB module doesn't know about this. Whether or not the
hardware driver has stopped the TX queue, the LAPB module still feeds
outgoing frames to the hardware driver for transmission. This can cause
frames to be dropped by the hardware driver.

It's not easy to fix this issue in the LAPB module. We can indeed let the
LAPB module check whether the TX queue has been stopped before feeding
each frame to the hardware driver, but when the hardware driver resumes
the TX queue, it's not easy to immediately notify the LAPB module and ask
it to resume transmission.

Instead, we can fix this issue at the hdlc_x25 layer, by using qdisc TX
queues to queue outgoing LAPB frames. The qdisc TX queue will then
automatically be controlled by netif_stop_queue and netif_wake_queue.

This way, when sending, we will use the qdisc queue to queue and send
the data twice: once as the L3 packet and then (after processed by the
LAPB module) as an LAPB (L2) frame. This does not make the logic of the
code messy, because when receiving, data are already "received" on the
device twice: once as an LAPB (L2) frame and then (after processed by
the LAPB module) as the L3 packet.

Some more details about the code change:

1. dev_queue_xmit_nit is removed because we already have it when we send
the skb through the qdisc TX queue (in xmit_one).

2. hdlc_type_trans is replaced by assigning skb->dev and skb->protocol
directly. skb_reset_mac_header in hdlc_type_trans is no longer necessary
because it will be called in __dev_queue_xmit.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: Martin Schiller <ms@dev.tdt.de>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/hdlc_x25.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wan/hdlc_x25.c b/drivers/net/wan/hdlc_x25.c
index bb164805804e..b7f2823bf100 100644
--- a/drivers/net/wan/hdlc_x25.c
+++ b/drivers/net/wan/hdlc_x25.c
@@ -89,15 +89,10 @@ static int x25_data_indication(struct net_device *dev, struct sk_buff *skb)
 
 static void x25_data_transmit(struct net_device *dev, struct sk_buff *skb)
 {
-	hdlc_device *hdlc = dev_to_hdlc(dev);
-
+	skb->dev = dev;
+	skb->protocol = htons(ETH_P_HDLC);
 	skb_reset_network_header(skb);
-	skb->protocol = hdlc_type_trans(skb, dev);
-
-	if (dev_nit_active(dev))
-		dev_queue_xmit_nit(skb, dev);
-
-	hdlc->xmit(skb, dev); /* Ignore return value :-( */
+	dev_queue_xmit(skb);
 }
 
 
@@ -106,6 +101,12 @@ static netdev_tx_t x25_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	int result;
 
+	if (skb->protocol == htons(ETH_P_HDLC)) {
+		hdlc_device *hdlc = dev_to_hdlc(dev);
+
+		return hdlc->xmit(skb, dev);
+	}
+
 	/* There should be a pseudo header of 1 byte added by upper layers.
 	 * Check to make sure it is there before reading it.
 	 */
-- 
2.27.0

