From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 3/3] net/x25: handle call collisions
Date: Tue, 27 Nov 2018 09:50:29 +0100
Message-ID: <20181127085029.9589-3-ms@dev.tdt.de>
References: <20181127085029.9589-1-ms@dev.tdt.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127085029.9589-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net
Cc: stephen@networkplumber.org, joe@perches.com, anto.cardace@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

If a session in X25_STATE_1 (Awaiting Call Accept) receives a call
request, the session will be closed (x25_disconnect), cause=0x01
(Number Busy) and diag=0x48 (Call Collision) will be set and a clear
request will be send.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/x25_in.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index 3c12cae32001..afb26221d8a8 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -142,6 +142,15 @@ static int x25_state1_machine(struct sock *sk, struct sk_buff *skb, int frametyp
 			sk->sk_state_change(sk);
 		break;
 	}
+	case X25_CALL_REQUEST:
+		/* call collision */
+		x25->causediag.cause      = 0x01;
+		x25->causediag.diagnostic = 0x48;
+
+		x25_write_internal(sk, X25_CLEAR_REQUEST);
+		x25_disconnect(sk, EISCONN, 0x01, 0x48);
+		break;
+
 	case X25_CLEAR_REQUEST:
 		if (!pskb_may_pull(skb, X25_STD_MIN_LEN + 2))
 			goto out_clear;
-- 
2.11.0

