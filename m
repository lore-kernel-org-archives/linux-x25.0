From: Guenther Kelleter <gkelleter@datus.com>
Subject: [PATCH] X.25: Fix address field length calculation
Date: Fri, 18 Oct 2013 14:03:14 +0200
Message-ID: <1382097794-14547-1-git-send-email-gkelleter@datus.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net
Cc: Guenther Kelleter <gkelleter@datus.com>, linux-x25@vger.kernel.org, linux-netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Addresses are BCD encoded, not ASCII. x25_addr_ntoa got it right.

Signed-off-by: Guenther Kelleter <gkelleter@datus.com>
---
Wrong length calculation leads to rejection of CALL ACCEPT packets.

(patch resubmitted without corruption by stupid thunderbird. grrrr.)

 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 45a3ab5..2daf224 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -98,7 +98,7 @@ int x25_parse_address_block(struct sk_buff *skb,
 	}
 
 	len = *skb->data;
-	needed = 1 + (len >> 4) + (len & 0x0f);
+	needed = 1 + ((len >> 4) + (len & 0x0f) + 1) / 2;
 
 	if (!pskb_may_pull(skb, needed)) {
 		/* packet is too short to hold the addresses it claims
-- 
1.8.3.4.71.g0878476
