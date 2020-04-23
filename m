From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH 1/2] net/x25: Fix x25_neigh refcnt leak when x25_connect() fails
Date: Thu, 23 Apr 2020 13:13:40 +0800
Message-ID: <1587618822-13544-1-git-send-email-xiyuyang19@fudan.edu.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=Okr1Fx61CqRQHqsqacwoHRH3hW6+tUVcDNggnI32oKg=; b=d
        0l07vLQn/iqIHGeiIzIqKWM8kBpWhg+MvdHKY7v2EDcF//Hk5oALYOkfSecRVwXi
        FsCN01XQfR2iXyb48Hjgcx7k7BCS987yXBbVspQOYy2zLuzHjz41y7qvpMxFTEQt
        umM+TVg/Asdy1G+6CzsI/zM/gCxYkxfIWs/OjjoBzo=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Martin Schiller <ms@dev.tdt.de>, Xiyu Yang <xiyuyang19@fudan.edu.cn>, Eric Dumazet <edumazet@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>

x25_connect() invokes x25_get_neigh(), which returns a reference of the
specified x25_neigh object to "x25->neighbour" with increased refcnt.

When x25_connect() returns, local variable "x25" and "x25->neighbour"
become invalid, so the refcount should be decreased to keep refcount
balanced.

The reference counting issue happens in one exception handling path of
x25_connect(). When sock state is not TCP_ESTABLISHED and its flags
include O_NONBLOCK, the function forgets to decrease the refcnt
increased by x25_get_neigh(), causing a refcnt leak.

Fix this issue by jumping to "out_put_neigh" label when x25_connect()
fails.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index d5b09bbff375..e6571c56209b 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -816,7 +816,7 @@ static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
 	/* Now the loop */
 	rc = -EINPROGRESS;
 	if (sk->sk_state != TCP_ESTABLISHED && (flags & O_NONBLOCK))
-		goto out;
+		goto out_put_neigh;
 
 	rc = x25_wait_for_connection_establishment(sk);
 	if (rc)
-- 
2.7.4

