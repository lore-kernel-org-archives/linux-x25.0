From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH PATCH net-next 16/18] bpfilter: remove trailing newline
Date: Tue, 24 Jul 2018 12:29:16 -0700
Message-ID: <20180724192918.31165-17-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GoFzYCL6AKCiidFWMC+RaPVuI0sQbn0sU3yY1mGzcQ0=;
        b=v1dPVb9OX0NbefaFfDACD3f0fln+PgNXJ3RWxQ1DOIWbHmFHBjvIWTe8VT6oruVdwu
         5gAnj3G2wHQdDv4eVLnkNRwfjLBnDwm7+rY1WdsnGFZmAnV4diSe3L7ptdNi9j35t8iy
         saINlz/FL5F1EEAZDhlAHUozSEu+52jvW4lMZdNqEN2mUL/c4WoBN/XD4vOrMbxZGmyR
         7EGytmf9zFOP6CelJmDq0Fl3EZ1z6EjVX1xl4HsAhv9P2krdee57oOc3TMP+FPROD7qB
         HiRiCF3DLmGBgdo54M/JBAsTbAUUdGIYNirRxhy7JE84paVY3LaV2Wko8OAsjIUKBrWL
         xmOA==
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
 net/bpfilter/Kconfig       | 1 -
 net/ipv4/bpfilter/Makefile | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/bpfilter/Kconfig b/net/bpfilter/Kconfig
index 76deb6615883..e558b46596c4 100644
--- a/net/bpfilter/Kconfig
+++ b/net/bpfilter/Kconfig
@@ -13,4 +13,3 @@ config BPFILTER_UMH
 	help
 	  This builds bpfilter kernel module with embedded user mode helper
 endif
-
diff --git a/net/ipv4/bpfilter/Makefile b/net/ipv4/bpfilter/Makefile
index ce262d76cc48..e9e42f99725e 100644
--- a/net/ipv4/bpfilter/Makefile
+++ b/net/ipv4/bpfilter/Makefile
@@ -1,2 +1 @@
 obj-$(CONFIG_BPFILTER) += sockopt.o
-
-- 
2.18.0

