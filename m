Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C663CA4A2;
	Tue, 31 Mar 2026 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774943028; cv=none; b=qn/LafS0udIYN68vMTUbhh2Z7CIUdgV6sh41G7I2v+8i/FhwQM+0YdPLPmVLVqswMk+rLTvVTrWeKHmXOQUBxHNOvQeB/U5G+VWB5xiPAUfKpd9pVg/NOO9ZcclJIRucg2JI6imruQ1rHRZrftOgIwCUtvuqwNmrq8xi/8lzm04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774943028; c=relaxed/simple;
	bh=Yxc5gETq734sKt5HMX9SLXU4+JbAVx2gBzcaYYWbREQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:Cc; b=XSXVNyiyxciXhau2LvDZ4Dahf2yD0zkeONsrrBcnXYjv3htAjcMv+mSGshOR6AItmSlLIGeN7X9OXFcjzm9lfGTCyJOvApgP/dYVRbtHlosnDuJFXCyPs5UzO4dZMVvioQZkfLqJ7JC40/mM6Mjj0RFcZ2Z56x683ycrNuyu0DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=gm6vQgb+; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="gm6vQgb+"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=656447fc3f=ms@dev.tdt.de>)
	id 1w7Tl6-00FWkC-65; Tue, 31 Mar 2026 09:43:32 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1w7Tl4-00DBue-Uo; Tue, 31 Mar 2026 09:43:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1774943010;
	bh=PHK65GrDgnKOkU4RSWaFPH5euhkDd2MuByk7s8lkvTk=;
	h=From:Subject:Date:To:Cc:From;
	b=gm6vQgb+hLEwyQv6LUKGJmyidQYo8JNxMixbqD9hLbWnv+GGxeOFAfqWtkeddIfIo
	 jdkla+HZLb68cIw0OG9+txlcKiXhDo7PuHp5COi9Q01KZcynbKn7oKIWBJXg7WnlUP
	 EQ267+7P37kncvr5mnC9/ydE8KZE9u41J6jd1tcTzwiAvvxSRNh3hzdOBnGexrxFvF
	 nyRhw2EDVQd1TLRuecIwkuxfbZC0CuNTuNFKFbQ0ltZXPqqQsXNULZhGFMAL1Bb/nB
	 B/KfhKOql67djO/m0fu/tWAwYL0rn6AZC82aVc43rhf0RL2rmj1x/NjwUmaF+3xgOa
	 2yfsXlzDKzANw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 5842D240041;
	Tue, 31 Mar 2026 09:43:30 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 3F585240036;
	Tue, 31 Mar 2026 09:43:30 +0200 (CEST)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id E1B3920BF0;
	Tue, 31 Mar 2026 09:43:29 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net v4 0/2] net/x25: Fix overflow and double free
Date: Tue, 31 Mar 2026 09:43:16 +0200
Message-ID: <20260331-x25_fraglen-v4-0-3e69f18464b4@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABR7y2kC/33NSwrDIBCA4asE1zX4zKOr3qOUIjomQjFFRVJC7
 l6RLhoKXc4M3z8bihAcRHRuNhQgu+gWXwZxapCelZ8AO1NmxAjrCGcSr0zebVDTAzwerGaCGAr
 GcFTEM4B1a61dkYeEbmU5u5iW8KofMq2nT6w/xDLFFI9W95IaYXspLgZym0xqDdRQZn8wK5gKP
 lKque2Y+sH8C3NyxLxgqYaRD6KT2sIB7/v+BrLfbRgmAQAA
X-Change-ID: 20260325-x25_fraglen-8fc240d1edd3
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Yiming Qian <yimingqian591@gmail.com>, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	security@kernel.org, Martin Schiller <ms@dev.tdt.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774943009; l=1327;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=Yxc5gETq734sKt5HMX9SLXU4+JbAVx2gBzcaYYWbREQ=;
 b=UOkszNTkXjYabucscbnAfA8XDxFM4YbnAWGqhg3+qjJQm+TCcI9uHHSeYr1gaSxQcnhFN7XqY
 gVnv782DMLHArxG6h026ECGAXRNArhaXmwid5MPJlcDDEpPU4dZ42d9
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate-ID: 151534::1774943011-42C73BD0-C9A6AE12/0/0
X-purgate-type: clean
X-purgate: clean

This patch set includes 2 fixes:

The first removes a potential double free of received skb
The second fixes an overflow when accumulating packets with the more-bit
set.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
Changes in v4:
- Do not call skb_free(skb) in case of overflow 
- Add another patch to fix potential double free if alloc_skb fails
- Link to v3: https://lore.kernel.org/r/20260330-x25_fraglen-v3-1-5a8938465cfe@dev.tdt.de

Changes in v3:
- Added missing Cc: Simon Horman <horms@kernel.org>  
- Added missing Fixes tag
- Replaced `Reported-by:` by `Suggested-by:`, because I cannot give an
  URL to the required `Closes:` tag
- Link to v2: https://lore.kernel.org/r/20260327-x25_fraglen-v2-1-143911c3f62a@dev.tdt.de

Changes in v2:
- Use USHRT_MAX instead of sizeof(fraglen) nonsense
- Link to v1: https://lore.kernel.org/r/20260327-x25_fraglen-v1-1-9fc751d4f754@dev.tdt.de

---
Martin Schiller (2):
      net/x25: Fix potential double free of skb
      net/x25: Fix overflow when accumulating packets

 net/x25/x25_in.c   | 9 ++++++---
 net/x25/x25_subr.c | 1 +
 2 files changed, 7 insertions(+), 3 deletions(-)
---
base-commit: a142d139168cce8d5776245b5494c7f7f5d7fb7d
change-id: 20260325-x25_fraglen-8fc240d1edd3

Best regards,
-- 
Martin Schiller <ms@dev.tdt.de>

