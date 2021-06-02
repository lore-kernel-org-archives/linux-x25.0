From: Zheng Yongjun <zhengyongjun3@huawei.com>
Subject: [PATCH net-next] net/x25: Return the correct errno code
Date: Wed, 2 Jun 2021 22:06:30 +0800
Message-ID: <20210602140630.486073-1-zhengyongjun3@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: ms@dev.tdt.de, davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Zheng Yongjun <zhengyongjun3@huawei.com>

When kalloc or kmemdup failed, should return ENOMEM rather than ENOBUF.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 44d6566dd23e..1816899499ce 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -536,7 +536,7 @@ static int x25_create(struct net *net, struct socket *sock, int protocol,
 	if (protocol)
 		goto out;
 
-	rc = -ENOBUFS;
+	rc = -ENOMEM;
 	if ((sk = x25_alloc_socket(net, kern)) == NULL)
 		goto out;
 
-- 
2.25.1

