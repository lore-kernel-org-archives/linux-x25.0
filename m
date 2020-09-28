From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH] net/x25: Fix null-ptr-deref in x25_connect
Date: Mon, 28 Sep 2020 11:23:27 +0200
Message-ID: <20200928092327.329-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, edumazet@google.com, xiyuyang19@fudan.edu.cn
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

This fixes a regression for blocking connects introduced by commit
4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconnect").

The x25->neighbour is already set to "NULL" by x25_disconnect() now,
while a blocking connect is waiting in
x25_wait_for_connection_establishment(). Therefore x25->neighbour must
not be accessed here again and x25->state is also already set to
X25_STATE_0 by x25_disconnect().

Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconn=
ect")
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 0bbb283f23c9..0524a5530b91 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -820,7 +820,7 @@ static int x25_connect(struct socket *sock, struct so=
ckaddr *uaddr,
=20
 	rc =3D x25_wait_for_connection_establishment(sk);
 	if (rc)
-		goto out_put_neigh;
+		goto out;
=20
 	sock->state =3D SS_CONNECTED;
 	rc =3D 0;
--=20
2.20.1

