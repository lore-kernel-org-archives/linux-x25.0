From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH PATCH net-next 04/18] llc: fix whitespace issues
Date: Tue, 24 Jul 2018 12:29:04 -0700
Message-ID: <20180724192918.31165-5-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TOG3gbQ0wiKcdP7qol0utTOWrusMvE0orEuqi6Fe9AU=;
        b=15MDCe3GSd9s70r7ENjcNCtu9kY3DpoakkW16tvXVWp1+3qZClYnGMKwHRj8jE6lqf
         HEDW27TKGZlG6WJHOJ4Ur16uI6qPJoxPgxRFpxWG1OAZcyqOQuVWYk0kQ4j4VAt7xnC3
         PCI2SfFzxvGmQaru5NckHsK8dJT5BEB8X4TWBnJqTT0yD/9IoTHXevC5eVp+uHj1KE8M
         pvq/b/cy8CTmohXKAnpfccShcKvzkB9lN+NTHxC3euL22Bq4D8Es3jriHZe2FwWqjAdQ
         GsaJnpujb5cADFqtDUAjxfo/9WqzZGbliAbuVjm3exd6CB94rd8GFtS0+d88KExsIX+t
         aSBw==
In-Reply-To: <20180724192918.31165-1-sthemmin@microsoft.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, ericvh@gmail.com, rminnich@sandia.gov, lucho@ionkov.net, ralf@linux-mips.org, jreuter@yaina.de, pablo@netfilter.org, kadlec@blackhole.kfki.hu, fw@strlen.de, alex.aring@gmail.com, stefan@datenfreihafen.org, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, johannes@sipsolutions.net, jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us, vyasevich@gmail.com, nhorman@tuxdriver.com, marcelo.leitner@gmail.com, trond.myklebust@hammerspace.com, anna.schumaker@netapp.com, steffen.klassert@secunet.com, herbert@gondor.apana.org.au
Cc: netdev@vger.kernel.org, v9fs-developer@lists.sourceforge.net, linux-hams@vger.kernel.org, ceph-devel@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, linux-wireless@vger.kernel.org, linux-rdma@vger.kernel.org, linux-sctp@vger.kernel.org, linux-nfs@vger.kernel.org, linux-x25@vger.kernel.org, Stephen Hemminger <sthemmin@microsoft.com>, Stephen Hemminger <stephen@networkplumber.org>

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/llc/Kconfig  | 2 +-
 net/llc/Makefile | 2 +-
 net/llc/llc_if.c | 1 -
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/llc/Kconfig b/net/llc/Kconfig
index b91c65108162..176a6c1521a5 100644
--- a/net/llc/Kconfig
+++ b/net/llc/Kconfig
@@ -6,5 +6,5 @@ config LLC2
 	tristate "ANSI/IEEE 802.2 LLC type 2 Support"
 	select LLC
 	help
-	  This is a Logical Link Layer type 2, connection oriented support. 
+	  This is a Logical Link Layer type 2, connection oriented support.
 	  Select this if you want to have support for PF_LLC sockets.
diff --git a/net/llc/Makefile b/net/llc/Makefile
index 4e260cff3c5d..5e0ef436daae 100644
--- a/net/llc/Makefile
+++ b/net/llc/Makefile
@@ -4,7 +4,7 @@
 # Copyright (c) 1997 by Procom Technology,Inc.
 #		2001-2003 by Arnaldo Carvalho de Melo <acme@conectiva.com.br>
 #
-# This program can be redistributed or modified under the terms of the 
+# This program can be redistributed or modified under the terms of the
 # GNU General Public License as published by the Free Software Foundation.
 # This program is distributed without any warranty or implied warranty
 # of merchantability or fitness for a particular purpose.
diff --git a/net/llc/llc_if.c b/net/llc/llc_if.c
index 6daf391b3e84..8db03c2d5440 100644
--- a/net/llc/llc_if.c
+++ b/net/llc/llc_if.c
@@ -151,4 +151,3 @@ int llc_send_disc(struct sock *sk)
 	sock_put(sk);
 	return rc;
 }
-
-- 
2.18.0

