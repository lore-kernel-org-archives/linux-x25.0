From: linzhang <xiaolou4617@gmail.com>
Subject: [PATCH] net: x25: fix one potential use-after-free issue
Date: Mon, 15 May 2017 12:12:49 +0800
Message-ID: <1494821569-18572-1-git-send-email-xiaolou4617@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bNgUJnizgpU4F9RaKQdvAH7v0kBkzGrw+xtB7bYxMuo=;
        b=E3/az/PCfU08Wk+kD3dES5shVkskvGtExZm5zYYoytZXeAEryrU4UKc3P6Lmpi8A2f
         l4rboN0xP50L1lmw/MwfNIm0MW5m1e8oWffzznSZzgopfPcvNSxqcGVfPOFWXySjvyUi
         CW6/trzMNj8ysV4kWCvTiJcqkyQuea0qKeQLmzZlPE0Bnx46ZqcdLOJgTm+YlLy4Riny
         WftcA0Ae74U58YzlG1XUrInlT5rNreEQ0d7E6EACtuIpKexkIUMI7O6j3uy8l3sSdTD8
         QPlcyB3TSjQG0DOrgnki9y+DyZ4DkYx6WGCTUcGFDm7qEYA1b6Lc2Fa5hy0EcBl94m0z
         WwnA==
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net
Cc: nhorman@tuxdriver.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linzhang <xiaolou4617@gmail.com>

The function x25_init is not properly unregister related resources
on error handler.It is will result in kernel oops if x25_init init
failed, so add right unregister call on error handler.

Signed-off-by: linzhang <xiaolou4617@gmail.com>
---
 net/x25/af_x25.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 8b911c2..e01e09a 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1811,12 +1811,14 @@ static int __init x25_init(void)
 	x25_register_sysctl();
 	rc = x25_proc_init();
 	if (rc != 0)
-		goto out_dev;
+		goto out_sysctl;
 out:
 	return rc;
-out_dev:
+out_sysctl:
+	x25_unregister_sysctl();
 	unregister_netdevice_notifier(&x25_dev_notifier);
 out_sock:
+	dev_remove_pack(&x25_packet_type);
 	sock_unregister(AF_X25);
 out_proto:
 	proto_unregister(&x25_proto);
-- 
1.8.3.1

