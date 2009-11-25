From: andrew hendry <andrew.hendry@gmail.com>
Subject: [PATCH 2/3] X25: Check for errors in x25_init
Date: Wed, 25 Nov 2009 12:15:42 +1100
Message-ID: <d45a3acc0911241715k6882aa3el64a50b3d68d12167@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=JEpJbNu2JbOGzdlbcPEX5L6zGUghvTg0dzOJQfnblMA=;
        b=BjtplCNQlH5iRHP7g9L1Et0LqhuenUR9x/Q5HbC4Jz2un1k7nh+m37M0aWmgbvKpAj
         J2u+Iqy1bg6i9S4AT9SPrTULB4JOnEF0BuWStLd1Y8MVQ1D1cpzwmtIPMJlrbsrx+ZpN
         eUzJ28QyykqSL+3KfcQ03LXE6jPyhVlVkjwIM=
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-x25@vger.kernel.org

Adds error checking to x25_init.

Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

diff -uprN -X a/Documentation/dontdiff a/net/x25/af_x25.c b/net/x25/af_x25.c
--- a/net/x25/af_x25.c  2009-11-25 10:21:17.000000000 +1100
+++ b/net/x25/af_x25.c  2009-11-25 10:22:06.000000000 +1100
@@ -1659,18 +1659,31 @@ static int __init x25_init(void)
 	if (rc != 0)
 		goto out;

-	sock_register(&x25_family_ops);
+	rc = sock_register(&x25_family_ops);
+	if (rc != 0)
+		goto out_proto;

 	dev_add_pack(&x25_packet_type);

-	register_netdevice_notifier(&x25_dev_notifier);
+	rc = register_netdevice_notifier(&x25_dev_notifier);
+	if (rc != 0)
+		goto out_sock;

 	printk(KERN_INFO "X.25 for Linux Version 0.2\n");

 	x25_register_sysctl();
-	x25_proc_init();
+	rc = x25_proc_init();
+	if (rc != 0)
+		goto out_dev;
 out:
 	return rc;
+out_dev:
+	unregister_netdevice_notifier(&x25_dev_notifier);
+out_sock:
+	sock_unregister(AF_X25);
+out_proto:
+	proto_unregister(&x25_proto);
+	goto out;
 }
 module_init(x25_init);
