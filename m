From: David Miller <davem@davemloft.net>
Subject: [PATCH]: Consolidate x25 socket grafting.
Date: Tue, 17 Jun 2008 02:46:27 -0700 (PDT)
Message-ID: <20080617.024627.30166722.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: eis@baty.hanse.de
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, ralf@linux-mips.org, linux-hams@vger.kernel.org


This is the x25 variant of the previous 3 radio protocol
patches I just posted to netdev and linux-hams.

Applied and pushed out to net-next-2.6

x25: Use sock_graft() and remove bogus sk_socket and sk_sleep init.

This is the x25 variant of changeset
9375cb8a1232d2a15fe34bec4d3474872e02faec
("ax25: Use sock_graft() and remove bogus sk_socket and sk_sleep init.")

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 net/x25/af_x25.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 6ba67c5..bcb091f 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -555,13 +555,11 @@ static struct sock *x25_make_new(struct sock *osk)
 	x25 = x25_sk(sk);
 
 	sk->sk_type        = osk->sk_type;
-	sk->sk_socket      = osk->sk_socket;
 	sk->sk_priority    = osk->sk_priority;
 	sk->sk_protocol    = osk->sk_protocol;
 	sk->sk_rcvbuf      = osk->sk_rcvbuf;
 	sk->sk_sndbuf      = osk->sk_sndbuf;
 	sk->sk_state       = TCP_ESTABLISHED;
-	sk->sk_sleep       = osk->sk_sleep;
 	sk->sk_backlog_rcv = osk->sk_backlog_rcv;
 	sock_copy_flags(sk, osk);
 
@@ -808,14 +806,12 @@ static int x25_accept(struct socket *sock, struct socket *newsock, int flags)
 	if (!skb->sk)
 		goto out2;
 	newsk		 = skb->sk;
-	newsk->sk_socket = newsock;
-	newsk->sk_sleep  = &newsock->wait;
+	sock_graft(newsk, newsock);
 
 	/* Now attach up the new socket */
 	skb->sk = NULL;
 	kfree_skb(skb);
 	sk->sk_ack_backlog--;
-	newsock->sk    = newsk;
 	newsock->state = SS_CONNECTED;
 	rc = 0;
 out2:
-- 
1.5.5.1.308.g1fbb5

