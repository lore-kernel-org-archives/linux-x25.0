From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net v6] net: lapb: Add locking to the lapb module
Date: Wed, 27 Jan 2021 02:00:10 +0000
Message-ID: <161171281019.17694.7986629700943704472.git-patchwork-notify@kernel.org>
References: <20210126040939.69995-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611712810;
        bh=6zro1thD6AZ+sJT5zncKt1nybQ/TDlIaxZy1rMM46Ps=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=cAY0btbTZQQ+jB3r6oTNo+Vqf5EeQmN7B9AjtUh6WwJAHsXGVEGB4IfMoagj8K0ss
         iLuwJezG3GsXguOBUEK6oZ1nmAeCruTN6F2UjjRHMcmFOAK6HjZHvJCJMDreI9l7V/
         8QvcwjyKqty3HZd/D2l4T4jXd3514XybAuBhDuJJMhYttywTlSDgv6uM1g7/QtnwAk
         nCKw28kvDHab65su/CvtkRNDF32HDEIaXXMW8cg9R6qvZHEroUGzb+HlQ83seCE6/q
         mC3gc7m1sShRYR9Z1QXbNArFuVJIGXaITGcAfl/igTLzgrJrgUapRKRogvrUKr7ybo
         bH8ei7cLxbFqw==
In-Reply-To: <20210126040939.69995-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon, 25 Jan 2021 20:09:39 -0800 you wrote:
> In the lapb module, the timers may run concurrently with other code in
> this module, and there is currently no locking to prevent the code from
> racing on "struct lapb_cb". This patch adds locking to prevent racing.
> 
> 1. Add "spinlock_t lock" to "struct lapb_cb"; Add "spin_lock_bh" and
> "spin_unlock_bh" to APIs, timer functions and notifier functions.
> 
> [...]

Here is the summary with links:
  - [net,v6] net: lapb: Add locking to the lapb module
    https://git.kernel.org/netdev/net/c/b491e6a7391e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


