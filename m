Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45391282F1E;
	Tue, 18 Aug 2026 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070152; cv=none; b=kwrTh/lBvhhijeE9RlRrtCBt5FHT2UTrn/F+vnrdiT/HxslohcqRbnLM6N7jFZBeaKkHO/ZFYoWt49gNynUayW0uHHVKK1zENXOZGY993Oc3SSGHvlsp5CTO2WUq2tXXgsp8HnI57cIkIQDDmIcOp1OXHPE52K9LO48u58/CZv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070152; c=relaxed/simple;
	bh=t2oY11ns0jS3BpZciMtCiLhR9jeNvY9/zGXLqwgMy8Y=;
	h=From:To:Cc:Subject:Content-Type:MIME-Version; b=YTWMCBXQYi+e1D56lXK27yyeSYZHm0IUSRjb+9TMp/+o4AskH8s4CpNgdIoDDfmFWSB8oaWzM99hpVaVVkW6Vin/xRjzRrai9VI2HWKRKL5e2Qh4N3qbEqSGRWL8lGq5LDsik6cljCk3fhETvrWTCRbd7wmJbFRwKdWup2kzTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CSkPCDaE; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CSkPCDaE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787070147; h=From:To:Subject:Content-Type:MIME-Version;
	bh=SH8i/OWv8+A83f6CY1bNy1IPbwWnaGBCa2g2N5HatNE=;
	b=CSkPCDaEtzdsGiWAx0tGJKb+FGb95yjDGyNyklC8feb4R4gZ8HYki8/SWvaIHcqT5hTjGFFy5ftOwIljADR8FCUjl5hL6ZF/UaqM2hAH1+bYcC5DkBALV+v7QFUCphca+8gpCzDMfWqYaGsotA8CXY+DhM6VdGX861KscG+6heE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X9E5Agt_1787070146;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9E5Agt_1787070146 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 00:22:27 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] x25: validate class D facility length before reading it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20260818162229.yOFI43Vfo0v911uVw0AFpyHQ_aOe_fsjoQXPZP70vMI@z>

x25_parse_facilities() checks that at least p[1] + 2 bytes remain for a
class D facility, but it reads p[1] itself to perform that check. If a
call setup packet carries a truncated facility list ending with a single
class D facility byte (len =3D=3D 1), p[1] is dereferenced one byte past the
end of the facilities buffer.

The path is: a frame received over the LAPB link is handed to the X.25
state machine in x25_in.c, and call setup frames are parsed by
x25_parse_facilities(), called directly and via
x25_negotiate_facilities() for incoming calls, on the remaining skb
data. The facilities length is derived from the frame itself, so a peer
can deliver a list that ends exactly on the class D facility type byte.
The over-read lands one byte past the packet data but inside the skb
data allocation, where KASAN does not report it, and the value read
then controls how many further bytes the parser believes remain.

Classes A, B and C each validate their fixed length before reading any
value byte. Do the same for class D by requiring the two header bytes to
be present before p[1] is read.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Abaci <abaci@linux.alibaba.com>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
---
 net/x25/x25_facilities.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/x25_facilities.c b/net/x25/x25_facilities.c
index 8e1a49b0c0dc..059dc3ac6261 100644
--- a/net/x25/x25_facilities.c
+++ b/net/x25/x25_facilities.c
@@ -147,7 +147,7 @@ int x25_parse_facilities(struct sk_buff *skb, struct x25_=
facilities *facilities,
 			len -=3D 4;
 			break;
 		case X25_FAC_CLASS_D:
-			if (len < p[1] + 2)
+			if (len < 2 || len < p[1] + 2)
 				return -1;
 			switch (*p) {
 			case X25_FAC_CALLING_AE:
--=20
2.43.5
