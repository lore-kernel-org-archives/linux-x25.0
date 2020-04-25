From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH v2] net/x25: Fix x25_neigh refcnt leak when x25 disconnect
Date: Sat, 25 Apr 2020 21:06:25 +0800
Message-ID: <1587819994-40137-1-git-send-email-xiyuyang19@fudan.edu.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=mWFjwvcAfXgLbxUP3xHE2jVdSD94EmPgOkeX90eA2Ok=; b=3
        Nq82/7A27IoxgVywwfFSJsUywySGmqGqO4tCB1cLkMK5Dd+7O524Ce+7laBdO5pq
        JOPYdcwP5uGODiyp7mtTfdntyvTl6dcPUnL7IGTUl79RXSWuETgBKjYkaf1CopdZ
        CLia/QIRNL7epNO0KrOoGZXePNzM8Uo2twuxfLLHxU=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu

x25_connect() invokes x25_get_neigh(), which returns a reference of the
specified x25_neigh object to "x25->neighbour" with increased refcnt.

When x25 connect success and returns, the reference still be hold by
"x25->neighbour", so the refcount should be decreased in
x25_disconnect() to keep refcount balanced.

The reference counting issue happens in x25_disconnect(), which forgets
to decrease the refcnt increased by x25_get_neigh() in x25_connect(),
causing a refcnt leak.

Fix this issue by calling x25_neigh_put() before x25_disconnect()
returns.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
Changes in v2:
- Fix x25_neigh refcnt leak in x25_disconnect() rather than in
x25_connect()
---
 net/x25/x25_subr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
index 8aa415a38814..8b1b06cabcbf 100644
--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -357,6 +357,10 @@ void x25_disconnect(struct sock *sk, int reason, unsigned char cause,
 		sk->sk_state_change(sk);
 		sock_set_flag(sk, SOCK_DEAD);
 	}
+	read_lock_bh(&x25_list_lock);
+	x25_neigh_put(x25->neighbour);
+	x25->neighbour = NULL;
+	read_unlock_bh(&x25_list_lock);
 }
 
 /*
-- 
2.7.4

