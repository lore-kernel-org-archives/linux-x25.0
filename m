From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Tue, 02 Feb 2021 16:50:07 +0000
Message-ID: <161228460738.23213.13014448307375459803.git-patchwork-notify@kernel.org>
References: <20210201055706.415842-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612284607;
        bh=1pyS1O/tfQWwIdEuctiuv1WSn/cICDq2gO6ZI5MLyZA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=qt+bYOoaif+OB/INxcPDne0PeMVbxxORuDpNI16pbNOCCU4a5tZO5vvLS03z5jveX
         G+Bafubjefm+jxrIXV/LLBvJJ1dlbTE/zFrmH+gWJFNTYiOvPr2acASlyDvPfizQdx
         ozHjlJ/igtTdoamKzZ7Zap5VGKntlfdpGdyx3jpH/uesYIftYG3HEx+LYDWtOkx+1E
         MRLqH2573UW9iEKCNpmiUdHQlggyORBwu29gY6WZNCpqMWmJ4Av/0ghsw2pSGkdq1y
         W3tkKlIEWlxIT5dxLb3T2AjEN8vvJ9Kr5EZ7dksAAzxzMZ70lGVHX311Lna1tmYlK8
         euCa+Je5VO2Uw==
In-Reply-To: <20210201055706.415842-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Sun, 31 Jan 2021 21:57:06 -0800 you wrote:
> When sending a packet, we will prepend it with an LAPB header.
> This modifies the shared parts of a cloned skb, so we should copy the
> skb rather than just clone it, before we prepend the header.
> 
> In "Documentation/networking/driver.rst" (the 2nd point), it states
> that drivers shouldn't modify the shared parts of a cloned skb when
> transmitting.
> 
> [...]

Here is the summary with links:
  - [net] net: lapb: Copy the skb before sending a packet
    https://git.kernel.org/netdev/net/c/88c7a9fd9bdd

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


