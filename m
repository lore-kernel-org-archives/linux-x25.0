From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net] net: lapb: Decrease the refcount of "struct lapb_cb" in
 lapb_device_event
Date: Mon, 04 Jan 2021 21:50:08 +0000
Message-ID: <160979700876.8172.3140864000017286214.git-patchwork-notify@kernel.org>
References: <20201231174331.64539-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609797008;
        bh=ktLasPF5LL+xB2S/z9EYKk/ANhzEOT2Nf8DBtMLtWA0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=X9rjNaXl/h3uKSt29dhMvZkMqdzS3nv51t1zei1JuoJmQXCBewd7lSZy7WpT7x1Qa
         x9A8V6MzNS9Cn2jMKVUeEgqot/ei1XrAFbC8tjOewsRb1ui+1f5t60pSFLl1ZIVAJi
         pvu3L2M2+WDUpuN6UdUcEVbCBpFJ3SN2FTGchD/o9x1y+Ud83kq8Zy8o6pHDgW2aEL
         5jjtQvRHIYPsGAfN+ZRwBKo12CIsvYcJW/D/K8lJOFMHf02B04GEHELd+9di6J0AYV
         /XPkAlM6sq4fffMvKT8O+E7Tvmnaaezh3AjbdOcECc26FVpl0TXJ1KgvNMPRFTPBHr
         jggjMLEOO7EXQ==
In-Reply-To: <20201231174331.64539-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Thu, 31 Dec 2020 09:43:31 -0800 you wrote:
> In lapb_device_event, lapb_devtostruct is called to get a reference to
> an object of "struct lapb_cb". lapb_devtostruct increases the refcount
> of the object and returns a pointer to it. However, we didn't decrease
> the refcount after we finished using the pointer. This patch fixes this
> problem.
> 
> Fixes: a4989fa91110 ("net/lapb: support netdev events")
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: lapb: Decrease the refcount of "struct lapb_cb" in lapb_device_event
    https://git.kernel.org/netdev/net/c/b40f97b91a3b

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


