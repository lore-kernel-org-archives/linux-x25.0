From: Elena Reshetova <elena.reshetova@intel.com>
Subject: [PATCH 05/18] net, bluetooth: convert rfcomm_dlc.refcnt from atomic_t to refcount_t
Date: Fri, 17 Mar 2017 13:12:46 +0200
Message-ID: <1489749179-12063-6-git-send-email-elena.reshetova@intel.com>
References: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=intel;
  t=1489749228; x=1521285228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=RtLsxPtknQ/AxY0coG6R7cHKi3p1PW5dFIqOEa1Bl7s=;
  b=u+34CM+64IZbc3kMnIc/ALEFOBG00hVKO98nPCfg2QwrVFbriYOEtUvd
   p8cjxatxH3oWUF2LUPiOTHSOieXKgA==;
In-Reply-To: <1489749179-12063-1-git-send-email-elena.reshetova@intel.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-decnet-user@lists.sourceforge.net, davem@davemloft.net, jmorris@namei.org, kaber@trash.net, yoshfuji@linux-ipv6.org, kuznet@ms2.inr.ac.ru, 3chas3@gmail.com, ralf@linux-mips.org, stephen@networkplumber.org, jchapman@katalix.com, jhs@mojatatu.com, bridge@lists.linux-foundation.org, linux-hams@vger.kernel.org, linux-x25@vger.kernel.org, linux-bluetooth@vger.kernel.org, marcel@holtmann.org, johan.hedberg@gmail.com, peterz@infradead.org, keescook@chromium.org, Elena Reshetova <elena.reshetova@intel.com>, Hans Liljestrand <ishkamiel@gmail.com>, David Windsor <dwindsor@gmail.com>

refcount_t type and corresponding API should be
used instead of atomic_t when the variable is used as
a reference counter. This allows to avoid accidental
refcounter overflows that might lead to use-after-free
situations.

Signed-off-by: Elena Reshetova <elena.reshetova@intel.com>
Signed-off-by: Hans Liljestrand <ishkamiel@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/net/bluetooth/rfcomm.h | 8 +++++---
 net/bluetooth/rfcomm/core.c    | 4 ++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 4190af5..da4acef 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -21,6 +21,8 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <linux/refcount.h>
+
 #ifndef __RFCOMM_H
 #define __RFCOMM_H
 
@@ -174,7 +176,7 @@ struct rfcomm_dlc {
 	struct mutex  lock;
 	unsigned long state;
 	unsigned long flags;
-	atomic_t      refcnt;
+	refcount_t    refcnt;
 	u8            dlci;
 	u8            addr;
 	u8            priority;
@@ -247,12 +249,12 @@ struct rfcomm_dlc *rfcomm_dlc_exists(bdaddr_t *src, bdaddr_t *dst, u8 channel);
 
 static inline void rfcomm_dlc_hold(struct rfcomm_dlc *d)
 {
-	atomic_inc(&d->refcnt);
+	refcount_inc(&d->refcnt);
 }
 
 static inline void rfcomm_dlc_put(struct rfcomm_dlc *d)
 {
-	if (atomic_dec_and_test(&d->refcnt))
+	if (refcount_dec_and_test(&d->refcnt))
 		rfcomm_dlc_free(d);
 }
 
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index f7eb02f..8ebca90 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -311,7 +311,7 @@ struct rfcomm_dlc *rfcomm_dlc_alloc(gfp_t prio)
 
 	skb_queue_head_init(&d->tx_queue);
 	mutex_init(&d->lock);
-	atomic_set(&d->refcnt, 1);
+	refcount_set(&d->refcnt, 1);
 
 	rfcomm_dlc_clear_state(d);
 
@@ -342,7 +342,7 @@ static void rfcomm_dlc_unlink(struct rfcomm_dlc *d)
 {
 	struct rfcomm_session *s = d->session;
 
-	BT_DBG("dlc %p refcnt %d session %p", d, atomic_read(&d->refcnt), s);
+	BT_DBG("dlc %p refcnt %d session %p", d, refcount_read(&d->refcnt), s);
 
 	list_del(&d->list);
 	d->session = NULL;
-- 
2.7.4

