From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] net: Cleanup redundant tests on unsigned
Date: Fri, 23 Oct 2009 17:21:56 +0200
Message-ID: <4AE1CA14.10304@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=9sUVy5A5KD2eGpRlFQCLSLN7EsRcUGM0mRaU3WdBUBg=;
        b=ZRD4w7mM2BUgc+iCN3CoL3mFbPQ1exXKKs6byhzE7GNbAbh/z0bKVp6kYfKRNMo5fe
         lIsVGo6bn4fxV9FY3CAYq8jY8WQ2QS4OWAylvBt9DdKMa5gY7rLjbWXgUfl9iLtAKtGU
         ba9Fhti7aOfd+aCoj4E9FJdmFTEq8LpbiU1A4=
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Henner Eisen <eis@baty.hanse.de>, linux-x25@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

If there is data, the unsigned skb->len is greater than 0.

rt.sigdigits is unsigned as well, so the test `>= 0' is
always true, the other part of the test catches wrapped
values.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
 net/x25/x25_in.c    |    2 +-
 net/x25/x25_route.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
index 7d7c3ab..96d9227 100644
--- a/net/x25/x25_in.c
+++ b/net/x25/x25_in.c
@@ -114,7 +114,7 @@ static int x25_state1_machine(struct sock *sk, struct sk_buff *skb, int frametyp
 			/*
 			 *	Copy any Call User Data.
 			 */
-			if (skb->len >= 0) {
+			if (skb->len > 0) {
 				skb_copy_from_linear_data(skb,
 					      x25->calluserdata.cuddata,
 					      skb->len);
diff --git a/net/x25/x25_route.c b/net/x25/x25_route.c
index 2c999cc..66961ea 100644
--- a/net/x25/x25_route.c
+++ b/net/x25/x25_route.c
@@ -190,7 +190,7 @@ int x25_route_ioctl(unsigned int cmd, void __user *arg)
 		goto out;
 
 	rc = -EINVAL;
-	if (rt.sigdigits < 0 || rt.sigdigits > 15)
+	if (rt.sigdigits > 15)
 		goto out;
 
 	dev = x25_dev_get(rt.device);
