From: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH PATCH net-next 09/18] ila: remove blank lines at EOF
Date: Tue, 24 Jul 2018 12:29:09 -0700
Message-ID: <20180724192918.31165-10-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3/QWwqgSZfwyvbFUD4Vysk9Jr8+lwnm/c0FesCTJSmI=;
        b=IviTOGTrMSrRG6NfWEyUyaBU2J5BQ/U5zEYUNROu32zrpz8UuAgDw/NEbwgIW8gR+8
         17j+sU/J+psH6n3jCB3X8vfjrdKGTzN566iXJkeIAE5E0E6/ahVIQ6snIK1mfA37NglO
         Uo4LJDG8AMtkOwopdp8Tu3lEVu7PXUVDu9BydEWYJIAI+Lhyz7WshsQihjXUakI8gWW0
         6770G+qxYL/J18QPSanwsy+HGC8fgg66umW9WYS+Nd/nA0WPKwbBHWmaW9aNdq/m0v7M
         bNRFRyLmX/zCNWBBN289gH96metwrnb+eHK+Iqj3z7gS9S4a0emdzK7KjqQae71kLszB
         yUDA==
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
 net/ipv6/ila/ila_common.c | 1 -
 net/ipv6/ila/ila_xlat.c   | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index 579310466eac..95e9146918cc 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -153,4 +153,3 @@ void ila_update_ipv6_locator(struct sk_buff *skb, struct ila_params *p,
 	/* Now change destination address */
 	iaddr->loc = p->locator;
 }
-
diff --git a/net/ipv6/ila/ila_xlat.c b/net/ipv6/ila/ila_xlat.c
index 51a15ce50a64..17c455ff69ff 100644
--- a/net/ipv6/ila/ila_xlat.c
+++ b/net/ipv6/ila/ila_xlat.c
@@ -663,4 +663,3 @@ static int ila_xlat_addr(struct sk_buff *skb, bool sir2ila)
 
 	return 0;
 }
-
-- 
2.18.0

