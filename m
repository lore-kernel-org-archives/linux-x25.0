From: Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH net] net/x25: Fix null-ptr-deref caused by x25_disconnect
Date: Sat, 26 Mar 2022 14:59:12 +0800
Message-ID: <20220326065912.41077-1-duoming@zju.edu.cn>
Return-path: <netdev-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, tanxin.ctf@gmail.com, linma@zju.edu.cn, xiyuyang19@fudan.edu.cn, Duoming Zhou <duoming@zju.edu.cn>

The previous commit 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when
x25 disconnect") adds decrement of refcount of x25->neighbour and sets
x25->neighbour to NULL in x25_disconnect(), but when the link layer is
terminating, it could cause null-ptr-deref bugs in x25_sendmsg(),
x25_recvmsg() and x25_connect(). One of the bugs is shown below.

x25_link_terminated()          | x25_recvmsg()
 x25_kill_by_neigh()           |  ...
  x25_disconnect()             |  lock_sock(sk)
   ...                         |  ...
   x25->neighbour = NULL //(1) |
   ...                         |  x25->neighbour->extended //(2)

We set NULL to x25->neighbour in position (1) and dereference
x25->neighbour in position (2), which could cause null-ptr-deref bug.

This patch adds lock_sock(sk) in x25_disconnect() in order to synchronize
with x25_sendmsg(), x25_recvmsg() and x25_connect(). What`s more, the sk
held by lock_sock() is not NULL, because it is extracted from x25_list
and uses x25_list_lock to synchronize.

Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconnect")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 net/x25/x25_subr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
index 0285aaa1e93..4e19752bdd0 100644
--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -360,7 +360,9 @@ void x25_disconnect(struct sock *sk, int reason, unsigned char cause,
 	if (x25->neighbour) {
 		read_lock_bh(&x25_list_lock);
 		x25_neigh_put(x25->neighbour);
+		lock_sock(sk);
 		x25->neighbour = NULL;
+		release_sock(sk);
 		read_unlock_bh(&x25_list_lock);
 	}
 }
-- 
2.17.1

