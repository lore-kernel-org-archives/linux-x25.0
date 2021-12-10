From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net-next] net: x25: drop harmless check of !more
Date: Fri, 10 Dec 2021 03:20:09 +0000
Message-ID: <163910640934.13476.8421043107129227133.git-patchwork-notify@kernel.org>
References: <20211208024732.142541-5-sakiwit@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639106409;
        bh=uBG2Sn7JzS43WffLO6b1Tg2/7OY8U5FlKnHBjN0YOBM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=ESQpxcwCEK0l04NBxk8OedN7fkrkcyFOFS9s03nKseUiV6R0KqXQSPsIEr0wlftmX
         nZ8xt8FtEFPF53i4ajvR59nHj0WYac2/hZzDCnB6bTiA1AFfRuAhhKkXc+SHEOb1Cn
         JwbPhfPIPgDbkV8TQ2CJFICDzzjWXmKo7dgfDVjn1FTmDUXch0qqiJv3gf+grrbzg0
         aooTVwD+0pqFcVPyaKHRclFZdAwAqc3maqg1HyC8lFhU/NiPTkK4RN9XHofgw7NWL5
         R4AWt3cLGWGK6hcXSWZQGrYfrSoWChtFQgiIVQ3E+vQZZsdHN0B7E4gvQSr/VzeM06
         998RNb58v/esg==
In-Reply-To: <20211208024732.142541-5-sakiwit@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: =?utf-8?q?J=CE=B5an_Sacren_=3Csakiwit=40gmail=2Ecom=3E?=@ci.codeaurora.org
Cc: ms@dev.tdt.de, davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Dec 2021 00:20:25 -0700 you wrote:
> From: Jean Sacren <sakiwit@gmail.com>
> 
> 'more' is checked first.  When !more is checked immediately after that,
> it is always true.  We should drop this check.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: x25: drop harmless check of !more
    https://git.kernel.org/netdev/net-next/c/9745177c9489

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


