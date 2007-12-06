From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH 15/20] net/lapb/lapb_iface.c: use LIST_HEAD instead of LIST_HEAD_INIT
Date: Fri,  7 Dec 2007 00:07:18 +0800
Message-ID: <1196957239-5728-1-git-send-email-crquan@gmail.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755118AbXLFQIJ@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=az1xXqqj+XgHubPhi79/UF2o6kMFrh6KPT8Tp+rjbCE=;
        b=LpI+cPsGsAiHJdrtXKI9sywHyDxdvO3v+soqBIcc2Ls7Gu4KzAsdA22fsVf3+YJ3mAkVygXmUm3RJ0rHEgOnotI373jcZlZAr3ycFpksJYyb27REk/2CZoDvJh9URIAx2XbVBKjoO1TAsOfCMZ7kPi1zyjV2L5uLMDmmJqiKo3Y=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-x25@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org

single list_head variable initialized with LIST_HEAD_INIT could almost
always can be replaced with LIST_HEAD declaration, this shrinks the code
and looks better.

Signed-off-by: Denis Cheng <crquan@gmail.com>
---
 net/lapb/lapb_iface.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index a2e7aa6..2ba1bc4 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -39,7 +39,7 @@
 #include <linux/init.h>
 #include <net/lapb.h>
 
-static struct list_head lapb_list = LIST_HEAD_INIT(lapb_list);
+static LIST_HEAD(lapb_list);
 static DEFINE_RWLOCK(lapb_list_lock);
 
 /*
-- 
1.5.3.4

