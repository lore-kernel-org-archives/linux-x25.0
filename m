From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH] drivers/net/wan/x25_asy: Fix to make it work
Date: Tue,  7 Jul 2020 21:37:54 -0700
Message-ID: <20200708043754.46554-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pGbaCoMke0eHVeVRLkTlHstsJU5HzwWe4OVKEnmf1ZQ=;
        b=sbxCs0Xh2GFQxQ+jOOqUDA4ATECZXZ2LYdmSyQjvs7devdjXaMII5lDZiIUTSCJY0X
         U7UCVgT7t1OcdgWbf9oY1ilqODpu70WpY1ItakeeQmoerMUy/LMhjq5iJWq5rSbtdejy
         xbvIMeKzFf6x7fmtlSHMpjB7hXA3OvGR1LN1mHVnowtPTVUmRyrn9ozfCjk+sbS4E+Dt
         st1okfrv4p7vrDbRRB7EgbaQRl86CQoSa0BlRByLqKjrz4kYwlSSvXj0OBuZcJOMocpW
         mAVyxhpQ1C/JAouRcBrBWG4pOqMhKdWUZO2moH/xqvObFvLjpRo+QkTlUZiH60M+V64Q
         LhJQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Shannon Nelson <snelson@pensando.io>, Martin Habets <mhabets@solarflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, Xie He <xie.he.0141@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

This driver is not working because of problems of its receiving code.
This patch fixes it to make it work.

When the driver receives an LAPB frame, it should first pass the frame
to the LAPB module to process. After processing, the LAPB module passes
the data (the packet) back to the driver, the driver should then add a
one-byte pseudo header and pass the data to upper layers.

The changes to the "x25_asy_bump" function and the
"x25_asy_data_indication" function are to correctly implement this
procedure.

Also, the "x25_asy_unesc" function ignores any frame that is shorter
than 3 bytes. However the shortest frames are 2-byte long. So we need
to change it to allow 2-byte frames to pass.

Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/x25_asy.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wan/x25_asy.c b/drivers/net/wan/x25_asy.c
index 69773d228ec1..3fd8938e591b 100644
--- a/drivers/net/wan/x25_asy.c
+++ b/drivers/net/wan/x25_asy.c
@@ -183,7 +183,7 @@ static inline void x25_asy_unlock(struct x25_asy *sl)
 	netif_wake_queue(sl->dev);
 }
 
-/* Send one completely decapsulated IP datagram to the IP layer. */
+/* Send an LAPB frame to the LAPB module to process. */
 
 static void x25_asy_bump(struct x25_asy *sl)
 {
@@ -195,13 +195,12 @@ static void x25_asy_bump(struct x25_asy *sl)
 	count = sl->rcount;
 	dev->stats.rx_bytes += count;
 
-	skb = dev_alloc_skb(count+1);
+	skb = dev_alloc_skb(count);
 	if (skb == NULL) {
 		netdev_warn(sl->dev, "memory squeeze, dropping packet\n");
 		dev->stats.rx_dropped++;
 		return;
 	}
-	skb_push(skb, 1);	/* LAPB internal control */
 	skb_put_data(skb, sl->rbuff, count);
 	skb->protocol = x25_type_trans(skb, sl->dev);
 	err = lapb_data_received(skb->dev, skb);
@@ -209,7 +208,6 @@ static void x25_asy_bump(struct x25_asy *sl)
 		kfree_skb(skb);
 		printk(KERN_DEBUG "x25_asy: data received err - %d\n", err);
 	} else {
-		netif_rx(skb);
 		dev->stats.rx_packets++;
 	}
 }
@@ -356,12 +354,16 @@ static netdev_tx_t x25_asy_xmit(struct sk_buff *skb,
  */
 
 /*
- *	Called when I frame data arrives. We did the work above - throw it
- *	at the net layer.
+ *	Called when I frame data arrives. We add a pseudo header for upper
+ *	layers and pass it to upper layers.
  */
 
 static int x25_asy_data_indication(struct net_device *dev, struct sk_buff *skb)
 {
+	skb_push(skb, 1);
+	skb->data[0] = X25_IFACE_DATA;
+	skb->protocol = x25_type_trans(skb, dev);
+
 	return netif_rx(skb);
 }
 
@@ -657,7 +659,7 @@ static void x25_asy_unesc(struct x25_asy *sl, unsigned char s)
 	switch (s) {
 	case X25_END:
 		if (!test_and_clear_bit(SLF_ERROR, &sl->flags) &&
-		    sl->rcount > 2)
+		    sl->rcount >= 2)
 			x25_asy_bump(sl);
 		clear_bit(SLF_ESCAPE, &sl->flags);
 		sl->rcount = 0;
-- 
2.25.1

