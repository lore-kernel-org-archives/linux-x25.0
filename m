From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v6 4/5] net/x25: fix restart request/confirm handling
Date: Tue, 24 Nov 2020 10:39:37 +0100
Message-ID: <20201124093938.22012-5-ms@dev.tdt.de>
References: <20201124093938.22012-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20201124093938.22012-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

We have to take the actual link state into account to handle
restart requests/confirms well.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/x25_link.c | 41 +++++++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index 11e868aa625d..f92073f3cb11 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -74,16 +74,43 @@ void x25_link_control(struct sk_buff *skb, struct x25=
_neigh *nb,
=20
 	switch (frametype) {
 	case X25_RESTART_REQUEST:
-		confirm =3D !x25_t20timer_pending(nb);
-		x25_stop_t20timer(nb);
-		nb->state =3D X25_LINK_STATE_3;
-		if (confirm)
+		switch (nb->state) {
+		case X25_LINK_STATE_2:
+			confirm =3D !x25_t20timer_pending(nb);
+			x25_stop_t20timer(nb);
+			nb->state =3D X25_LINK_STATE_3;
+			if (confirm)
+				x25_transmit_restart_confirmation(nb);
+			break;
+		case X25_LINK_STATE_3:
+			/* clear existing virtual calls */
+			x25_kill_by_neigh(nb);
+
 			x25_transmit_restart_confirmation(nb);
+			break;
+		}
 		break;
=20
 	case X25_RESTART_CONFIRMATION:
-		x25_stop_t20timer(nb);
-		nb->state =3D X25_LINK_STATE_3;
+		switch (nb->state) {
+		case X25_LINK_STATE_2:
+			if (x25_t20timer_pending(nb)) {
+				x25_stop_t20timer(nb);
+				nb->state =3D X25_LINK_STATE_3;
+			} else {
+				x25_transmit_restart_request(nb);
+				x25_start_t20timer(nb);
+			}
+			break;
+		case X25_LINK_STATE_3:
+			/* clear existing virtual calls */
+			x25_kill_by_neigh(nb);
+
+			x25_transmit_restart_request(nb);
+			nb->state =3D X25_LINK_STATE_2;
+			x25_start_t20timer(nb);
+			break;
+		}
 		break;
=20
 	case X25_DIAGNOSTIC:
@@ -214,8 +241,6 @@ void x25_link_established(struct x25_neigh *nb)
 {
 	switch (nb->state) {
 	case X25_LINK_STATE_0:
-		nb->state =3D X25_LINK_STATE_2;
-		break;
 	case X25_LINK_STATE_1:
 		x25_transmit_restart_request(nb);
 		nb->state =3D X25_LINK_STATE_2;
--=20
2.20.1

