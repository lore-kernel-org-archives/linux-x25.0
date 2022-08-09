From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net] net/x25: fix call timeouts in blocking connects
Date: Tue, 09 Aug 2022 04:00:14 +0000
Message-ID: <166001761447.6286.4599664715576942070.git-patchwork-notify@kernel.org>
References: <20220805061810.10824-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660017614;
        bh=0uHjm+KGcXAlJ7V6LXwNtiG4SVeDoNJSDLlk7EbtmWI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=h9pGFWPb+hUeNR7eRF3hmP03hcVneB+7HEaCkkxDhbfCeWuxgUPDoIOs9xJ8ANI6t
         Uc0O3YbWZz9vT1PzadqJCQZp4UG3qu+iqHI3mCDLigXh+nIOa9ZlsUBzeWn2gIqDjz
         CrZ/qsd28oJGfzAZJNv+MuxS6xvauIeTtLM7AJHjSBfykx8JSudfZiXP8sSCKW5bQW
         f6pbwKZOhPWd2GlleTMcR9fwKx4CW//+/PocSzinSIkyi5TBuFcxLQlvSZcyaxfJVL
         cvkDJ5uCKKFBgzzLT791fOpp3hDG/qiAOBWCTA8PbrO3jGXltAOqu9YeescmAv6prH
         P5LEv0PVhg4KQ==
In-Reply-To: <20220805061810.10824-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Aug 2022 08:18:10 +0200 you wrote:
> When a userspace application starts a blocking connect(), a CALL REQUEST
> is sent, the t21 timer is started and the connect is waiting in
> x25_wait_for_connection_establishment(). If then for some reason the t21
> timer expires before any reaction on the assigned logical channel (e.g.
> CALL ACCEPT, CLEAR REQUEST), there is sent a CLEAR REQUEST and timer
> t23 is started waiting for a CLEAR confirmation. If we now receive a
> CLEAR CONFIRMATION from the peer, x25_disconnect() is called in
> x25_state2_machine() with reason "0", which means "normal" call
> clearing. This is ok, but the parameter "reason" is used as sk->sk_err
> in x25_disconnect() and sock_error(sk) is evaluated in
> x25_wait_for_connection_establishment() to check if the call is still
> pending. As "0" is not rated as an error, the connect will stuck here
> forever.
> 
> [...]

Here is the summary with links:
  - [net] net/x25: fix call timeouts in blocking connects
    https://git.kernel.org/netdev/net/c/944e594cfa84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


