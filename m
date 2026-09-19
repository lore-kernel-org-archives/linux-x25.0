Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C43988E0
	for <linux-x25@vger.kernel.org>; Sat, 19 Sep 2026 22:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789857276; cv=none; b=MGMvrTqkxVxo2+hx41nlenVuVSIxPqLUSU3EWX14+8tH1lMJP8fvJlGS9gpI4wJS9jOIkpFrs8iu5TYyFq+gXpmpRpfXdeq60+hnlOYbGG9fAH81+fZJLKij0aZkDijy+5ejBj1qiDUWl6NJjYDOj48TUdqdSGyMi/i0TK1dJ9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789857276; c=relaxed/simple;
	bh=wOlYZODCnWgbZZy7EFDEtjpA+YRshMveyCdiX6qNFAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YiJbigKrrux9EUnM2uxTfC0a4eMlbmVkSVrX5v26CuFnxZRvcyuhDrGLzNHeN2wRE0z7asW1PSc7jv/oLz6g7A9GShFMip3xIbikFS4nM9Yr0Quswj1bHT/SccpCegAv8mbmUIhFCDnIWUezqJDEUve9IYa1OZW9mFt3Kw3D4Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=efcltKNJ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="efcltKNJ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd58e1e2c7so16404255ad.0
        for <linux-x25@vger.kernel.org>; Sat, 19 Sep 2026 15:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789857274; x=1790462074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WI1pki+zfwXSN5E34Vg9l05h0Yqa+0/MqFS6gNIfHcw=;
        b=efcltKNJqW/7HGHJgatxbipBfbnnQ6TQnRUxuqZR02ZRWbPguKWzF1gpIi6/95mor1
         mfc3HFmNrBpo/DT/NtGWEwRaiLVp0KmhUByVqViKIx6xlt1WOpwpdEQTNqhtfQw2C3P/
         R3xyffbknUuTqYZlPj2NXFw/sQtNQLJzZazsIiOUdtOS4QfTAU2AmIZXEesBkHP7DN0e
         hE7afFDg3G7nxru+fTP2ieryR3/U9neKWgNQiRT4BNWYxELCKgEs0J555WsrjGCbq+H0
         wPZiCh8yQXbO9oA6A3hcuPlFqPOTSQGaroBHcEpRuTEHcjbehIQtXUglwlN2Zpzp1aVI
         CQyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789857274; x=1790462074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WI1pki+zfwXSN5E34Vg9l05h0Yqa+0/MqFS6gNIfHcw=;
        b=PnXb8wblNkmn2DwyrOiAAkPbOdVL2H+izXlFSZrWf4L+koOqh7SLsK+WT8aowwJteU
         RGfwNAF5QqV6O9rZ93kgyn9W1CnhnHViYWZMX/vd68iztgxH1z2VjKDz4CaQDJz16sIl
         kMeXEuwQLHBlOlt1beCYRzhLfyFjMuDk2T6IxPUHJD1ySpohvhaxkyyrxPmSN0Zmqkkm
         wcCDw5akG9Xn2Gr7THD5v1qlsIzWxmU9k3uIH+TOJlItsyNRwI62tLc3cJ4KC3bg8zXZ
         bqwYbbSqaMoqz/BA/4RdOEYRDYLH8Ju9wqnMzrzlbuIyNJbdus13d+DPBk/UchGaKg8l
         S8mg==
X-Gm-Message-State: AFuF++mOSfmhtnXQapH24AtJHOQnNLkHAJAumt0BowhxtulOY6TKCtfn
	dyRDTV7o6t2+0gtjBKosS6rcvDVEaoWTS5C5H0H4DKbq24a93mgdTXyD
X-Gm-Gg: AYBFou3SV1tOVjE3OX6Im2i2HNJUb1MgnyRM1FUGYwCebjLdGptRWwzDZcFdnZCiIMD
	Cwln8Rldel0lutKQ/3S73Tvme01wXOdoTQX40JXJ1m3On7tBsLbdru5CvjSELNgStQBXnosKvxU
	twkxNf+enbbb6527X/RlzA/EMRnRTUr0W+4JKZrma81fFGTcpS0sD5lidXjKbW8Jn/pjcsR0xFG
	SfQcI/3wshUHESMUBElbUcoGYibGqntVKHo+kAcLvovXPoMDfyr4qZPPmDnHVDi7A8MEfb/8tYC
	a06Pgpt/DUm4B/qrkvlaX6yMTTQ7d4hl6eT698Qq3UJ2StKV5+krd0kDhARKZIRPgGZ7p1gI+x1
	uk8G4iD+93nGEM7KflIzYAoCz7Mp8eXyg3P7/lkuxBDNYhFrg+C8BMq/yV9kC9BnBs5dMwVYzYf
	SZ0QF34Hxi9Nv7uH57xVHgN1EezB7KdUOcLz/CjI41w61I8xGu4gIxDuYruXTjKgWPMvjLm+ReC
	AtRHIFWeU9tyqfOAXqsBJAwVFP2FviZnqEKkYygBeibCY2sWN5nBwFinxW9eH79FT8xjTUx2qqG
	rvpKJVGqsA==
X-Received: by 2002:a17:902:d54c:b0:2dd:c100:b2d1 with SMTP id d9443c01a7336-2ddc100b3d4mr44684205ad.60.1789857274157;
        Sat, 19 Sep 2026 15:34:34 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba65csm13032565ad.52.2026.09.19.15.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 15:34:33 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: ms@dev.tdt.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: wan: lapbether: validate frame length and headroom in lapbeth_rcv() and xmit
Date: Sat, 19 Sep 2026 22:34:33 +0000
Message-ID: <20260919223433.3882618-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In drivers/net/wan/lapbether.c, call pskb_may_pull() before reading the
2-byte length prefix in lapbeth_rcv() and ensure sufficient headroom in
lapbeth_data_transmit().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index c3630a82913b..3838910ea7bd 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -133,11 +133,13 @@ static int lapbeth_rcv(struct sk_buff *skb, struct net_device *dev,
 		goto drop_unlock;
 
 	len = skb->data[0] + skb->data[1] * 256;
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += len;
 
 	skb_pull(skb, 2);	/* Remove the length bytes */
-	skb_trim(skb, len);	/* Set the length of the data */
+	if (pskb_trim_rcsum(skb, len))
+		goto drop_unlock;
+
+	dev->stats.rx_packets++;
+	dev->stats.rx_bytes += len;
 
 	err = lapb_data_received(lapbeth->axdev, skb);
 	if (err != LAPB_OK) {
