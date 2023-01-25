From: Hyunwoo Kim <v4bel@theori.io>
Subject: [PATCH v3] net/x25: Fix to not accept on connected socket
Date: Wed, 25 Jan 2023 03:05:14 -0800
Message-ID: <20230125110514.GA134174@ubuntu>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nHqLQLBY2PL1EUhG5U2fpARyHyDVWwD5R++HQSH4EVE=;
        b=BQJ26mgkeP0qOhRfklqz/8sEoeEBYsU5n8U135dZFifO6+MLofmTgj644Ra9GngvQd
         hGuG4BStw8GjMvvgC8vSg46vs5nz6H21IbCH300zT+u5/VuGPn8obnIS1XmSxWoc2c6h
         ihtqxZ10Myghl8iyudEUDlIgB6kiakFYnGfAY=
Content-Disposition: inline
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com
Cc: v4bel@theori.io, imv4bel@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

If you call listen() and accept() on an already connect()ed
x25 socket, accept() can successfully connect.
This is because when the peer socket sends data to sendmsg,
the skb with its own sk stored in the connected socket's
sk->sk_receive_queue is connected, and x25_accept() dequeues
the skb waiting in the sk->sk_receive_queue.

This creates a child socket with the sk of the parent
x25 socket, which can cause confusion.

Fix x25_listen() to return -EINVAL if the socket has
already been successfully connected, and add lock_sock
to prevent this issue.

Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v1 -> v2 : Change the flag to check to SS_UNCONNECTED
v2 -> v3 : Fix wrong patch description
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

