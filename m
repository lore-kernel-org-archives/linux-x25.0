From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net] net/x25: fix call timeouts in blocking connects
Date: Fri,  5 Aug 2022 08:18:10 +0200
Message-ID: <20220805061810.10824-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

When a userspace application starts a blocking connect(), a CALL REQUEST
is sent, the t21 timer is started and the connect is waiting in
x25_wait_for_connection_establishment(). If then for some reason the t21
timer expires before any reaction on the assigned logical channel (e.g.
CALL ACCEPT, CLEAR REQUEST), there is sent a CLEAR REQUEST and timer
t23 is started waiting for a CLEAR confirmation. If we now receive a
CLEAR CONFIRMATION from the peer, x25_disconnect() is called in
x25_state2_machine() with reason "0", which means "normal" call
clearing. This is ok, but the parameter "reason" is used as sk->sk_err
in x25_disconnect() and sock_error(sk) is evaluated in
x25_wait_for_connection_establishment() to check if the call is still
pending. As "0" is not rated as an error, the connect will stuck here
forever.

To fix this situation, also check if the sk->sk_state changed form
TCP_SYN_SENT to TCP_CLOSE in the meantime, which is also done by
x25_disconnect().

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 6bc2ac8d8146..3b55502b2965 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -719,6 +719,11 @@ static int x25_wait_for_connection_establishment(str=
uct sock *sk)
 			sk->sk_socket->state =3D SS_UNCONNECTED;
 			break;
 		}
+		rc =3D -ENOTCONN;
+		if (sk->sk_state =3D=3D TCP_CLOSE) {
+			sk->sk_socket->state =3D SS_UNCONNECTED;
+			break;
+		}
 		rc =3D 0;
 		if (sk->sk_state !=3D TCP_ESTABLISHED) {
 			release_sock(sk);
--=20
2.20.1

