From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH PATCH net-next 11/18] atm: remove blank lines at EOF
Date: Tue, 24 Jul 2018 12:29:11 -0700
Message-ID: <20180724192918.31165-12-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DhJZMFDGxjdIUvuf0nMVmYChNNY+1p3oU7KEa+TK9C4=;
        b=QULYg8QYY8AcYxD/YzFhrNyhzvlBN2UPDueIutwEeRPTnSSSSxJbV5eVIYSSSrIlTH
         7ll7/L0nHv73EgsjP/BQtDdTOu1CZH98h5h0gjVJWEov5Vdx+7R0RrfATPh/wv2/dkOT
         GTRRgYZ8I0pkUPXPEgDavNI4MjJuMGKnghzR8+jGd0pefm0Qtx/aEb4c5rsHKgzdh2PQ
         wH4PHN7jZArOlIgSYgn34hUdLtwdqoEaS7YNv00+GJwXvC4bUnfP654eC35B3ZmCi0yJ
         KyjvABH6c9w1IeLhh0rCHTRUztXl/Dw8V5uP6nmxfh6LRJXF/dKmpqdR757RD88ayFU0
         bBUQ==
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
 net/atm/mpoa_proc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/net/atm/mpoa_proc.c b/net/atm/mpoa_proc.c
index b93cc0f18292..46d6cd9a36ae 100644
--- a/net/atm/mpoa_proc.c
+++ b/net/atm/mpoa_proc.c
@@ -307,9 +307,3 @@ void mpc_proc_clean(void)
 }
 
 #endif /* CONFIG_PROC_FS */
-
-
-
-
-
-
-- 
2.18.0

