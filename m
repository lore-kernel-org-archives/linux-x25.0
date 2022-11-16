From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net] net/x25: Fix skb leak in x25_lapb_receive_frame()
Date: Wed, 16 Nov 2022 04:30:14 +0000
Message-ID: <166857301485.26862.5354209271873264892.git-patchwork-notify@kernel.org>
References: <20221114110519.514538-1-weiyongjun@huaweicloud.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668573015;
        bh=2kZ4aJoGsZm6LAq4RGp2IrLNG7oJ12Koj7oq+oS4yOc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=iumxwTlO40SCWvBmf2vr3zrKPuw43/+tY0JS5s/cKRL9QPjpibYaUcFlX3GMhCkv5
         Qh0H8mVUaHRjtozRV3eT+FbMAmvYQJ/ft3h9oFniDBHYGvWoOELJURwIPuw6xBeOlN
         vhBXzQo4cyxhOOPU3RKXo/9P+DJVQh2+nCC50fi3vQ6Ob0BvDcjX3oPkaZuvM+jUFo
         WQVe/URMND5vrzSc3cwpfxACMoroAMb5BSkxd94prJ6J/Y6T0ws99W3tVVrETmtcFv
         Qcr2i224gXWqUreHGIFLMQ/vD2fbFW8NT/FznbkgY1Xa4NT66o3bwx2QOnISI4z8F3
         czHq9S+x91QXw==
In-Reply-To: <20221114110519.514538-1-weiyongjun@huaweicloud.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wei Yongjun <weiyongjun@huaweicloud.com>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, andrew.hendry@gmail.com, mattjd@gmail.com, weiyongjun1@huawei.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Nov 2022 11:05:19 +0000 you wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> x25_lapb_receive_frame() using skb_copy() to get a private copy of
> skb, the new skb should be freed in the undersized/fragmented skb
> error handling path. Otherwise there is a memory leak.
> 
> Fixes: cb101ed2c3c7 ("x25: Handle undersized/fragmented skbs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net] net/x25: Fix skb leak in x25_lapb_receive_frame()
    https://git.kernel.org/netdev/net/c/2929cceb2fcf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


