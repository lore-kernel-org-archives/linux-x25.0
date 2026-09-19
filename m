Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDF53921DE
	for <linux-x25@vger.kernel.org>; Sat, 19 Sep 2026 21:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853806; cv=none; b=MUYWJkm+sABEgpY8EtMBaqj4Qqyf0s0yZZQBVwsVOLLXPWn2LnJYQxH6rabDOBfuK/5g/BfxBWjSXrCgFmIe80HPPXnS9Blur9NIW/M2eQDTjcFNWDkXnAs3GPi4ErhnCJRWnqk1/K436mizvsiIJjCe7wwbgtm937PbSpopL3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853806; c=relaxed/simple;
	bh=ylIbZgKsiNrIwpSIWxBnwwtC6dQOGngNLUyTzMPDsPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rdWYHHCERJDMrhYcKcKvQ3GT8hKLHFCjmvsOKiJtVNU3lScv7PucIxNEqn/lql4pv0d3ny3WY6vNSaVPPkADjIZ41NOhtO6iYJhzc5JDlKLElW9JWtMSuQ4WKaWdCaVnQStnzZAmALY0oDZ7sutO9c2MoxSEBo+OPf08MDQ5uD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dh22EdDh; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dh22EdDh"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396cccbba92so1704409a91.0
        for <linux-x25@vger.kernel.org>; Sat, 19 Sep 2026 14:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853800; x=1790458600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2j7v0Gfm1mzC7ZOfmDBTrSr3Zc/OVo6Hpw1JferQnEU=;
        b=Dh22EdDh0UblCqQrVFJlrRnXe5i3GujtQ01GJbijTagJjmQ3fqGBdV1OaZVOVm9F79
         G0y8fV5JAtFcMpMQZrfEZWpNBbo5uLc+TtfVc7HO/T58uesahn5csB7+fYqAEtuoPIoG
         aaP49+NasMI0vXt5w/Obmcq/YjRllQ2xvjNPs38TcwRy0R1F65ogE2jKbJqQ0GPMXr6C
         v8E0daC1woNDY9Ql71lgn8LYFsewPRruf7KoFZ3599qgMGlqHtjvv/0GtrHFlso5Jmow
         VbA4aa4rSsE1kETBZzCSaGJ+m3JZUwid3e/qRDgHF4w9ipC7pV4IL8AJq3vTad4V+gO8
         iTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853800; x=1790458600;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2j7v0Gfm1mzC7ZOfmDBTrSr3Zc/OVo6Hpw1JferQnEU=;
        b=QbtPCxu1pBRLPFnt/4kX850sZtHwfFICMqBRJlKX5VCGAV3nXQEsdookAhu+ixxGUs
         rjrYatJ1vC2HOUzn/xOjsD7RxJb0/ucwoKP0Y1KIcU/tUAZ4d3CCOF35H9e+HmYE38ku
         vwplR/RQFyXLMTZwwmA+Rq5v06o+mMZCxOGjDI1OgbXr+KjoTpPmbPPRt49ttGJ0CPxM
         nSZ36dtz2Wh6j4AZCK6uTMMiNInA2FbbrLgwY1uBwIAa7bcysB8wuFsZYskZVhvVlFIW
         1NU3TKNTENM+HkkpEeo552d8JxDqBlo2ne7ZzT/syjUJtWKeo58Ge7OjKk2Xyc0i6TZk
         PmSQ==
X-Gm-Message-State: AFuF++n5Kb3zDI+SgPZ2w0zbjMf8b3RBLaICu82ItK6nqsW/ljj9cY8/
	WdEJBNV7eymQ6rHcqrgS30+zrAdkrXjtyUbZ6nQs3ydJuHT0CRceNbGB
X-Gm-Gg: AYBFou1dMnaWK+k+AZdDmPcVKXlEalNSZSd+V8zW27Ih8NWaMP5LsVCMolXNbzU5dSY
	VPeb0PJzywq4JQswab2tBC2VOiNIk0S+kTkMWyVg6FerjKyBGmWesQnztcYz/TG7ucooa4ePFRY
	iR4yu84IpxW/SBv452GrMBq0/t8CbQLUIB3yk2KlrY3w9dqHVji7V8kYJ2j0n3AjAy2i6mSHm7g
	XGeBCh0sB2J14XcSec0Wa3zoqEo8fMCqUkkZyMcINdwszLi+kXLQNixdlmrgOMX/7dA1mzGIXzX
	L7I/9mkP6kyMHE08czH7FTU3yL0ZTk0ApjqKdtmYAr5alW0Ud521SnXTc8NihwsopFGiyJE8nia
	4EKRXenLuh0Z+qI8nPEmA8KVnxuvaB5Q/LNJHDW6TKAci+IjP6oDbbzDbMsbyG3syil+yT3c3ic
	dvyCXM9+oxD9Yofq5sN2kl2+x+FBzyW0PH6qCtWYgkP4+397iFe71tJVosoSwlZOm5qWazZQJKL
	QxRtOhI2QNqEsPNR7umTgZec097gFGxcotjiwJtw6h6cYpuxOWvldv7a+lSkAF4xoizZwfh5pkx
	gN+WH90QL/1rNSQRaNWq
X-Received: by 2002:a17:90b:4cce:b0:3a0:2646:7495 with SMTP id 98e67ed59e1d1-3a026467c7cmr2912646a91.53.1789853800393;
        Sat, 19 Sep 2026 14:36:40 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a038fffaa8sm59595a91.1.2026.09.19.14.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:39 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: ms@dev.tdt.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: lapb: fix uninitialized stack frame fields in lapb_decode()
Date: Sat, 19 Sep 2026 21:36:39 +0000
Message-ID: <20260919213639.3314894-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`lapb_decode()` populates a caller-allocated `struct lapb_frame frame`
on the stack of `lapb_data_input()`, but does not zero-initialize
`*frame`.

1. When `skb->data[0]` is not a valid LAPB address byte (`LAPB_ADDR_A`,
   `LAPB_ADDR_B`, `LAPB_ADDR_C`, or `LAPB_ADDR_D`), `frame->cr` is left
   uninitialized on the stack while `lapb_decode()` continues parsing
   and copies `frame->cr` into `lapb->frmr_data.cr` via
   `lapb_transmit_frmr()`, leaking 1 bit of kernel stack memory over the
   network.
2. When decoding an unnumbered (`LAPB_U`) or illegal frame in
   `LAPB_EXTENDED` mode, `frame->control[1]` is left uninitialized on
   the stack and copied into the outgoing `FRMR` frame by
   `lapb_transmit_frmr()`.

Zero-initialize `*frame` at the start of `lapb_decode()` and return `-1`
when `skb->data[0]` is not a valid LAPB address byte.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/lapb/lapb_subr.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/net/lapb/lapb_subr.c b/net/lapb/lapb_subr.c
index 592a22d86a97..8150f3583f15 100644
--- a/net/lapb/lapb_subr.c
+++ b/net/lapb/lapb_subr.c
@@ -106,6 +106,7 @@ int lapb_validate_nr(struct lapb_cb *lapb, unsigned short nr)
 int lapb_decode(struct lapb_cb *lapb, struct sk_buff *skb,
 		struct lapb_frame *frame)
 {
+	memset(frame, 0, sizeof(*frame));
 	frame->type = LAPB_ILLEGAL;
 
 	lapb_dbg(2, "(%p) S%d RX %3ph\n", lapb->dev, lapb->state, skb->data);
@@ -120,25 +121,33 @@ int lapb_decode(struct lapb_cb *lapb, struct sk_buff *skb,
 		if (lapb->mode & LAPB_DCE) {
 			if (skb->data[0] == LAPB_ADDR_D)
 				frame->cr = LAPB_COMMAND;
-			if (skb->data[0] == LAPB_ADDR_C)
+			else if (skb->data[0] == LAPB_ADDR_C)
 				frame->cr = LAPB_RESPONSE;
+			else
+				return -1;
 		} else {
 			if (skb->data[0] == LAPB_ADDR_C)
 				frame->cr = LAPB_COMMAND;
-			if (skb->data[0] == LAPB_ADDR_D)
+			else if (skb->data[0] == LAPB_ADDR_D)
 				frame->cr = LAPB_RESPONSE;
+			else
+				return -1;
 		}
 	} else {
 		if (lapb->mode & LAPB_DCE) {
 			if (skb->data[0] == LAPB_ADDR_B)
 				frame->cr = LAPB_COMMAND;
-			if (skb->data[0] == LAPB_ADDR_A)
+			else if (skb->data[0] == LAPB_ADDR_A)
 				frame->cr = LAPB_RESPONSE;
+			else
+				return -1;
 		} else {
 			if (skb->data[0] == LAPB_ADDR_A)
 				frame->cr = LAPB_COMMAND;
-			if (skb->data[0] == LAPB_ADDR_B)
+			else if (skb->data[0] == LAPB_ADDR_B)
 				frame->cr = LAPB_RESPONSE;
+			else
+				return -1;
 		}
 	}
 
-- 
2.55.0.1082.g2b9226bbc0-goog

