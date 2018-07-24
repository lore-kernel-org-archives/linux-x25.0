From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH PATCH net-next 17/18] l2tp: remove trailing newline
Date: Tue, 24 Jul 2018 12:29:17 -0700
Message-ID: <20180724192918.31165-18-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KPTZgDyt7tM+m3XRYlFoeyNTK/rNpbGnePQK+C7YSOY=;
        b=Rgt7ts4QmSIequB+AUaptVgCcbAv2OFtWFXb8BFGgHjMVixENeon+LlybcjAr736Y/
         slVb0SjdlRGqYiW3qFUHKRvaSrfzwjjTPh97sSPDCzapD+rj6FeOoFzu/SF49yLsyxqF
         d0mAew0Z/vuqsQSpqPnXO/v9qhonTWZKoVdAN3uH+MoLAnDGWArLHHVZn8nQxazsGVgf
         F/QW2rot6XNV7Ns+5/syfnBiU7Ak00VtTaR4BWWG2iq3Nrr3SbghNA68Pj4ocb9khvfS
         8qzH3C16ScVDsGZp3nrMAUTOPgJaNdiDJmCXz1xAO+5RAdu0NXlN3csD+pJeOQUYMXOc
         2Atw==
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
 net/l2tp/l2tp_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 1ea285bad84b..c8fc0f7f0b4b 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1795,4 +1795,3 @@ MODULE_AUTHOR("James Chapman <jchapman@katalix.com>");
 MODULE_DESCRIPTION("L2TP core");
 MODULE_LICENSE("GPL");
 MODULE_VERSION(L2TP_DRV_VERSION);
-
-- 
2.18.0

