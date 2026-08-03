Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275AB1FC7C5;
	Mon,  3 Aug 2026 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747590; cv=none; b=KkR1tPglGECK6dXzSdFwBJ0DLFJeWuRLZUckI33vjiMsvRR4I8XOqnyMdEwT1XojOtbAXJkyjOp1t7CHRieGHEYNm9ajLC5ih6na/3SoipEZulBY7noEABWZZCuVIrCwa7pPbrDrAvWcjIM0cii+4acyLgldQmyRGqZn+IAkJ6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747590; c=relaxed/simple;
	bh=F/1etN0F0L/+KtcQDPxdkLWvD2BrVPNcqQk/UkXnz3E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C/5loCrzdUI4J1gIpM+4pEvZNnGXnLvCojIuHjDBV0Cdc8Fb5nNighEpuvhWyOVT7sy4rJn4ykg0lzNauP3FsdirCMgib/lQxcEJjdvE9vpRVDdSONZ57YxuWmMAdAkO66KoPifWaf377GPuhCWsmEPiPlXXXvNg64edSdmslKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: aae65ba48f1911f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:21fb3ad9-9b98-4cc6-9c2f-a931d81a1ed2,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-30
X-CID-META: VersionHash:e7bac3a,CLOUDID:b1368a2fdef17328da88869d528d36a8,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|136|850|865|898,TC:nil,Content:0|15|
	50,EDM:2,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: aae65ba48f1911f1aa26b74ffac11d73-20260803
X-User: heminhong@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <heminhong@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1518830739; Mon, 03 Aug 2026 16:59:42 +0800
From: Minhong He <heminhong@kylinos.cn>
To: Martin Schiller <ms@dev.tdt.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-x25@vger.kernel.org,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH net] net: lapbether: check register_netdevice_notifier() error in lapbeth_init_driver()
Date: Mon,  3 Aug 2026 16:59:36 +0800
Message-Id: <20260803085936.142160-1-heminhong@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lapbeth_init_driver() ignores register_netdevice_notifier() errors and
always returns success, which can leave the module loaded without its
netdev notifier registered.

Check the error and remove the packet type on failure.

Signed-off-by: Minhong He <heminhong@kylinos.cn>
---
 drivers/net/wan/lapbether.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 9861c99ea56c..c3630a82913b 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -497,9 +497,15 @@ static const char banner[] __initconst =
 
 static int __init lapbeth_init_driver(void)
 {
+	int err;
+
 	dev_add_pack(&lapbeth_packet_type);
 
-	register_netdevice_notifier(&lapbeth_dev_notifier);
+	err = register_netdevice_notifier(&lapbeth_dev_notifier);
+	if (err) {
+		dev_remove_pack(&lapbeth_packet_type);
+		return err;
+	}
 
 	printk(banner);
 
-- 
2.25.1

