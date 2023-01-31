From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 6.1 17/20] net/x25: Fix to not accept on connected socket
Date: Tue, 31 Jan 2023 09:59:43 -0500
Message-ID: <20230131145946.1249850-17-sashal@kernel.org>
References: <20230131145946.1249850-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675177218;
        bh=ck5tqw9FEbpJWj1+WLah6xnAqqZGfcEuwF/xC2J1Jhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eu4jMPvd42+wq0Lby1ybUhzVpthIsngykDa69JWCbQ0yA+5mrZDlaVPhqA6RCRovG
         o+Ecwnq5sQ37E+O0qGMJM+un17/o7rRFsIj7I4kGZM2E6g8Wlovh35ZU582Yel7ybw
         pJbD0dK5gTQ6cafQqErNAA7D+9GumaPKCPcVjy8nwAYgVMcr6/2YAHjvOanNbQsf7e
         DwR0IdVb1crPeCPa7Z9zy7Tm4rqixXskK1rGngFo49usizvz1PzhVk2i6K3tR274Fa
         InePjKrssCr21xvxyS5oAD0dnHUecUG4OFxyMqVRSGK9vkD00E9FjrrR5VT6JfcEuV
         YKzZfwLYX1mrQ==
In-Reply-To: <20230131145946.1249850-1-sashal@kernel.org>
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
index 3b55502b2965..5c7ad301d742 100644
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

