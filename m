From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net] net: lapbether: Remove netif_start_queue /
 netif_stop_queue
Date: Wed, 10 Mar 2021 00:10:07 +0000
Message-ID: <161533500795.28934.16429387083913505207.git-patchwork-notify@kernel.org>
References: <20210307113309.443631-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615335008;
        bh=PGEt5bFRFlNAUoeIB5rHrSNUk4l8L6wARw3TkEvgqkQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nUtdVZUt7Xa+KzZ7W6cWbh1b6TM4Ec3chAEuh+V6kFkrubI9OX2r7S5m8fnHUYZgr
         kuUBskTungauTMmbIDnjF+M20nbr13QXYf3BtxdU+5l0Qdzr131A2mxWA7WmgnyeS/
         IchxdLpKK0HNwmlXgbr+5IXnObClEswEMw6KjrcsKiV27VMnxkEA1Dsjfcuu7FqqCq
         bujscD767VU2XNSOFUhCV/Lnl36Nvp3bovauLjsyV1bTeVW3UxwndhE26WKV34mfHR
         I+tvX2wsBAfQyVBj/dQ4wnUJiWUGQztVQKtm4iw9UTHOAkVPm22cakdLbXyHkARSJB
         A+xgM7kTTISDg==
In-Reply-To: <20210307113309.443631-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: ms@dev.tdt.de, davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Sun,  7 Mar 2021 03:33:07 -0800 you wrote:
> For the devices in this driver, the default qdisc is "noqueue",
> because their "tx_queue_len" is 0.
> 
> In function "__dev_queue_xmit" in "net/core/dev.c", devices with the
> "noqueue" qdisc are specially handled. Packets are transmitted without
> being queued after a "dev->flags & IFF_UP" check. However, it's possible
> that even if this check succeeds, "ops->ndo_stop" may still have already
> been called. This is because in "__dev_close_many", "ops->ndo_stop" is
> called before clearing the "IFF_UP" flag.
> 
> [...]

Here is the summary with links:
  - [net] net: lapbether: Remove netif_start_queue / netif_stop_queue
    https://git.kernel.org/netdev/net/c/f7d9d4854519

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


