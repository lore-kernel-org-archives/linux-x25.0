From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 4/4] net/x25: Fix to not accept on connected socket
Date: Tue, 31 Jan 2023 10:01:10 -0500
Message-ID: <20230131150110.1250351-4-sashal@kernel.org>
References: <20230131150110.1250351-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675177277;
        bh=6VKAMSdr/DhUSnG9Acgn9sE28QRU3PIVm0AUGcBbDjM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RPL3wLafx8vRmPS6mUTMTyjAPDEVzL/0Avf1df53dYgdC4ks+jK9IPtw+4h6WYx3D
         lBGklI7Jk8AoTpRVWBR7Qhhi1fB9w4xGvdEUL3ZdIiYjcXQB2RJ7GcZQu16sMXYzbv
         odWqrTutiNLIo35dd6X589shem1BXSk5VQNfX/eXO1rfkZ0LpXkUl2esDs0bgRtJiT
         ItdHl32NpOAjW1/26hwhuKkNBMnUG218/L8fAdd7iqMnd1gT6KPbvZ7h541BLLg9q9
         S4JboLKFrKDmoiTkgnKXZiGkJQM/rUzcVlIItYNJz7pTGgTvEjF8s6a9GHO2O7e23Z
         mYOfRqEorobQw==
In-Reply-To: <20230131150110.1250351-1-sashal@kernel.org>
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
index c94aa587e0c9..43dd489ad6db 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -492,6 +492,12 @@ static int x25_listen(struct socket *sock, int backlog)
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

