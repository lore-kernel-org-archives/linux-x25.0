From: linzhang <xiaolou4617@gmail.com>
Subject: [PATCH net v3] net: x25: fix one potential use-after-free issue
Date: Wed, 17 May 2017 12:05:07 +0800
Message-ID: <1494993907-22727-1-git-send-email-xiaolou4617@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=866HpX9gGY1a7knAtA9Em9aSiUHjIy9PDaSAxagrefE=;
        b=pEbNErNb6bnKp3GaxKfXYmgcN9cEe8Ye5hYbky3bOLMhOC+EEaGG7QfTOUJYYd8Vjt
         TO/s5fdslzdFWXK0m2IlY1NXcqaVNutVqFEKowyZx1Gs+Z4BlQZiC4Bb/hcMoXixlefs
         JFKzAkNMT3+VpmA+ZIGXNWkb7GLr1WvGVoQPDqdqDqeSq3XK1xjc6Ui5ojmmdgmmJrFK
         cr68LfIPLblamT4BcjgS8YgJEgl7LnrxL+uwWL5+hOR6MM81n50LnnqjvPIv08AH7s7Q
         JyVKiyixMXS3yCxQDk+vYrUEyuLDHW5w8ThYyVJmjmHpagjHhsRzaSyJ866ZeZ4+tusi
         jPHg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linzhang <xiaolou4617@gmail.com>

The function x25_init is not properly unregister related resources
on error handler.It is will result in kernel oops if x25_init init
failed, so add properly unregister call on error handler.

Also, i adjust the coding style and make x25_register_sysctl properly
return failure.

Signed-off-by: linzhang <xiaolou4617@gmail.com>
---

changelog:

v1 -> v2:
	* make x25_register_sysctl properly return failure

v2 -> v3:
	* keep the same lables as v1
	* fix missing semicolon

---
 include/net/x25.h        |  4 ++--
 net/x25/af_x25.c         | 24 ++++++++++++++++--------
 net/x25/sysctl_net_x25.c |  5 ++++-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index c383aa4..6d30a01 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -298,10 +298,10 @@ int x25_decode(struct sock *, struct sk_buff *, int *, int *, int *, int *,
 
 /* sysctl_net_x25.c */
 #ifdef CONFIG_SYSCTL
-void x25_register_sysctl(void);
+int x25_register_sysctl(void);
 void x25_unregister_sysctl(void);
 #else
-static inline void x25_register_sysctl(void) {};
+static inline int x25_register_sysctl(void) { return 0; };
 static inline void x25_unregister_sysctl(void) {};
 #endif /* CONFIG_SYSCTL */
 
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 8b911c2..5a1a98d 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1791,32 +1791,40 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 
 static int __init x25_init(void)
 {
-	int rc = proto_register(&x25_proto, 0);
+	int rc;
 
-	if (rc != 0)
+	rc = proto_register(&x25_proto, 0);
+	if (rc)
 		goto out;
 
 	rc = sock_register(&x25_family_ops);
-	if (rc != 0)
+	if (rc)
 		goto out_proto;
 
 	dev_add_pack(&x25_packet_type);
 
 	rc = register_netdevice_notifier(&x25_dev_notifier);
-	if (rc != 0)
+	if (rc)
 		goto out_sock;
 
-	pr_info("Linux Version 0.2\n");
+	rc = x25_register_sysctl();
+	if (rc)
+		goto out_dev;
 
-	x25_register_sysctl();
 	rc = x25_proc_init();
-	if (rc != 0)
-		goto out_dev;
+	if (rc)
+		goto out_sysctl;
+
+	pr_info("Linux Version 0.2\n");
+
 out:
 	return rc;
+out_sysctl:
+	x25_unregister_sysctl();
 out_dev:
 	unregister_netdevice_notifier(&x25_dev_notifier);
 out_sock:
+	dev_remove_pack(&x25_packet_type);
 	sock_unregister(AF_X25);
 out_proto:
 	proto_unregister(&x25_proto);
diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index a06dfe1..ba078c8 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -73,9 +73,12 @@
 	{ },
 };
 
-void __init x25_register_sysctl(void)
+int __init x25_register_sysctl(void)
 {
 	x25_table_header = register_net_sysctl(&init_net, "net/x25", x25_table);
+	if (!x25_table_header)
+		return -ENOMEM;
+	return 0;
 }
 
 void x25_unregister_sysctl(void)
-- 
1.8.3.1

