From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH] net/x25: add new state X25_STATE_5
Date: Fri,  6 Dec 2019 14:34:18 +0100
Message-ID: <20191206133418.14075-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net
Cc: edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

This is needed, because if the flag X25_ACCPT_APPRV_FLAG is not set on a
socket (manual call confirmation) and the channel is cleared by remote
before the manual call confirmation was sent, this situation needs to
be handled.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 include/net/x25.h |  3 ++-
 net/x25/af_x25.c  |  8 ++++++++
 net/x25/x25_in.c  | 35 +++++++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index ed1acc3044ac..d7d6c2b4ffa7 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -62,7 +62,8 @@ enum {
 	X25_STATE_1,		/* Awaiting Call Accepted */
 	X25_STATE_2,		/* Awaiting Clear Confirmation */
 	X25_STATE_3,		/* Data Transfer */
-	X25_STATE_4		/* Awaiting Reset Confirmation */
+	X25_STATE_4,		/* Awaiting Reset Confirmation */
+	X25_STATE_5		/* Call Accepted / Call Connected pending */
 };
 
 enum {
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index c34f7d077604..2efe44a34644 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -659,6 +659,12 @@ static int x25_release(struct socket *sock)
 			sock_set_flag(sk, SOCK_DEAD);
 			sock_set_flag(sk, SOCK_DESTROY);
 			break;
+
+		case X25_STATE_5:
+			x25_write_internal(sk, X25_CLEAR_REQUEST);
+			x25_disconnect(sk, 0, 0, 0);
+			__x25_destroy_socket(sk);
+			goto out;
 	}
 
 	sock_orphan(sk);
@@ -1054,6 +1060,8 @@ int x25_rx_call_request(struct sk_buff *skb, struct x25_neigh *nb,
 	if (test_bit(X25_ACCPT_APPRV_FLAG, &makex25->flags)) {
 		x25_write_internal(make, X25_CALL_ACCEPTED);
 		makex25->state = X25_STATE_3;
+	} else {
+		makex25->state = X25_STATE_5;
 	}
 
 	/*
diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index f97c43344e95..3f0f42bdd086 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -382,6 +382,38 @@ static int x25_state4_machine(struct sock *sk, struct sk_buff *skb, int frametyp
 	return 0;
 }
 
+/*
+ * State machine for state 5, Call Accepted / Call Connected pending (X25_ACCPT_APPRV_FLAG).
+ * The handling of the timer(s) is in file x25_timer.c
+ * Handling of state 0 and connection release is in af_x25.c.
+ */
+static int x25_state5_machine(struct sock *sk, struct sk_buff *skb, int frametype)
+{
+	struct x25_sock *x25 = x25_sk(sk);
+
+	switch (frametype) {
+
+		case X25_CLEAR_REQUEST:
+			if (!pskb_may_pull(skb, X25_STD_MIN_LEN + 2))
+				goto out_clear;
+
+			x25_write_internal(sk, X25_CLEAR_CONFIRMATION);
+			x25_disconnect(sk, 0, skb->data[3], skb->data[4]);
+			break;
+
+		default:
+			break;
+	}
+
+	return 0;
+
+out_clear:
+	x25_write_internal(sk, X25_CLEAR_REQUEST);
+	x25->state = X25_STATE_2;
+	x25_start_t23timer(sk);
+	return 0;
+}
+
 /* Higher level upcall for a LAPB frame */
 int x25_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 {
@@ -406,6 +438,9 @@ int x25_process_rx_frame(struct sock *sk, struct sk_buff *skb)
 	case X25_STATE_4:
 		queued = x25_state4_machine(sk, skb, frametype);
 		break;
+	case X25_STATE_5:
+		queued = x25_state5_machine(sk, skb, frametype);
+		break;
 	}
 
 	x25_kick(sk);
-- 
2.20.1

