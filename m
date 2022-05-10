From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH] x25: remove redundant pointer dev
Date: Tue, 10 May 2022 10:10:12 +0000
Message-ID: <165217741218.27960.5224636019366457113.git-patchwork-notify@kernel.org>
References: <20220508214500.60446-1-colin.i.king@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652177412;
        bh=MnaoeGPz7Fq2odEZkhukT5d1h8HFw1tYwdSDDAv0T7s=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=OMouXlySYEfnIqHyGLcom88RQP+8TUtqR3KeltArziPJPFhn7guAdtq+JU/7XzFfc
         d4r6WdYrY3h0cvh2ZDMT6a019xEo+SuN/TwyJG6zV6Cd1N4RFQ7alqi0xiOA203SqA
         RxYg7pVRJ6GzgbfzuNmgGPMhcLCXcG+nZHsHkWvCNWP7umVUvzMYbZp2F6CARH7llH
         YbHlsTy7JVOExCJ9RwWon9TaO/aYqnJJ0O5GOKovvn1lhAtLosyU0ZnhbQWCe5F2A5
         q66VsG+0VqFlhLx875Gy58+1J7KJBxgUZJdzpOoH7X352mI32ahDWCyfHjCiYeODhf
         sPJ+vkBNZFdBA==
In-Reply-To: <20220508214500.60446-1-colin.i.king@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Colin Ian King <colin.i.king@gmail.com>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  8 May 2022 22:45:00 +0100 you wrote:
> Pointer dev is being assigned a value that is never used, the assignment
> and the variable are redundant and can be removed. Also replace null check
> with the preferred !ptr idiom.
> 
> Cleans up clang scan warning:
> net/x25/x25_proc.c:94:26: warning: Although the value stored to 'dev' is
> used in the enclosing expression, the value is never actually read
> from 'dev' [deadcode.DeadStores]
> 
> [...]

Here is the summary with links:
  - x25: remove redundant pointer dev
    https://git.kernel.org/netdev/net-next/c/ecd17a87eb78

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


