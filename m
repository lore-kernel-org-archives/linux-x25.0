Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD9A486E60
	for <linux-x25@vger.kernel.org>; Fri,  4 Sep 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525895; cv=none; b=QA3rVaWf0Bj4gwawBAc93YxMW1eH41JWWSbf3unrY8GoNX2AJWJAp0xjI5iqaUYp4g7aryogljSN3e9kPRU+qSeDT6CnSJNwE9mTiDweSj/Cssha0VYln+hFBWQDGrAniTpO6AXezmUlSJDxRSbXlQXDGKXID/zbHum17RER4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525895; c=relaxed/simple;
	bh=USyaP1c0hTWMfiIXxol/8YxXcSe9Nch7yzmLAIwCl3c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k5Q3Ku1vkWSlhwlT3LxAwwaCZ8EztCAdUc7eRdO41Q/zddh6kWLylg8XBOxNRx9+RS63V4u8e/JYGgjQYbJrP1SCCSdYwRYHLP0cxaEqbbC3p5HABUkrwwrBU5XeRDKJ7s941j3w65ddaJmmYClNi/o3rP7n+I2f+XbhF7kFu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jczB6ZGX; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jczB6ZGX"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7f48c750afcso914349a34.0
        for <linux-x25@vger.kernel.org>; Fri, 04 Sep 2026 05:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788525892; x=1789130692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=afStDJ0p96QePHpdDq4rxwCyajyjIl0hbxi8e2vmI+4=;
        b=jczB6ZGXA08uYVCDzKEg0BtbB0NwEDL7RSoXSf/oJvH5/whzpii2KLXdQPOKiWC+aP
         L3exdaZYec/8a8qqDc/HSTHLQBJsb8i+mM36WRm5xHrs+DYwqOFp0ZDr/xP2mz3q6ObP
         FQ99Dd+5hy/yoD2U3Jaa80bl5JzyYoDMEEhX+Ufxvf/2Gs1SAoKlk8/d/SNucYDOeZor
         utK5Z3AcEXijWILODQX/YfCu665IJaj/5b3znjfakRbgN3osekICp1tV057K4Zl8T6W2
         iczaXXjqjbSCTJi/hPOd3hIWLv3nxyhjS4oYtURtAPYGde9Ov8t/JDgwYg+vbSXUjG1l
         Z5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525892; x=1789130692;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=afStDJ0p96QePHpdDq4rxwCyajyjIl0hbxi8e2vmI+4=;
        b=agFYsxCMLvOAPDjnASf8e8ctO08kmEH2lmHtBiIZ2ydyNJnfAXbR7imjq28+y0D8It
         Gpr1LnLRsvidrpxpHRsOiFCjl8Eier8v4jr9a0jBG3SDLcxehrnbOkYN6LFobvk1dHcq
         TEx1liv4xjqvbouYC12uMBHEWfDbBfpLveVxmFlKsuunQefPna5E8mxIEwF+BvE9fp8n
         o9f9/lbhVZKzz6AMwOS6VODsHE16+ik98EjoxMXKPAHqmquEDBPRwL6PVLMwvXn9xYEW
         nn2zyFsEhXVHCBmH8ceSQgfXJqL4PSVeDBzdj+EgRaCGwY0a1tYHssaCQgeiiHI4zFFb
         4u5A==
X-Forwarded-Encrypted: i=1; AKwUvBzl1q9fOW13DHovhAQisIm1Rw2fok3d9Wa34br3l8iP6Ce9dFbwRvwfNiSSUuw0zr+20Vc4DTgFJ0k=@vger.kernel.org
X-Gm-Message-State: AFuF++nRZAXgq1himT6c4hVCOayB6HQ0kEwqUYPh1rJDNZ6GgwBbEtL1
	kIvRxPmMpunLcJUD10XiBvAL0SAXjaAi9PMQejf3q9h2FyIjVB9wtVcxQVujHHo1L74=
X-Gm-Gg: AYBFou1DSXFgX9FJYFsoKraHoRVO4TrSk0NcgYhNt3bgoD8QDRiXb+/K9ys0QdZPi5b
	nTTS8ZRtopCiGO2hs4kN4Ke9Xx6FdhL8D8erDc5eUJq5CfqKLVtFW2gkTpNBWJPoLf9Q5V7zT2w
	ewOVXFA5UpZfUVhPH09gFJKLz22hP+WFOueFohgIlHz3un+9EG0PWfR2Zy4J0MRBj+U8m9QrEgH
	tpXmoaaq1EBUHHU2Eg38r07VHIoGbIkYFmacU4+bFUHNENcbskBZboSQ7yKa8CYjT/BMI0AhaV+
	mMw9yU/UUHRTlvifI1Y2Wvt4/ppkxMGseqWCjpBeX1J/tiyePPLuBjyEPQHBMRODqu1Fd2a690K
	YMea642+MawOWozaEUb6lCkmkVkn+uzNrBNPinhkoXfWNyxMJ8LBEg1BZ9cSijhq7CDLaEmmFgH
	j+29naTaM9zYyUAH6fmjMTl2bBzrGqYcGCoJ8zEuYhO7+kM9GWjyuLrAUShs7yf3fzE8UWivCc8
	gcYCyHfGp43038=
X-Received: by 2002:a4a:e904:0:b0:6b7:83c5:fdf0 with SMTP id 006d021491bc7-6b783c603b3mr1907290eaf.49.1788525891923;
        Fri, 04 Sep 2026 05:44:51 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm6805245eec.19.2026.09.04.05.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 05:44:51 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: linux-kernel@vger.kernel.org,
	linux-x25@vger.kernel.org
Subject: [PATCH] x25: fix typo "compatibilty" in comment
Date: Fri,  4 Sep 2026 18:14:46 +0530
Message-ID: <20260904124447.7040-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "compatibilty" to "compatibility", reported by
scripts/checkpatch.pl using the misspelling list in scripts/spelling.txt.
Only touches comments, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/uapi/linux/x25.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/x25.h b/include/uapi/linux/x25.h
index 034b7dc5593a..f0dca6c63f90 100644
--- a/include/uapi/linux/x25.h
+++ b/include/uapi/linux/x25.h
@@ -67,7 +67,7 @@ struct sockaddr_x25 {
  *	DTE/DCE subscription options.
  *
  *      As this is missing lots of options, user should expect major
- *	changes of this structure in 2.5.x which might break compatibilty.
+ *	changes of this structure in 2.5.x which might break compatibility.
  *      The somewhat ugly dimension 200-sizeof() is needed to maintain
  *	backward compatibility.
  */
-- 
2.48.1

