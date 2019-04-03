From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 3/4] isdn/i4l/isdn_x25iface: call skb_reset_network_header
Date: Wed,  3 Apr 2019 07:01:17 +0200
Message-ID: <20190403050118.12785-3-ms@dev.tdt.de>
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

... after skb_push() / skb_pull().

This fixes the output of tcpdump.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/isdn/i4l/isdn_x25iface.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_x25iface.c b/drivers/isdn/i4l/isdn_x25iface.c
index 48bfbcb4a09d..ffd50fa47111 100644
--- a/drivers/isdn/i4l/isdn_x25iface.c
+++ b/drivers/isdn/i4l/isdn_x25iface.c
@@ -194,6 +194,7 @@ static int isdn_x25iface_receive(struct concap_proto *cprot, struct sk_buff *skb
 	if (((ix25_pdata_t *)(cprot->proto_data))
 	    ->state == WAN_CONNECTED) {
 		if (skb_push(skb, 1)) {
+			skb_reset_network_header(skb);
 			skb->data[0] = X25_IFACE_DATA;
 			skb->protocol = x25_type_trans(skb, cprot->net_dev);
 			netif_rx(skb);
@@ -225,6 +226,7 @@ static int isdn_x25iface_connect_ind(struct concap_proto *cprot)
 	skb = dev_alloc_skb(1);
 	if (skb) {
 		skb_put_u8(skb, X25_IFACE_CONNECT);
+		skb_reset_network_header(skb);
 		skb->protocol = x25_type_trans(skb, cprot->net_dev);
 		netif_rx(skb);
 		return 0;
@@ -254,6 +256,7 @@ static int isdn_x25iface_disconn_ind(struct concap_proto *cprot)
 	skb = dev_alloc_skb(1);
 	if (skb) {
 		skb_put_u8(skb, X25_IFACE_DISCONNECT);
+		skb_reset_network_header(skb);
 		skb->protocol = x25_type_trans(skb, cprot->net_dev);
 		netif_rx(skb);
 		return 0;
@@ -278,10 +281,14 @@ static int isdn_x25iface_xmit(struct concap_proto *cprot, struct sk_buff *skb)
 	case X25_IFACE_DATA:
 		if (*state == WAN_CONNECTED) {
 			skb_pull(skb, 1);
+			skb_reset_network_header(skb);
 			netif_trans_update(cprot->net_dev);
 			ret = (cprot->dops->data_req(cprot, skb));
 			/* prepare for future retransmissions */
-			if (ret) skb_push(skb, 1);
+			if (ret) {
+				skb_push(skb, 1);
+				skb_reset_network_header(skb);
+			}
 			return ret;
 		}
 		illegal_state_warn(*state, firstbyte);
-- 
2.11.0

