From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net] net: hdlc_x25: Return meaningful error code in x25_open
Date: Fri, 05 Feb 2021 02:20:06 +0000
Message-ID: <161249160674.1910.18013606879384884718.git-patchwork-notify@kernel.org>
References: <20210203071541.86138-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612491606;
        bh=5RHPyIgg4HyVNRlVUr4A99jTZaL46a+/MeHKeYOW/H8=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=RCJYAbaumqVIo9QvqYTE+Fpz9fjDPIWVxuodO8Lhc5DZcg8DA57BXWhGfryHddQfn
         OEL69QacMbPrlzLL0cAGBC2nGet11mRadV9NZ/M1t1K3xLYG33WjcX8gWgxm5q8xOB
         s9svkfdFG/hXBB/nhJeX61pJl78OkUoexeARH3vkdOxq89XM0zrVRTn06faCeMTXqF
         OSMUadvSaMJx8CWS4PqGrxsR5I9va//Y0GZ9EBDIYzjJAMi5EsWdGAijhTWGLiHfp+
         b8ZRuQwUhakEd62iUtYfhTC2Gr7uzQyGot52SxLKJx8nIID9vlIRwgoT5toM8suNPN
         IjIV3q1itBsWw==
In-Reply-To: <20210203071541.86138-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de, khc@pm.waw.pl

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Tue,  2 Feb 2021 23:15:41 -0800 you wrote:
> It's not meaningful to pass on LAPB error codes to HDLC code or other
> parts of the system, because they will not understand the error codes.
> 
> Instead, use system-wide recognizable error codes.
> 
> Fixes: f362e5fe0f1f ("wan/hdlc_x25: make lapb params configurable")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: hdlc_x25: Return meaningful error code in x25_open
    https://git.kernel.org/netdev/net/c/81b8be68ef8e

You are awesome, thank you!
