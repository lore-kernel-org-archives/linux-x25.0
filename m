From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.15 10/12] net/x25: Fix to not accept on connected socket
Date: Tue, 31 Jan 2023 10:00:28 -0500
Message-ID: <20230131150030.1250104-10-sashal@kernel.org>
References: <20230131150030.1250104-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675177248;
        bh=31PGigVaWwsYxdx0F+/sk0jL4EAU83tF/tnCicsEiYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6YcLnKSzXabknbYXZNOTC722baf/3znSvSJeJZ0ZvrLxV0+TUNN0HQfEAvwjbaH/
         I9g/obPwWSJQBx1V+YBOvMfLh+rh2N9Ai76dGQKkCi7zj+8c/TqYd0xbHKlhIEV1K4
         bAbT1XmZMP3oKaXd8la1XNIJA39X5SPJ7z5JMQ08zx8I9eBl6HjUiU1CpWSf04Ja/n
         +IdSnfV+VTMkCs6lJVK+Yr/qP6RfIfnK5mF4z8WLHxWitAbiFVIutZU7if0s7S0/bq
         +SETBimdNULx9Tcrl+IrN2DAfmc3T2BeFD0Y0b5Lt/ckB9OWRjKv0MdJ6650JusRjX
         kZjCYseLeRwyA==
In-Reply-To: <20230131150030.1250104-1-sashal@kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Hyunwoo Kim <v4bel@theori.io>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, ms@dev.tdt.de, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

From: Hyunwoo Kim <v4bel@theori.io>

[ Upstream commit f2b0b5210f67c56a3bcdf92ff665fb285d6e0067 ]

When listen() and accept() are called on an x25 socket
that connect() succeeds, accept() succeeds immediately.
This is because x25_connect() queues the skb to
sk->sk_receive_queue, and x25_accept() dequeues it.

This creates a child socket with the sk of the parent
x25 socket, which can cause confusion.

Fix x25_listen() to return -EINVAL if the socket has
already been successfully connect()ed to avoid this issue.

Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/af_x25.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 3a171828638b..07f6206e7cb4 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -482,6 +482,12 @@ static int x25_listen(struct socket *sock, int backlog)
 	int rc = -EOPNOTSUPP;
 
 	lock_sock(sk);
+	if (sock->state != SS_UNCONNECTED) {
+		rc = -EINVAL;
+		release_sock(sk);
+		return rc;
+	}
+
 	if (sk->sk_state != TCP_LISTEN) {
 		memset(&x25_sk(sk)->dest_addr, 0, X25_ADDR_LEN);
 		sk->sk_max_ack_backlog = backlog;
-- 
2.39.0

