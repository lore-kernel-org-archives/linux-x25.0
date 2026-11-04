Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759580;
	b=4uHya0nXGL6OYQS0UzdRaPKQQI1E2XoApDhyuUq4u1397XUcxE57fHh8sfFaRYArxhfR
	 tm60+Cs2UnGCWYo0lt0Ofetj/j0yy86tZAla8+WeHFBl9W/dHwrgdyw5CO3BBuuQUcOA+
	 KBCsNszp/jnlRDouFEUQWjeRzynPtKsGFOba6SCaUW9IflQG5YJJ278u2uiBv7kGDEXhc
	 dSrca6pEQ/wsOKSq0hTsKuz920UZl4g36j1sP6TYAqhsuzg8OCCDNlwZPtTdFCHdMkuWx
	 kYUppj99qYhkZ929MmQJNW4cFgWnsQjGqpykV0wMHyLzKpm+27CYMRtR/wzctHVmevQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759580;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=AbnxFyIl13OcZGtBdEJDerHcletrIguh7h1lwu3lVHelYE//Lai+pVx0OKJW+Q7LQrJG
	 okDsyUSvmV6yMSgbo2g4vXlUjGY01Jx5/IhFUUChiJyWi9PCRYvVPCi5HBNTFMTAztfp+
	 wF0fUKWTze43qU7IOSNth4NsNlvbFwnl7ujiU0VnvSHSrTqHc4+RDps91MeHLG85Yg/8E
	 zBZZ88FwJVC7ej09QYrHuzkZxC8xF7/yyo25p7PVqPhhbZb1L7NVYGwZHSGLd3kWJcMfc
	 7NgnahNP9CZMngW3oash8Wm9DA12BERz+uHivxM3BtGGWOl61XzJhl0lGg3eRLi61Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m02OcqxV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D2A606A329;
	Wed,  4 Nov 2026 02:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m02OcqxV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BD51F000C1;
	Wed,  4 Nov 2026 02:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793759579;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m02OcqxV/ygMT67SG1YpqCW0hoEu30vMQoC8Sc5nG9PzFzFwzqNIVbcTYISrq9JDN
	 ConnhwWV5u88NkVuDioQ2RgUfWOg/RYyWR+t5kwcegcqExhgmQ194bqPpC+NnJ9N4g
	 KSyprwEBTa9eUtcpLGPIsvoCFJhAPGp7/JlbdXS9MUln4kwT/lV6uZuOjZ+qS4RzQy
	 pWd2a1N1tj5957DO0KE6aHGSpJe6LCO5ZluasOLdGDCKfAmSis90u6qa9VcfL+Jxit
	 n/lfFI3Mmd+dw0+OjK3qRkYELWlhbbiRQH3YyjzE/XAMCNGsU/JBhm8IwJbDZCtcz5
	 1E19U7G27o1Yg==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net/x25: release the route on a nonblocking connect
Date: Wed, 04 Nov 2026 02:32:58 +0000
Message-ID: <179375957890.488859.954022080109103885@kernel.org>
In-Reply-To: <20261104022812.1484250-1-vulab@iscas.ac.cn>
References: <20261104022812.1484250-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
