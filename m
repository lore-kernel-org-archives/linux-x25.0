From: Hyunwoo Kim <v4bel@theori.io>
Subject: [PATCH v2] net/x25: Fix to not accept on connected socket
Date: Mon, 23 Jan 2023 11:43:23 -0800
Message-ID: <20230123194323.GA116515@ubuntu>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNk47sVvopA8jolI6ev1FyVna1awVNacTBUWQUXG894=;
        b=Dt95o176ZUHFDD2KI5sxqakI2dsdPzkYBhx+O5Vn2QwZywfEdwe7J1Ip2/dD8yxDD7
         Vhu2pfJS7mli+sYSbm094NZYnXUScznqDhiC8ArtxOl/uQwJRM8TVCgqLMUWnX+6BGyp
         UmhOYvCHDPPARRSoQhltwATxFEuDjHo6wzdEs=
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
2.25.1

