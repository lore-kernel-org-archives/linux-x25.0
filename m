From: =?iso-8859-15?Q?Kelleter=2C_G=FCnther?= <GKelleter@datus.com>
Subject: [PATCH] X.25: Fix address field length calculation
Date: Wed, 2 Oct 2013 11:21:39 +0000
Message-ID: <524C01C3.2020109@datus.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: de-DE
Content-ID: <9495D821795B7D4AA2C6AC4295CE3FAB@datus.local>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "andrew.hendry@gmail.com" <andrew.hendry@gmail.com>
Cc: "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Addresses are BCD encoded, not ASCII. x25_addr_ntoa got it right.

Signed-off-by: Guenther Kelleter <gkelleter@datus.com>
---
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
