From: Stephen Hemminger <stephen-OTpzqLSitTUnbdJkjeBofR2eb7JE58TQ@public.gmane.org>
Subject: [PATCH PATCH net-next 02/18] wimax: remove blank lines at EOF
Date: Tue, 24 Jul 2018 12:29:02 -0700
Message-ID: <20180724192918.31165-3-sthemmin@microsoft.com>
References: <20180724192918.31165-1-sthemmin@microsoft.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zp5Drt9I2p5aHzigY13eB9/60QPJ3/CxTusrS2FdLtw=;
        b=Eva3mWiU0Bcs35TMbi6/+F/yoNddR5ARTCpyeLBqQwRMoEse4Y+mKR8IT+y6Rs2Vm7
         RSKgs8+VT4aGiBFM0rU2NjjMWmBx041oDalfG/EmlEaDDEvDJ1V823JJtMGb5e+2Eo2c
         JhmNZVJYUaGJxyTjA0tFiTkBha6ZaKt0v2nB0ZF2Y7d/J/8da1PL/QR6xzb3MXYoe/Zr
         rFrHTbX7OghU0S7rLknFQQYvxiulbZHwCt7LEklfTfX8rAvhJoNxfGhkREwVIzYjL8Mu
         RJydwGGoXgY5btxGgL6NZB/8slFeXKBRS/R4Pu8wDBfsEcjPI/JajYUjblTwo7X/qCIQ
         iNmA==
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
 net/wimax/Makefile  | 2 --
 net/wimax/debugfs.c | 2 --
 net/wimax/op-msg.c  | 1 -
 net/wimax/stack.c   | 1 -
 4 files changed, 6 deletions(-)

diff --git a/net/wimax/Makefile b/net/wimax/Makefile
index eb2db0d3b880..c2a71ae487ac 100644
--- a/net/wimax/Makefile
+++ b/net/wimax/Makefile
@@ -11,5 +11,3 @@ wimax-y :=		\
 	stack.o
 
 wimax-$(CONFIG_DEBUG_FS) += debugfs.o
-
-
diff --git a/net/wimax/debugfs.c b/net/wimax/debugfs.c
index 6c9bedb7431e..24514840746e 100644
--- a/net/wimax/debugfs.c
+++ b/net/wimax/debugfs.c
@@ -76,5 +76,3 @@ void wimax_debugfs_rm(struct wimax_dev *wimax_dev)
 {
 	debugfs_remove_recursive(wimax_dev->debugfs_dentry);
 }
-
-
diff --git a/net/wimax/op-msg.c b/net/wimax/op-msg.c
index 54aa146930bd..101b2fa3f32e 100644
--- a/net/wimax/op-msg.c
+++ b/net/wimax/op-msg.c
@@ -404,4 +404,3 @@ int wimax_gnl_doit_msg_from_user(struct sk_buff *skb, struct genl_info *info)
 	d_fnend(3, NULL, "(skb %p info %p) = %d\n", skb, info, result);
 	return result;
 }
-
diff --git a/net/wimax/stack.c b/net/wimax/stack.c
index 73dba9c077bb..a6307813b6d5 100644
--- a/net/wimax/stack.c
+++ b/net/wimax/stack.c
@@ -630,4 +630,3 @@ module_exit(wimax_subsys_exit);
 MODULE_AUTHOR("Intel Corporation <linux-wimax-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>");
 MODULE_DESCRIPTION("Linux WiMAX stack");
 MODULE_LICENSE("GPL");
