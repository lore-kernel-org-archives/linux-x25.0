From: =?UTF-8?q?J=CE=B5an=20Sacren?= <sakiwit@gmail.com>
Subject: [PATCH net-next] net: x25: drop harmless check of !more
Date: Wed,  8 Dec 2021 00:20:25 -0700
Message-ID: <20211208024732.142541-5-sakiwit@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7BIJQrNbvC3Sfrj3cs08TIKsWWE8pnsGwEpOQkIeNTQ=;
        b=iNgLrgO2lyyj6vxqeTpSAwlpYCUYwSlSjSTZS7GHEDo68M2k5PavylSd/HFXX+Z8Wi
         iNKzzTHmYo3QuUR5t1FkZD+SujxkppOIrWYv4L+MdrFekZvh6zMbiDqzmYsBqvV/yMFE
         LUw48epfCfSoRz3wPIs93n9PEigtayN4QoPHu5HBw/vS2hR5p3+DZE45wHhIuyHfK3+2
         wPhQOH3c42Qk+LxRQCfdpA+CW2uhkCll4xNy+2tXRyMdOTlMIdxnEzwyvdCzs9Yequud
         TmH0UcrcaXpPG/Z3vAN+N4DqLEkyPvkJL3NBDjndTnaB1gR9svnomEH9lRfQg8sxQUfc
         RhuA==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ms@dev.tdt.de, davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org

From: Jean Sacren <sakiwit@gmail.com>

'more' is checked first.  When !more is checked immediately after that,
it is always true.  We should drop this check.

Signed-off-by: Jean Sacren <sakiwit@gmail.com>
---
 net/x25/x25_in.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index e1c4197af468..b981a4828d08 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -41,7 +41,7 @@ static int x25_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 		return 0;
 	}
 
-	if (!more && x25->fraglen > 0) {	/* End of fragment */
+	if (x25->fraglen > 0) {	/* End of fragment */
 		int len = x25->fraglen + skb->len;
 
 		if ((skbn = alloc_skb(len, GFP_ATOMIC)) == NULL){
