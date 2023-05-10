From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH] docs: networking: fix x25-iface.rst heading & index order
Date: Wed, 10 May 2023 09:40:21 +0000
Message-ID: <168371162174.29703.9835991823894241053.git-patchwork-notify@kernel.org>
References: <20230510022914.2230-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683711621;
        bh=i813gVwW0eh94Hd0e9c4CgUV/9xwc/BrxxEBD+CKKdA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=NBgL9grkPb/ZTnmxNLJb31JSvXfjPp4ctudvrekaFEBvtxWCLCP6YqU+GsqCTjd9O
         1XvRJAYv+wSdTN1r5tLgLCK7oiHjlRpVyNFcXkvl6q7kRROhS6TtLHheVYyaZvu3Gx
         6PFRYzYfRO5cIuAtO8TCKKXjBSYV/XeV8xItUZvfwNQAB65V96tslV+l4pP/UgPoDq
         yMojXDyz2FbD6+1CTzBnsNWsGYAu4yJiWJFy8N1t6cv4XZIzTMzoMsl2WmXbMm04NT
         I21opM3P420uSBoiEqa2u2Swg2F3tG928pWZeOPSqmHod1RAe92RjswM/S2e2iFyYP
         93Y+lWJeX11GA==
In-Reply-To: <20230510022914.2230-1-rdunlap@infradead.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, mchehab@kernel.org, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, corbet@lwn.net, linux-doc@vger.kernel.org, ms@dev.tdt.de, linux-x25@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  9 May 2023 19:29:14 -0700 you wrote:
> Fix the chapter heading for "X.25 Device Driver Interface" so that it
> does not contain a trailing '-' character, which makes Sphinx
> omit this heading from the contents.
> 
> Reverse the order of the x25.rst and x25-iface.rst files in the index
> so that the project introduction (x25.rst) comes first.
> 
> [...]

Here is the summary with links:
  - docs: networking: fix x25-iface.rst heading & index order
    https://git.kernel.org/netdev/net/c/77c964dad99a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


