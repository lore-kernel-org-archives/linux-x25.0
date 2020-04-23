From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Subject: [PATCH] net/x25: Fix x25_neigh refcnt leak when reveiving frame
Date: Thu, 23 Apr 2020 13:13:03 +0800
Message-ID: <1587618786-13481-1-git-send-email-xiyuyang19@fudan.edu.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fudan.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id; bh=00QdfgWbICLjOQqr+eyyelgIderli09+aEykugx5RcA=; b=F
        bnfA7t8ONTH01mN0KCRERzjifAVRWkGUYtSH0ZPEBP6ZxwIoGdY9uwTI50iCFEZq
        xotLnqPIILyeyEa7dEyavkI4erm2hIxwDj7lH3Frz+TrBpDj+cJoVxjIPRadg0/X
        R9m7LIVIKeMCIg/QqetSlBrAIVFfKlxpkXmM0EG3Q4=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>, Allison Randal <allison@lohutok.net>, Xiyu Yang <xiyuyang19@fudan.edu.cn>, Thomas Gleixner <tglx@linutronix.de>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>

x25_lapb_receive_frame() invokes x25_get_neigh(), which returns a
reference of the specified x25_neigh object to "nb" with increased
refcnt.

When x25_lapb_receive_frame() returns, local variable "nb" becomes
invalid, so the refcount should be decreased to keep refcount balanced.

The reference counting issue happens in one path of
x25_lapb_receive_frame(). When pskb_may_pull() returns false, the
function forgets to decrease the refcnt increased by x25_get_neigh(),
causing a refcnt leak.

Fix this issue by calling x25_neigh_put() when pskb_may_pull() returns
false.

Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
---
 net/x25/x25_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/x25/x25_dev.c b/net/x25/x25_dev.c
index 00e782335cb0..25bf72ee6cad 100644
--- a/net/x25/x25_dev.c
+++ b/net/x25/x25_dev.c
@@ -115,8 +115,10 @@ int x25_lapb_receive_frame(struct sk_buff *skb, struct net_device *dev,
 		goto drop;
 	}
 
-	if (!pskb_may_pull(skb, 1))
+	if (!pskb_may_pull(skb, 1)) {
+		x25_neigh_put(nb);
 		return 0;
+	}
 
 	switch (skb->data[0]) {
 
-- 
2.7.4

