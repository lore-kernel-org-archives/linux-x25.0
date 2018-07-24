From: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
Subject: [PATCH PATCH net-next 06/18] xfrm: remove blank lines at EOF
Date: Tue, 24 Jul 2018 12:29:06 -0700
Message-ID: <20180724192918.31165-7-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sazKkNhpO0O5LBK6G8bOBIuXeRVsGuXdH3mGT0Gi4BQ=;
        b=XVm9C9YDiHH4qZQACjO1Rd/M6FeIVbVzsEFVUVuPuTjc0sLkNY8om3APRpiYNeCvDW
         A/gtvhGif8fCeJmQ7stHFW2BeYvEsmIkGw7jJrq1/0EzAhEvHKsp8LjkhKRLpWuh/WZG
         ln8ahxjhAX68FIvSGh7PBHW1Pa11agVJnnUNhiGYfXUklC0Yk3Dd7tOafFIu/i7bLUrL
         MvlqvbF2LPFH6sCe4lTKYUTY0wtd3b/JOt3f3j6xXYwWse/GlW1qbnMYFCaB0sH0u53B
         AKdvItpepc0Ixub9fSFnB0XJl9W1sUiL3o0iqJ2XvyaMyFm6gqczuuh4ZdRJ5OAU03A7
         xZvA==
In-Reply-To: <20180724192918.31165-1-sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org, ericvh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, rminnich-4OHPYypu0djtX7QSmKvirg@public.gmane.org, lucho-OnYtXJJ0/fesTnJN9+BGXg@public.gmane.org, ralf-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org, jreuter-K7Hl1MveuGQ@public.gmane.org, pablo-Cap9r6Oaw4JrovVCs/uTlw@public.gmane.org, kadlec-K40Dz/62t/MgiyqX0sVFJYdd74u8MsAO@public.gmane.org, fw-HFFVJYpyMKqzQB+pC5nmwQ@public.gmane.org, alex.aring-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, stefan-OrPQZGeq07wqhVmZOOOmNx2eb7JE58TQ@public.gmane.org, kuznet-v/Mj1YrvjDBInbfyfbPRSQ@public.gmane.org, yoshfuji-VfPWfsRibaP+Ru+s062T9g@public.gmane.org, johannes-cdvu00un1VgdHxzADdlk8Q@public.gmane.org, jhs-jkUAjuhPggJWk0Htik3J/w@public.gmane.org, xiyou.wangcong-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jiri-rHqAuBHg3fBzbRFIqnYvSA@public.gmane.org, vyasevich-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, nhorman-2XuSBdqkA4R54TAoqtyWWQ@public.gmane.org, marcelo.leitner-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, trond.myklebust-F/q8l9xzQnoyLce1RVWEUA@public.gmane.org, anna.schumaker-HgOvQuBEEgTQT0dZR+AlfA@public.gmane.org, steffen.klassert-opNxpl+3fjRBDgjK7y7TUQ@public.gmane.org, herbert-lOAM2aK0SrRLBo1qDEOMRrpzq4S04n8Q@public.gmane.org
Cc: netdev-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, v9fs-developer-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-hams-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-decnet-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, netfilter-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, coreteam-Cap9r6Oaw4JrovVCs/uTlw@public.gmane.org, linux-wpan-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-s390-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sctp-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-x25-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>

Signed-off-by: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
---
 net/xfrm/Kconfig     | 1 -
 net/xfrm/xfrm_user.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/net/xfrm/Kconfig b/net/xfrm/Kconfig
index 286ed25c1a69..eab952cca7d0 100644
--- a/net/xfrm/Kconfig
+++ b/net/xfrm/Kconfig
@@ -87,4 +87,3 @@ config NET_KEY_MIGRATE
 	  <draft-sugimoto-mip6-pfkey-migrate>.
 
 	  If unsure, say N.
-
diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 080035f056d9..09cceab450b8 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3280,4 +3280,3 @@ module_init(xfrm_user_init);
 module_exit(xfrm_user_exit);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_NET_PF_PROTO(PF_NETLINK, NETLINK_XFRM);
