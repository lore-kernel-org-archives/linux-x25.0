From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v2 4/6] net/x25: support NETDEV_CHANGE notifier
Date: Mon, 16 Nov 2020 14:55:24 +0100
Message-ID: <20201116135522.21791-5-ms@dev.tdt.de>
References: <20201116135522.21791-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201116135522.21791-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

This makes it possible to handle carrier lost and detection.
In case of carrier lost, we shutdown layer 3 and flush all sessions.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---

Change from v1:
fix 'subject_prefix' and 'checkpatch' warnings

---
 net/x25/af_x25.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 25726120fcc7..6a95ca11694e 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -275,6 +275,19 @@ static int x25_device_event(struct notifier_block *t=
his, unsigned long event,
 				 dev->name);
 			x25_link_device_remove(dev);
 			break;
+		case NETDEV_CHANGE:
+			pr_debug("X.25: got event NETDEV_CHANGE for device: %s\n",
+				 dev->name);
+			if (!netif_carrier_ok(dev)) {
+				pr_debug("X.25: Carrier lost -> set link state down: %s\n",
+					 dev->name);
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
--=20
2.20.1

