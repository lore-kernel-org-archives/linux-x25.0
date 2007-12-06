From: Denis Cheng <crquan@gmail.com>
Subject: [PATCH 16/20] net/x25/: use LIST_HEAD instead of LIST_HEAD_INIT
Date: Fri,  7 Dec 2007 00:07:19 +0800
Message-ID: <1196957239-5728-2-git-send-email-crquan@gmail.com>
References: <
 <1196957239-5728-1-git-send-email-crquan@gmail.com>
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=NbKpzHghUXzptn/61lXhQmMTBoKts2krT0D53O3Qwcs=;
        b=eBEclWF6fxE7Iw4oxHSLMf/SRqdj3ymMEWfNgj3IUTrwxlmZCsQbkHI9THULEX2b+EsNZRhCGS9odLIFjI5HGabJnXKbpqmnD7Pp/+RlQn8nlnFwqgUJ2A8b9ErFhZ2pCysMql6VpfDS0EYVRc+xcaF0UjM7d8PAS/RT0ogJw30=
In-Reply-To: <1196957239-5728-1-git-send-email-crquan@gmail.com>
Sender: linux-x25-owner@vger.kernel.org
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
 net/x25/x25_forward.c |    2 +-
 net/x25/x25_link.c    |    2 +-
 net/x25/x25_route.c   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/x25/x25_forward.c b/net/x25/x25_forward.c
index 8738ec7..4dd8ff7 100644
--- a/net/x25/x25_forward.c
+++ b/net/x25/x25_forward.c
@@ -12,7 +12,7 @@
 #include <linux/init.h>
 #include <net/x25.h>
 
-struct list_head x25_forward_list = LIST_HEAD_INIT(x25_forward_list);
+LIST_HEAD(x25_forward_list);
 DEFINE_RWLOCK(x25_forward_list_lock);
 
 int x25_forward_call(struct x25_address *dest_addr, struct x25_neigh *from,
diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index 741ce95..4a3602e 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -30,7 +30,7 @@
 #include <linux/init.h>
 #include <net/x25.h>
 
-static struct list_head x25_neigh_list = LIST_HEAD_INIT(x25_neigh_list);
+static LIST_HEAD(x25_neigh_list);
 static DEFINE_RWLOCK(x25_neigh_list_lock);
 
 static void x25_t20timer_expiry(unsigned long);
diff --git a/net/x25/x25_route.c b/net/x25/x25_route.c
index 86b5b4d..2c999cc 100644
--- a/net/x25/x25_route.c
+++ b/net/x25/x25_route.c
@@ -21,7 +21,7 @@
 #include <linux/init.h>
 #include <net/x25.h>
 
-struct list_head x25_route_list = LIST_HEAD_INIT(x25_route_list);
+LIST_HEAD(x25_route_list);
 DEFINE_RWLOCK(x25_route_list_lock);
 
 /*
-- 
1.5.3.4

