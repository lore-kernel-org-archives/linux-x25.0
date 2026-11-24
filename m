Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513437;
	b=iPXMCZbF13seHBCkX4T2dZ5/SUkUAqNuShtjf6dL2f0HY7xASmPJrBW0lK7fta8a8kPp
	 clhnQ1dEY/S9gpgXJqQ691AOvyiQq/8I9RFv6XRloWbzVzLH2IvCQAh9YTAEkjvg+GCM8
	 rB//ZYqSgjJoFXJkCVG75ZEKlRRzpMFDxERO8Bkmx/FW3ZuK44g3cutt4UvaTTph2HVph
	 XPHS2uDayR6z2PeydjT/8wg54bAlkPZZzNVkPQ1a5PDrdhA9JCf7Of8wk3rIYvwNpSmKG
	 lBKAkSqyfT0Zlw6I9JoF3gi3jMKptYymCimITYuYgE7LFJJ+j05dp1vHU1va6jWlZ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	b=GrI2rStq2q23k+vI8LEL9I+fEEugq5IxcL+IRo9bVwt1pOAj7rLaQRQDMYKRjlhE7cxM
	 Ruo+N4OENEWszNVM9KIHT5VOaXPicG/ONFc1BX6KJHgq43/KZlg6qobiP+IKCfOkhwEou
	 AJ2ntv4mF7stRcBgp7NSo52mxBqFAZf9m5UrVka6keJU3iSqziJ9ODOReUCb6bT6tawNJ
	 /+Afahkvguz2LR5MyNpZNtQCSHnfrD8Xb7YTFqVyIpHXxICYWI+j0zLgFHN5WrfJNQTkW
	 F0fEggoyKfVQ9es4mb5WfkSrL4GVbBn4gwC4bWEo/HLXFS3YGuMzEbCl1AT4JzQmDhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvDCfgE7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74979606A686;
	Tue, 24 Nov 2026 09:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LvDCfgE7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713471F000C4;
	Tue, 24 Nov 2026 09:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795513437;
	bh=sS9FIrfW22SIhehTvpH3rdvmtslwIeEYozBr0OvaZe8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvDCfgE7DRkNNIiiw8NHIjWi7ngPyET+zD4/KnoXjvEfSK715Wb1nR99bpigruMsM
	 OjZlMbwFSyWIgRczMYicifb2h5EM1sg+PCYoBFzz8ZtyBf/zfyElWje3KmU2sOCBOl
	 sVNehJUI2OV5T1/8qX/4S/NiMIUwcE7KoNuTx1jFrLTwNxur0qMNYDA59sYOTRdg91
	 csdMxy5y3E37ZL8AX9s76wL8+HuNqmDvNbuS3sgiIY8XyvgtC+ntFiPNn7hj8OdEZl
	 Bgp1lcLcc3FAzU+vTy2k8hLUqPax0XNLIn2cUtozDVc8toqOH1/SKFWicwmjO3iGuL
	 j4Qf75BxSUQlg==
From: netdev-bot+sinfo@kernel.org
To: Felix Hoffmann <f3lix.dev@gmx.de>
Cc: linux-x25@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: 
 Re: [PATCH net v2] net: x25: shut down T20 timer before freeing neighbour
Date: Tue, 24 Nov 2026 09:43:55 +0000
Message-ID: <179551343599.3294.15975236431026350873@kernel.org>
In-Reply-To: <20261124093922.39573-1-f3lix.dev@gmx.de>
References: <20261124093922.39573-1-f3lix.dev@gmx.de>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
