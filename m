From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 2/4] wan/hdlc_x25: fix skb handling
Date: Wed,  3 Apr 2019 07:01:16 +0200
Message-ID: <20190403050118.12785-2-ms@dev.tdt.de>
References: <20190403050118.12785-1-ms@dev.tdt.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403050118.12785-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net, khc@pm.waw.pl, isdn@linux-pingi.de
Cc: edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

 o call skb_reset_network_header() before hdlc->xmit()
 o change skb proto to HDLC (0x0019) before hdlc->xmit()
 o call dev_queue_xmit_nit() before hdlc->xmit()

This changes make it possible to trace (tcpdump) outgoing layer2
(ETH_P_HDLC) packets

 o use a copy of the skb for lapb_data_request()

This fixes the problem, that tracing layer3 (ETH_P_X25) packets
results in a malformed first byte of the packets.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/net/wan/hdlc_x25.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/hdlc_x25.c b/drivers/net/wan/hdlc_x25.c
index e867638067a6..fb5ed6856be5 100644
--- a/drivers/net/wan/hdlc_x25.c
+++ b/drivers/net/wan/hdlc_x25.c
@@ -66,6 +66,7 @@ static int x25_data_indication(struct net_device *dev, struct sk_buff *skb)
 	unsigned char *ptr;
 
 	skb_push(skb, 1);
+	skb_reset_network_header(skb);
 
 	if (skb_cow(skb, 1))
 		return NET_RX_DROP;
@@ -82,6 +83,9 @@ static int x25_data_indication(struct net_device *dev, struct sk_buff *skb)
 static void x25_data_transmit(struct net_device *dev, struct sk_buff *skb)
 {
 	hdlc_device *hdlc = dev_to_hdlc(dev);
+	skb_reset_network_header(skb);
+	skb->protocol = hdlc_type_trans(skb, dev);
+	dev_queue_xmit_nit(skb, dev);
 	hdlc->xmit(skb, dev); /* Ignore return value :-( */
 }
 
@@ -89,16 +93,19 @@ static void x25_data_transmit(struct net_device *dev, struct sk_buff *skb)
 
 static netdev_tx_t x25_xmit(struct sk_buff *skb, struct net_device *dev)
 {
+	struct sk_buff *skbn;
 	int result;
 
 
 	/* X.25 to LAPB */
 	switch (skb->data[0]) {
 	case X25_IFACE_DATA:	/* Data to be transmitted */
-		skb_pull(skb, 1);
-		if ((result = lapb_data_request(dev, skb)) != LAPB_OK)
-			dev_kfree_skb(skb);
-		return NETDEV_TX_OK;
+		skbn = skb_copy(skb, GFP_ATOMIC);
+		skb_pull(skbn, 1);
+		skb_reset_network_header(skbn);
+		if ((result = lapb_data_request(dev, skbn)) != LAPB_OK)
+			dev_kfree_skb(skbn);
+		break;
 
 	case X25_IFACE_CONNECT:
 		if ((result = lapb_connect_request(dev))!= LAPB_OK) {
-- 
2.11.0

