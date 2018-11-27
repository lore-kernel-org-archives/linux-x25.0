From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 2/3] net/x25: fix null_x25_address handling
Date: Tue, 27 Nov 2018 09:50:28 +0100
Message-ID: <20181127085029.9589-2-ms@dev.tdt.de>
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

 o x25_find_listener(): the compare for the null_x25_address was wrong.
   We have to check the x25_addr of the listener socket instead of the
   x25_addr of the incomming call.

 o x25_bind(): it was not possible to bind a socket to null_x25_address

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 5226a7f43050..5121729b8b63 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -288,7 +288,7 @@ static struct sock *x25_find_listener(struct x25_address *addr,
 	sk_for_each(s, &x25_list)
 		if ((!strcmp(addr->x25_addr,
 			x25_sk(s)->source_addr.x25_addr) ||
-				!strcmp(addr->x25_addr,
+				!strcmp(x25_sk(s)->source_addr.x25_addr,
 					null_x25_address.x25_addr)) &&
 					s->sk_state == TCP_LISTEN) {
 			/*
@@ -688,11 +688,15 @@ static int x25_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		goto out;
 	}
 
-	len = strlen(addr->sx25_addr.x25_addr);
-	for (i = 0; i < len; i++) {
-		if (!isdigit(addr->sx25_addr.x25_addr[i])) {
-			rc = -EINVAL;
-			goto out;
+	/* check for the null_x25_address */
+	if (strcmp(addr->sx25_addr.x25_addr, null_x25_address.x25_addr)) {
+
+		len = strlen(addr->sx25_addr.x25_addr);
+		for (i = 0; i < len; i++) {
+			if (!isdigit(addr->sx25_addr.x25_addr[i])) {
+				rc = -EINVAL;
+				goto out;
+			}
 		}
 	}
 
-- 
2.11.0

