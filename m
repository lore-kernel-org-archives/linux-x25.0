Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F48343D67;
	Sat, 31 Jan 2026 03:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769830218; cv=none; b=tW31bldaPGjJ9VcWCLmLLiQ9HyMIMLNZOUY38OTDjrQLpTu4+Mu9bTJgYEQgRRbnAUsoHZiVPGi+63It2rBB+A1dYc8aG/qowT4h3qVUN4c7dufm/MADXJOS1Uc2u5VOWb8LyQrUoa40vex0jGrv3tjE43pDCdJHrtvfB1TgNOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769830218; c=relaxed/simple;
	bh=PBkK4XFVJtKTvWBomxF8RfLVZws1JNwbP6cXL3HT8UE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U/Vj0ih7uxx7yPxg9TebpWS+VOw8BtdXJyuPzTcuEhPp2c+dErWRgR+2NgaS783UJZeCHIdKUi3+d5crJo1pOxl8UivXLVWrmXo5dWSYE1U15PjyzQeDAERhNdZLkkgvyZdfQpxE6G1lkEYU12SKkjFMp04GFoOMnUKHTXvdbr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWFDoWrS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWFDoWrS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0B3C4CEF7;
	Sat, 31 Jan 2026 03:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769830217;
	bh=PBkK4XFVJtKTvWBomxF8RfLVZws1JNwbP6cXL3HT8UE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qWFDoWrSm+MT5PAg0YA6m4MeEx6+J7BJD8iSTHWLmAS+/ZaXi5X2uZ82KgePNYKxE
	 YYYppUJCc1MoNKVk2aEeMuh9FJWsgEgIzfSetPGIWw5vx0Uajud422ZR8yTXA1tZdU
	 VQgYqYw4jIirzzZajLn5ELhdvSxQ3tgikoG47yWj+g38nncVBXaJ3VCpN+MA/UdXwZ
	 66Hy5Qlo5NR+A6aXzRWm5h2pf0AkWmp7Hw6Wgh+sS44UmyUGdhatmooYMAC7g25RfB
	 dtxDi8WIxGemnPmL2rJwYbp0Bw2B8fbzhFbSnxTBa5AgsoUlsAjINI5ZBh65val2NZ
	 c/3yaf3VotY0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C8C53380CFFF;
	Sat, 31 Jan 2026 03:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ax25: remove plumbing for never-implemented DAMA
 Master
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176983020935.3983574.5434657650924305702.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 03:30:09 +0000
References: <20260129080908.44710-1-enelsonmoore@gmail.com>
In-Reply-To: <20260129080908.44710-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-x25@vger.kernel.org, linux-hams@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jreuter@yaina.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 29 Jan 2026 00:09:04 -0800 you wrote:
> The AX25_DAMA_MASTER option has been unimplemented and marked broken
> ever since it was introduced in 2007 in commit 954b2e7f4c37 ("[NET]
> AX.25 Kconfig and docs updates and fixes"). At this point, it is very
> unlikely it will be implemented. Remove it.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: ax25: remove plumbing for never-implemented DAMA Master support
    https://git.kernel.org/netdev/net-next/c/82fff3b055d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


