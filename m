Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759289;
	b=WB8BUxA23a09/zx49LefBsGfghr97MibcuCpPcLSkNYh0wprG3zreOku41A1t68N6LZn
	 Dzeh+DJ5Uy6QN0HkqGejVKHMll9f/UmRs+ElAeVEiIyD22VwLydMErXkJK4TphR3f7j8p
	 oSeF2lyyWpH/0tWGpGkai5nqi8OQV3G28X+fnx6HeyA+SjUu2VN52sXeN0UfvsKL1nG9U
	 nlWHJxIcNBuFGSjqF5drdsXDicLHQueDalTv+DUExDXCi/XbmfsA9OHQl8ZbVt6gY5lBZ
	 hO/1hDuK9vyT7Rg382Tk2g7IaKPD3iDNQmjQiACzeoe+LXFJ3iMDep6TVK0xaj+SheQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759289;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=+YDG5KwrUVea+LaUfWinEfGxdL08ft+A2mCkARsXnrE=;
	b=H4Jy7H8/e+mXSPW6IyJleGmJ0fgicAsY2G+pNum25RFm9rJNRfNFw8blirOMiQSXzd+3
	 cV+BU9WB/1bkYWWDiO46hte2Ndoz1Nv5LTrmOqO4PR7FnvTZB0n+b4KAA00s0p0gN7nS9
	 VuVBib4xXy4h4+YG+6Uacl2Vx77h52zFqHAJ3BVeMhodmGqk73zSrUCy1bS9bCxLSUww2
	 zS+ESokKGVLRrZ+UMfmhp3TAirljfPCWEP5Kbkb/IcuvLGCRCSkqC3PlJtnBJE5R8etOt
	 hDcakccEN2xz9C6abmThaarBATcTtrd3Hr/yAQ6HeAGk/zwulPyvpUP1CZlThP11mLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.21
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C292F606A32D;
	Wed,  4 Nov 2026 02:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C292F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-01 (Coremail) with SMTP id qwCowADH8PozmOpqxJs+AA--.42087S2;
	Wed, 04 Nov 2026 10:28:03 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Martin Schiller <ms@dev.tdt.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-x25@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH] net/x25: release the route on a nonblocking connect
Date: Wed,  4 Nov 2026 02:28:12 +0000
Message-Id: <20261104022812.1484250-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADH8PozmOpqxJs+AA--.42087S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFy3CF4DJw1xJw1DtrWkZwb_yoWkKwc_uF
	nag3y8Xr1UJrWrCa1UKr43Arn7t34DWw1fXr4Ivr4aqry0qry7K39xCw15AF17u3y7WrZ8
	Awn3C34F934IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbsAYjsxI4VWkKwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
	s7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4
	kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI
	0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0Ex4A2jsIE14v26r4UJVWxJr1lOx8S6xCaFVCjc4
	AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxAIw28IcVCjz48v1sIEY20_Gr43Wr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Ar0_tr1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnU
	UI43ZEXa7IUYbiStUUUUU==
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMBA2rqZFjHuAAAsF

x25_connect() takes a reference on the route with x25_get_route() and
drops it at out_put_route.  The nonblocking path after
x25_write_internal() jumps straight to out instead, so the reference
is leaked on every nonblocking connect.

That path cannot use out_put_neigh because the neighbour is still
needed by the pending call, but the route is no longer referenced
once the neighbour has been looked up.

Jump to out_put_route so only the route reference is dropped.

Fixes: e21dba7a4df4 ("net/x25: fix nonblocking connect")
Cc: stable@vger.kernel.org
Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 net/x25/af_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index f45c9ec7d2c6..89e0f247c5b1 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -812,7 +812,7 @@ static int x25_connect(struct socket *sock, struct sockaddr_unsized *uaddr,
 	/* Now the loop */
 	rc = -EINPROGRESS;
 	if (sk->sk_state != TCP_ESTABLISHED && (flags & O_NONBLOCK))
-		goto out;
+		goto out_put_route;
 
 	rc = x25_wait_for_connection_establishment(sk);
 	if (rc)
-- 
2.34.1

