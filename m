Received: from mail.commetrax.com (mail.commetrax.com [141.95.18.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BE2BF3CF
	for <linux-x25@vger.kernel.org>; Wed,  8 Oct 2025 07:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.95.18.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759910201; cv=none; b=u2JhcMiWp2ltYWRa8s5mHs/xb1ZT7d10VORzv3FJlBFJd4vDoreg9MtAkPbigFrtSGGXve+b4vAq2kDmVnuyz/cui1HOCLeUa1bOCQwTtE/A6yg8FdwhTZIJkb2LULild3jEY2nmK+tmzwiKjLVnW+uTbqo7kJargfvPtr5aD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759910201; c=relaxed/simple;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=BucU/0b1rusRl9qlCspbPUuZts3LWWN6qKPQpKM93RcNZE8Cws7cMyrMOENImG+JqkWXrhd89usUZQKcvTbAf1GVP/qaMWFA0b2IXcoEeOH5SNYZI6JrNr9YdWio7ab+v0mIprp5T+NKxXQFHvmby/D/GE7g/QnN5OQYoImYtQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com; spf=pass smtp.mailfrom=commetrax.com; dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b=f1VgJ3qi; arc=none smtp.client-ip=141.95.18.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=commetrax.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=commetrax.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=commetrax.com header.i=@commetrax.com header.b="f1VgJ3qi"
Received: by mail.commetrax.com (Postfix, from userid 1002)
	id E25A2241E6; Wed,  8 Oct 2025 09:56:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=commetrax.com;
	s=mail; t=1759910197;
	bh=M2z+nFeXqIRcbI6rcgrOtIQjqLLid9ZQ1XheJsIeFLM=;
	h=Date:From:To:Subject:From;
	b=f1VgJ3qiKVgqLgEnVfwBklnesSLkSHqIGTlcM1q98vssgsUN7Xp+cZc3wXLkdnGIZ
	 CO753MePdh5v2CS5r6M6tgiSpizSODEMaQFouDnwuyjVxlXBKQy8tnr9hE0Wz5Sd+g
	 IiNXYDsUKnNGohOURlDg5i0/IstQD+2vDEHautWl/89pXb7LS3kXX+EgthT5nFPufT
	 Y/0NMblbXhXKwFUt4os3q4VdI/p7wNLLtEEroQhfEDjR84AvJeXLsn3shUD8RTC1A7
	 zDN9mIe4ylF3HxkA+Oeyxni2q5QYtgFlEUGLMFhjaASmvvQAor/lObg+J9ThoNTOjd
	 UeiTQGS0hvPJQ==
Received: by mail.commetrax.com for <linux-x25@vger.kernel.org>; Wed,  8 Oct 2025 07:55:47 GMT
Message-ID: <20251008084500-0.1.c5.15olo.0.j5on6xhhbd@commetrax.com>
Date: Wed,  8 Oct 2025 07:55:47 GMT
From: "Luke Walsh" <luke.walsh@commetrax.com>
To: <linux-x25@vger.kernel.org>
Subject: Welders ready to work
X-Mailer: mail.commetrax.com
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

we support companies in carrying out industrial projects by providing wel=
ding and assembly of steel structures =E2=80=93 both on-site and in-house=
=2E

In practice, this means we enter with a ready team of welders and fitters=
, take responsibility for preparing the components, their installation an=
d quality control.=20

The client receives a complete, safe and timely delivered structure.

If you have projects that require steel solutions, we would be happy to t=
alk about how we can take over this part of the work and relieve your tea=
m.

Would you be open to a short conversation?


Best regards
Luke Walsh
