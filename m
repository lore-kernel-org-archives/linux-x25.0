From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 1/3] net/x25: fix called/calling length calculation in x25_parse_address_block
Date: Tue, 27 Nov 2018 09:50:27 +0100
Message-ID: <20181127085029.9589-1-ms@dev.tdt.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net
Cc: stephen@networkplumber.org, joe@perches.com, anto.cardace@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

The length of the called and calling address was not calculated
correctly (BCD encoding).

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index d49aa79b7997..5226a7f43050 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -100,7 +100,7 @@ int x25_parse_address_block(struct sk_buff *skb,
 	}
 
 	len = *skb->data;
-	needed = 1 + (len >> 4) + (len & 0x0f);
+	needed = 1 + ((len >> 4) + (len & 0x0f) + 1) / 2;
 
 	if (!pskb_may_pull(skb, needed)) {
 		/* packet is too short to hold the addresses it claims
-- 
2.11.0

