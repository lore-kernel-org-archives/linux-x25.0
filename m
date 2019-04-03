From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 1/4] net/x25: call skb_reset_network_header where needed
Date: Wed,  3 Apr 2019 07:01:15 +0200
Message-ID: <20190403050118.12785-1-ms@dev.tdt.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net, khc@pm.waw.pl, isdn@linux-pingi.de
Cc: edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

This fixes some problems like:
 o tcpdump not showing X.25<->LapB Header
 o "protocol 0508 is buggy" warning from I4L

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/x25_dev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/x25/x25_dev.c b/net/x25/x25_dev.c
index 39231237e1c3..eef0305f3e99 100644
--- a/net/x25/x25_dev.c
+++ b/net/x25/x25_dev.c
@@ -127,6 +127,7 @@ int x25_lapb_receive_frame(struct sk_buff *skb, struct net_device *dev,
 
 	case X25_IFACE_DATA:
 		skb_pull(skb, 1);
+		skb_reset_network_header(skb);
 		if (x25_receive_data(skb, nb)) {
 			x25_neigh_put(nb);
 			goto out;
@@ -171,6 +172,8 @@ void x25_establish_link(struct x25_neigh *nb)
 		return;
 	}
 
+	skb_reset_network_header(skb);
+
 	skb->protocol = htons(ETH_P_X25);
 	skb->dev      = nb->dev;
 
@@ -198,6 +201,8 @@ void x25_terminate_link(struct x25_neigh *nb)
 	ptr  = skb_put(skb, 1);
 	*ptr = X25_IFACE_DISCONNECT;
 
+	skb_reset_network_header(skb);
+
 	skb->protocol = htons(ETH_P_X25);
 	skb->dev      = nb->dev;
 	dev_queue_xmit(skb);
@@ -207,8 +212,6 @@ void x25_send_frame(struct sk_buff *skb, struct x25_neigh *nb)
 {
 	unsigned char *dptr;
 
-	skb_reset_network_header(skb);
-
 	switch (nb->dev->type) {
 	case ARPHRD_X25:
 		dptr  = skb_push(skb, 1);
@@ -225,6 +228,8 @@ void x25_send_frame(struct sk_buff *skb, struct x25_neigh *nb)
 		return;
 	}
 
+	skb_reset_network_header(skb);
+
 	skb->protocol = htons(ETH_P_X25);
 	skb->dev      = nb->dev;
 
-- 
2.11.0

