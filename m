From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v3 2/6] net/lapb: fix lapb_connect_request() for DCE
Date: Wed, 18 Nov 2020 14:59:15 +0100
Message-ID: <20201118135919.1447-3-ms@dev.tdt.de>
References: <20201118135919.1447-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201118135919.1447-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

For a DTE interface we should change to state LAPB_STATE_1 and start
sending SABM(E). But for DCE interfaces, we simply should start the
timer t1.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/lapb/lapb_iface.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index 3c03f6512c5f..8dd7c420ae93 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -278,10 +278,14 @@ int lapb_connect_request(struct net_device *dev)
 	if (lapb->state =3D=3D LAPB_STATE_3 || lapb->state =3D=3D LAPB_STATE_4)
 		goto out_put;
=20
-	lapb_establish_data_link(lapb);
+	if (lapb->mode & LAPB_DCE) {
+		lapb_start_t1timer(lapb);
+	} else {
+		lapb_establish_data_link(lapb);
=20
-	lapb_dbg(0, "(%p) S0 -> S1\n", lapb->dev);
-	lapb->state =3D LAPB_STATE_1;
+		lapb_dbg(0, "(%p) S0 -> S1\n", lapb->dev);
+		lapb->state =3D LAPB_STATE_1;
+	}
=20
 	rc =3D LAPB_OK;
 out_put:
--=20
2.20.1

