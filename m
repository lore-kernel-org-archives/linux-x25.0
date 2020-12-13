From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net-next] net: x25: Remove unimplemented X.25-over-LLC code
 stubs
Date: Sun, 13 Dec 2020 01:20:07 +0000
Message-ID: <160782240712.6413.5405278375067438996.git-patchwork-notify@kernel.org>
References: <20201209033346.83742-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607822407;
        bh=kamsfLluyGJCkDdF8e3xmFsL1h7UPia0fZmevAtdGyA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PUrh1E5tCQlgQdTS/o9V6tgjCQdE/3Gq/mHswnQHYlSDyBUDj9fxqZclZbyzJPVMV
         lxe8u/UR1NKiJ/RP4PCGGaOBhqOmQt30TY958jDjjwKq3jsWTrLVEchTrOdpgvsJOn
         pvfFO9l3Fljrl5smVyRkRZFOJ+Vf3C/pcN0K/Sp1tXT1voyClBqA9d60/SWiHaXqjT
         xxzdhEw6eoDxTvSb5PwnxH8Q+9y4qGGgEXkk+enywvJnIDtUzq3Hp6RMX7wD3Iac2y
         bbSvRHOvs9/CZPDnGtgtNEl6uNxmb1m+7KmX+rF1SxN91Xe6DXgZMw0AmyEiKCZlpR
         8AR9yB+xDuiqg==
In-Reply-To: <20201209033346.83742-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Tue,  8 Dec 2020 19:33:46 -0800 you wrote:
> According to the X.25 documentation, there was a plan to implement
> X.25-over-802.2-LLC. It never finished but left various code stubs in the
> X.25 code. At this time it is unlikely that it would ever finish so it
> may be better to remove those code stubs.
> 
> Also change the documentation to make it clear that this is not a ongoing
> plan anymore. Change words like "will" to "could", "would", etc.
> 
> [...]

Here is the summary with links:
  - [net-next] net: x25: Remove unimplemented X.25-over-LLC code stubs
    https://git.kernel.org/netdev/net-next/c/13458ffe0a95

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


