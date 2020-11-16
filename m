From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 3/6] net/x25: replace x25_kill_by_device with x25_kill_by_neigh
Date: Mon, 16 Nov 2020 08:31:46 +0100
Message-ID: <20201116073149.23219-3-ms@dev.tdt.de>
References: <20201116073149.23219-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20201116073149.23219-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

Remove unnecessary function x25_kill_by_device.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 439ae65ab7a8..d98d1145500e 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -210,22 +210,6 @@ static void x25_remove_socket(struct sock *sk)
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
@@ -266,7 +250,11 @@ static int x25_device_event(struct notifier_block *t=
his, unsigned long event,
 			break;
 		case NETDEV_DOWN:
 			pr_debug("X.25: got event NETDEV_DOWN for device: %s\n", dev->name);
-			x25_kill_by_device(dev);
+			nb =3D x25_get_neigh(dev);
+			if (nb) {
+				x25_kill_by_neigh(nb);
+				x25_neigh_put(nb);
+			}
 			x25_route_device_down(dev);
 			x25_link_device_down(dev);
 			break;
--=20
2.20.1

