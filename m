From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v7 1/5] net/x25: handle additional netdev events
Date: Thu, 26 Nov 2020 07:35:53 +0100
Message-ID: <20201126063557.1283-2-ms@dev.tdt.de>
References: <20201126063557.1283-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201126063557.1283-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

1. Add / remove x25_link_device by NETDEV_REGISTER/UNREGISTER and also
   by NETDEV_POST_TYPE_CHANGE/NETDEV_PRE_TYPE_CHANGE.

   This change is needed so that the x25_neigh struct for an interface
   is already created when it shows up and is kept independently if the
   interface goes UP or DOWN.

   This is used in an upcomming commit, where x25 params of an neighbour
   will get configurable through ioctls.

2. NETDEV_CHANGE event makes it possible to handle carrier loss and
   detection. If carrier is lost, clean up everything related to this
   neighbour by calling x25_link_terminated().

3. Also call x25_link_terminated() for NETDEV_DOWN events and remove the
   call to x25_clear_forward_by_dev() in x25_route_device_down(), as
   this is already called by x25_kill_by_neigh() which gets called by
   x25_link_terminated().

4. Do nothing for NETDEV_UP and NETDEV_GOING_DOWN events, as these will
   be handled in layer 2 (LAPB) and layer3 (X.25) will be informed by
   layer2 when layer2 link is established and layer3 link should be
   initiated.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c    | 22 ++++++++++++++++------
 net/x25/x25_link.c  |  6 +++---
 net/x25/x25_route.c |  3 ---
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 046d3fee66a9..313a6222ded9 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -233,21 +233,31 @@ static int x25_device_event(struct notifier_block *=
this, unsigned long event,
 #endif
 	 ) {
 		switch (event) {
-		case NETDEV_UP:
+		case NETDEV_REGISTER:
+		case NETDEV_POST_TYPE_CHANGE:
 			x25_link_device_up(dev);
 			break;
-		case NETDEV_GOING_DOWN:
+		case NETDEV_DOWN:
 			nb =3D x25_get_neigh(dev);
 			if (nb) {
-				x25_terminate_link(nb);
+				x25_link_terminated(nb);
 				x25_neigh_put(nb);
 			}
-			break;
-		case NETDEV_DOWN:
-			x25_kill_by_device(dev);
 			x25_route_device_down(dev);
+			break;
+		case NETDEV_PRE_TYPE_CHANGE:
+		case NETDEV_UNREGISTER:
 			x25_link_device_down(dev);
 			break;
+		case NETDEV_CHANGE:
+			if (!netif_carrier_ok(dev)) {
+				nb =3D x25_get_neigh(dev);
+				if (nb) {
+					x25_link_terminated(nb);
+					x25_neigh_put(nb);
+				}
+			}
+			break;
 		}
 	}
=20
diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index fdae054b7dc1..11e868aa625d 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -232,6 +232,9 @@ void x25_link_established(struct x25_neigh *nb)
 void x25_link_terminated(struct x25_neigh *nb)
 {
 	nb->state =3D X25_LINK_STATE_0;
+	skb_queue_purge(&nb->queue);
+	x25_stop_t20timer(nb);
+
 	/* Out of order: clear existing virtual calls (X.25 03/93 4.6.3) */
 	x25_kill_by_neigh(nb);
 }
@@ -277,9 +280,6 @@ void x25_link_device_up(struct net_device *dev)
  */
 static void __x25_remove_neigh(struct x25_neigh *nb)
 {
-	skb_queue_purge(&nb->queue);
-	x25_stop_t20timer(nb);
-
 	if (nb->node.next) {
 		list_del(&nb->node);
 		x25_neigh_put(nb);
diff --git a/net/x25/x25_route.c b/net/x25/x25_route.c
index 00e46c9a5280..ec2a39e9b3e6 100644
--- a/net/x25/x25_route.c
+++ b/net/x25/x25_route.c
@@ -115,9 +115,6 @@ void x25_route_device_down(struct net_device *dev)
 			__x25_remove_route(rt);
 	}
 	write_unlock_bh(&x25_route_list_lock);
-
-	/* Remove any related forwarding */
-	x25_clear_forward_by_dev(dev);
 }
=20
 /*
--=20
2.20.1

