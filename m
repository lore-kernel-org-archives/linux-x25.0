From: Hyunwoo Kim <v4bel@theori.io>
Subject: [PATCH] net/x25: Fix to not accept on connected socket
Date: Sun, 22 Jan 2023 09:09:25 -0800
Message-ID: <20230122170925.GA98061@ubuntu>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9q3bR3q+jWpwQUPs7WwVJoC9NtlmUNwWWj9tISIL2ek=;
        b=ATAdwDoDC7PqzkIZxzVrLoyWt+CINbQhif10ufrC4VDHtyOzZUf/K01MYx+ZlN9FF7
         ztVrJSFVSJesS+G/Mc5Zm7fDaaDKSQJ5pUMn/MtGZ8TMdRNMTgaR5zgUpd5QmQDNxctf
         m0q+nAk7B0GqRhpOQBc7+Owh1ktZKg7vz5QUY=
Content-Disposition: inline
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: v4bel@theori.io, imv4bel@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

When listen() and accept() are called on an x25 socket
that connect() succeeds, accept() succeeds immediately.
This is because x25_connect() queues the skb to
sk->sk_receive_queue, and x25_accept() dequeues it.

This creates a child socket with the sk of the parent
x25 socket, which can cause confusion.

Fix x25_listen() to return -EINVAL if the socket has
already been successfully connect()ed to avoid this issue.

Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
---
 net/x25/af_x25.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 3b55502b2965..4407a625daa6 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -482,6 +482,12 @@ static int x25_listen(struct socket *sock, int backlog)
 	int rc = -EOPNOTSUPP;
 
 	lock_sock(sk);
+	if (sock->state == SS_CONNECTED) {
+		rc = -EINVAL;
+		release_sock(sk);
+		return rc;
+	}
+
 	if (sk->sk_state != TCP_LISTEN) {
 		memset(&x25_sk(sk)->dest_addr, 0, X25_ADDR_LEN);
 		sk->sk_max_ack_backlog = backlog;
-- 
2.25.1

