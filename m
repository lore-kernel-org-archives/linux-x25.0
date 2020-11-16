From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 4/6] net/x25: support NETDEV_CHANGE notifier
Date: Mon, 16 Nov 2020 08:31:47 +0100
Message-ID: <20201116073149.23219-4-ms@dev.tdt.de>
References: <20201116073149.23219-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201116073149.23219-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

This makes it possible to handle carrier lost and detection.
In case of carrier lost, we shutdown layer 3 and flush all sessions.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index d98d1145500e..d61a154b94e4 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -266,6 +266,17 @@ static int x25_device_event(struct notifier_block *t=
his, unsigned long event,
 			pr_debug("X.25: got event NETDEV_UNREGISTER for device: %s\n", dev->n=
ame);
 			x25_link_device_remove(dev);
 			break;
+		case NETDEV_CHANGE:
+			pr_debug("X.25: got event NETDEV_CHANGE for device: %s\n", dev->name)=
;
+			if (!netif_carrier_ok(dev)) {
+				pr_debug("X.25: Carrier lost -> set link state down: %s\n", dev->nam=
e);
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

