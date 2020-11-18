From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v3 3/6] net/lapb: handle carrier loss correctly
Date: Wed, 18 Nov 2020 14:59:16 +0100
Message-ID: <20201118135919.1447-4-ms@dev.tdt.de>
References: <20201118135919.1447-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20201118135919.1447-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

In case of carrier loss, clear all queues, enter state LABB_STATE_0 and
stop all timers.

By setting rc =3D LAPB_NOTCONNECTED, the upper layer is informed about th=
e
disconnect.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/lapb/lapb_iface.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index 8dd7c420ae93..017bc169c334 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -303,6 +303,18 @@ int lapb_disconnect_request(struct net_device *dev)
 	if (!lapb)
 		goto out;
=20
+	if (!netif_carrier_ok(dev)) {
+		lapb_dbg(0, "(%p) Carrier lost!\n", lapb->dev);
+		lapb_dbg(0, "(%p) S%d -> S0\n", lapb->dev, lapb->state);
+		lapb_clear_queues(lapb);
+		lapb->state =3D LAPB_STATE_0;
+		lapb->n2count =3D 0;
+		lapb_stop_t1timer(lapb);
+		lapb_stop_t2timer(lapb);
+		rc =3D LAPB_NOTCONNECTED;
+		goto out_put;
+	}
+
 	switch (lapb->state) {
 	case LAPB_STATE_0:
 		rc =3D LAPB_NOTCONNECTED;
--=20
2.20.1

