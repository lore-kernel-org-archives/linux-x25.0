From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 12/14] net/x25: Return the correct errno code
Date: Mon,  7 Jun 2021 12:16:03 -0400
Message-ID: <20210607161605.3584954-12-sashal@kernel.org>
References: <20210607161605.3584954-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623082581;
        bh=c4tfBSDu/8Sb9YNPIcdis5klrUrezDTAxTa2z/cY31o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYjn3RilH8JM4cbhymb3wZMEoD4Qx1RfPponmIHAJFz9TGvo9lBtKpjWwuuCviVO5
         2s3XSGW9oJEDMHRUzK1PqJDOwZjOs+Jjy4w8SrEaSy3/G5pkQgEeihpgnZ4OVZbVuq
         658VD8jNLzz/WzMp6ZfDBd5cryfX05DOLHiBdaRBI9TsIZgWucVGG5ugNMi12Tkp1v
         +/Qy1a5j8LHS1cAxXt2G1xnaAdHKs6Rk1MEh0YlTANlIT3jz1wzdQP5aKjoR0XbmEh
         imxZTuZb2XxpIEiABc/ExeG3+qONAp/KqP7K8d+2odJQv91Ucc6mBTdEcx7TbMMD3n
         ikCrebyM9CLGg==
In-Reply-To: <20210607161605.3584954-1-sashal@kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Zheng Yongjun <zhengyongjun3@huawei.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org

From: Zheng Yongjun <zhengyongjun3@huawei.com>

[ Upstream commit d7736958668c4facc15f421e622ffd718f5be80a ]

When kalloc or kmemdup failed, should return ENOMEM rather than ENOBUF.

Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index a9fd95d10e84..156639be7ed0 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -550,7 +550,7 @@ static int x25_create(struct net *net, struct socket *sock, int protocol,
 	if (protocol)
 		goto out;
 
-	rc = -ENOBUFS;
+	rc = -ENOMEM;
 	if ((sk = x25_alloc_socket(net, kern)) == NULL)
 		goto out;
 
-- 
2.30.2

