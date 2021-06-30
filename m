From: Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH] net: x25: Optimize the code in {compat_}x25_subscr_ioctl()
Date: Wed, 30 Jun 2021 17:15:21 +0800
Message-ID: <20210630091521.15568-1-yajun.deng@linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1625044532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XtD1Z679yl9jfdfDlft91RCChqPkkEUMqDgoGMpv8Lg=;
        b=kF6VHFFJ3hE/TH1E8BvUplPs7VoEShTZf257Ss0/Lu/kEKgv2nAx/xmMkmIV4szg1D8Xea
        y4GxoF3u0ImYD4K5AaJ1yKIiNmUwujTyKp33caZb1r6v+37FeP7rjH9KAdQD44XlRnk27h
        ZxHTGwrh3AZqfUs/zp4BBdUZFfBqHdo=
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ms@dev.tdt.de, davem@davemloft.net, kuba@kernel.org
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>

Combine the redundant return values, make it more concise.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 net/x25/af_x25.c   | 19 ++++++++-----------
 net/x25/x25_link.c | 21 ++++++++++-----------
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 3583354a7d7f..53c40fc7c1fd 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1625,21 +1625,19 @@ static int compat_x25_subscr_ioctl(unsigned int cmd,
 	struct net_device *dev;
 	int rc = -EINVAL;
 
-	rc = -EFAULT;
-	if (copy_from_user(&x25_subscr, x25_subscr32, sizeof(*x25_subscr32)))
+	if (copy_from_user(&x25_subscr, x25_subscr32, sizeof(*x25_subscr32))) {
+		rc = -EFAULT;
 		goto out;
+	}
 
-	rc = -EINVAL;
 	dev = x25_dev_get(x25_subscr.device);
-	if (dev == NULL)
+	if (!dev)
 		goto out;
 
 	nb = x25_get_neigh(dev);
-	if (nb == NULL)
+	if (!nb)
 		goto out_dev_put;
 
-	dev_put(dev);
-
 	if (cmd == SIOCX25GSUBSCRIP) {
 		read_lock_bh(&x25_neigh_list_lock);
 		x25_subscr.extended = nb->extended;
@@ -1648,7 +1646,6 @@ static int compat_x25_subscr_ioctl(unsigned int cmd,
 		rc = copy_to_user(x25_subscr32, &x25_subscr,
 				sizeof(*x25_subscr32)) ? -EFAULT : 0;
 	} else {
-		rc = -EINVAL;
 		if (x25_subscr.extended == 0 || x25_subscr.extended == 1) {
 			rc = 0;
 			write_lock_bh(&x25_neigh_list_lock);
@@ -1658,11 +1655,11 @@ static int compat_x25_subscr_ioctl(unsigned int cmd,
 		}
 	}
 	x25_neigh_put(nb);
-out:
-	return rc;
+
 out_dev_put:
 	dev_put(dev);
-	goto out;
+out:
+	return rc;
 }
 
 static int compat_x25_ioctl(struct socket *sock, unsigned int cmd,
diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index 5460b9146dd8..01a13ec88ce8 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -360,19 +360,19 @@ int x25_subscr_ioctl(unsigned int cmd, void __user *arg)
 	if (cmd != SIOCX25GSUBSCRIP && cmd != SIOCX25SSUBSCRIP)
 		goto out;
 
-	rc = -EFAULT;
-	if (copy_from_user(&x25_subscr, arg, sizeof(x25_subscr)))
+	if (copy_from_user(&x25_subscr, arg, sizeof(x25_subscr))) {
+		rc = -EFAULT;
 		goto out;
+	}
 
-	rc = -EINVAL;
-	if ((dev = x25_dev_get(x25_subscr.device)) == NULL)
+	dev = x25_dev_get(x25_subscr.device);
+	if (!dev)
 		goto out;
 
-	if ((nb = x25_get_neigh(dev)) == NULL)
+	nb = x25_get_neigh(dev);
+	if (!nb)
 		goto out_dev_put;
 
-	dev_put(dev);
-
 	if (cmd == SIOCX25GSUBSCRIP) {
 		read_lock_bh(&x25_neigh_list_lock);
 		x25_subscr.extended	     = nb->extended;
@@ -381,7 +381,6 @@ int x25_subscr_ioctl(unsigned int cmd, void __user *arg)
 		rc = copy_to_user(arg, &x25_subscr,
 				  sizeof(x25_subscr)) ? -EFAULT : 0;
 	} else {
-		rc = -EINVAL;
 		if (!(x25_subscr.extended && x25_subscr.extended != 1)) {
 			rc = 0;
 			write_lock_bh(&x25_neigh_list_lock);
@@ -391,11 +390,11 @@ int x25_subscr_ioctl(unsigned int cmd, void __user *arg)
 		}
 	}
 	x25_neigh_put(nb);
-out:
-	return rc;
+
 out_dev_put:
 	dev_put(dev);
-	goto out;
+out:
+	return rc;
 }
 
 
-- 
2.32.0

