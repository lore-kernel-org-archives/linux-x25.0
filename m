From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] net: x25: Correct locking for x25_kill_by_device and x25_kill_by_neigh
Date: Sat, 14 Nov 2020 02:36:25 -0800
Message-ID: <20201114103625.323919-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XAjBGR7iclPjW0tNCUwr8SXUNRUreYnvO/cfmqFTPjo=;
        b=KJW8kXjv9GGD1QrIgTokGsdExtsYBeB6XJbPYn9g45NXqz0fq2+ZiljDO4CIEDs48A
         mLi4SNIL31tO6FkuQcTg1Dh/ntG3xzZZ3UI0hZkgUrVU4BnU77nTggzAVaOViPOKQBUp
         N5q0HhyZh40s7b5qOijNy8W1roDXZEdQAtTzxg2tAvO2saTbUtyS3rO470Wi046NNo4f
         j/NUB/U0Px3H2J+hKjTYvSWAZRRRZV56ME6u2F/M0S9w44gMgwMz4I49ddnEq1e69sDi
         Pmna+X34DU3mTvPdn+XBlFkeE3KCJNWDACZsso2VbgNJTlM+oUFqj3XnexXRXZ7fyMbI
         jdLg==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>
Cc: Xie He <xie.he.0141@gmail.com>

When the x25_connect function and the x25_disconnect function decrease
the refcnt of "x25->neighbour" (struct x25_neigh) and reset this pointer
to NULL, they would hold the x25_list_lock read lock. This is weird,
because x25_list_lock is meant to protect x25_list, and neither the
refcnt of "struct x25_neigh" nor the "x25->neighbour" pointer is related
to x25_list itself.

I checked the commit history. The author who added the locking in
x25_disconnect didn't explain why in the commit message. I think they
probably just copied the code from x25_connect. The author who added
the locking in x25_connect did this probably because he wanted to
protect the code from racing with x25_kill_by_device.

However, I think this is not the correct way to protect from racing
between x25_connect and x25_kill_by_device. The correct way should be
letting x25_kill_by_device hold the appropriate sock lock instead.
For x25_disconnect, holding x25_list_lock not only is incorrect, but also
causes deadlock, because x25_disconnect is called by x25_kill_by_device
with the x25_list_lock write lock held.

For x25_kill_by_neigh, the situation is the same as x25_kill_by_device.

This patch adds correct locking for x25_kill_by_device and
x25_kill_by_neigh, and removes the incorrect locking in x25_connect and
x25_disconnect.

Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconnect")
Fixes: 95d6ebd53c79 ("net/x25: fix use-after-free in x25_device_event()")
Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 net/x25/af_x25.c   | 12 ++++++++----
 net/x25/x25_subr.c |  2 --
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index a10487e7574c..50f043f0c1d0 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -208,9 +208,12 @@ static void x25_kill_by_device(struct net_device *dev)
 
 	write_lock_bh(&x25_list_lock);
 
-	sk_for_each(s, &x25_list)
+	sk_for_each(s, &x25_list) {
+		bh_lock_sock(s);
 		if (x25_sk(s)->neighbour && x25_sk(s)->neighbour->dev == dev)
 			x25_disconnect(s, ENETUNREACH, 0, 0);
+		bh_unlock_sock(s);
+	}
 
 	write_unlock_bh(&x25_list_lock);
 }
@@ -826,10 +829,8 @@ static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
 	rc = 0;
 out_put_neigh:
 	if (rc && x25->neighbour) {
-		read_lock_bh(&x25_list_lock);
 		x25_neigh_put(x25->neighbour);
 		x25->neighbour = NULL;
-		read_unlock_bh(&x25_list_lock);
 		x25->state = X25_STATE_0;
 	}
 out_put_route:
@@ -1773,9 +1774,12 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 
 	write_lock_bh(&x25_list_lock);
 
-	sk_for_each(s, &x25_list)
+	sk_for_each(s, &x25_list) {
+		bh_lock_sock(s);
 		if (x25_sk(s)->neighbour == nb)
 			x25_disconnect(s, ENETUNREACH, 0, 0);
+		bh_unlock_sock(s);
+	}
 
 	write_unlock_bh(&x25_list_lock);
 
diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
index 0285aaa1e93c..6c0f94257f7c 100644
--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -358,10 +358,8 @@ void x25_disconnect(struct sock *sk, int reason, unsigned char cause,
 		sock_set_flag(sk, SOCK_DEAD);
 	}
 	if (x25->neighbour) {
-		read_lock_bh(&x25_list_lock);
 		x25_neigh_put(x25->neighbour);
 		x25->neighbour = NULL;
-		read_unlock_bh(&x25_list_lock);
 	}
 }
 
-- 
2.27.0

