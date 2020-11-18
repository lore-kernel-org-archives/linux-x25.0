From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v3 6/6] net/x25: remove x25_kill_by_device()
Date: Wed, 18 Nov 2020 14:59:19 +0100
Message-ID: <20201118135919.1447-7-ms@dev.tdt.de>
References: <20201118135919.1447-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20201118135919.1447-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

Remove unnecessary function x25_kill_by_device().

Replace the call to x25_kill_by_device() by x25_kill_by_neigh().

Therefore, also remove the call to x25_clear_forward_by_dev() in
x25_route_device_down(), as this is already called by
x25_kill_by_neigh().

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c    | 22 +++++-----------------
 net/x25/x25_route.c |  3 ---
 2 files changed, 5 insertions(+), 20 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 02f56386e05b..ec90956f38d4 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -199,22 +199,6 @@ static void x25_remove_socket(struct sock *sk)
 	write_unlock_bh(&x25_list_lock);
 }
=20
-/*
- *	Kill all bound sockets on a dropped device.
- */
-static void x25_kill_by_device(struct net_device *dev)
-{
-	struct sock *s;
-
-	write_lock_bh(&x25_list_lock);
-
-	sk_for_each(s, &x25_list)
-		if (x25_sk(s)->neighbour && x25_sk(s)->neighbour->dev =3D=3D dev)
-			x25_disconnect(s, ENETUNREACH, 0, 0);
-
-	write_unlock_bh(&x25_list_lock);
-}
-
 /*
  *	Handle device status changes.
  */
@@ -260,7 +244,11 @@ static int x25_device_event(struct notifier_block *t=
his, unsigned long event,
 		case NETDEV_DOWN:
 			pr_debug("X.25: got event NETDEV_DOWN for device: %s\n",
 				 dev->name);
-			x25_kill_by_device(dev);
+			nb =3D x25_get_neigh(dev);
+			if (nb) {
+				x25_kill_by_neigh(nb);
+				x25_neigh_put(nb);
+			}
 			x25_route_device_down(dev);
 			x25_link_device_down(dev);
 			break;
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

