From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH v3] net/x25: Fix to not accept on connected socket
Date: Sat, 28 Jan 2023 07:20:34 +0000
Message-ID: <167489043455.16992.12517633627951269745.git-patchwork-notify@kernel.org>
References: <20230125110514.GA134174@ubuntu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674890434;
        bh=MeyRTq/arodCF8K5T7IZpkPAOx4UAPBza5Pct0eGIjI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FDCdhCzLMvi+7ovTVkyKQFAYh5K740tEV1O/iDNCTjEN5w6tjO5fFG0pLWPx1uyby
         vTy839buesfXbrUiRHPSSnDFn7oyPUbXsDHXenEWIMfB3i3GevzxQBYyGWUNDChJuN
         dgcl7FyMMEVyz0kYZHecmaG2OBHdmVWR6q95P72QDQqRdm/2AnojhafuosjXKK1HaH
         Kd/HwtTTtZi4A9yVho8adWOPmWGTvNh8fmmfVU2kTL/o08tPFC7eYziARBQr3JZtcd
         4541dsQ2bsQSLxZEr+zKTyTzqffTdeaUegGLs2mhiyZ60u+RegdQZpNNFauIZ25VwB
         +bNKaz9KdcGVg==
In-Reply-To: <20230125110514.GA134174@ubuntu>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hyunwoo Kim <v4bel@theori.io>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuniyu@amazon.com, imv4bel@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Jan 2023 03:05:14 -0800 you wrote:
> If you call listen() and accept() on an already connect()ed
> x25 socket, accept() can successfully connect.
> This is because when the peer socket sends data to sendmsg,
> the skb with its own sk stored in the connected socket's
> sk->sk_receive_queue is connected, and x25_accept() dequeues
> the skb waiting in the sk->sk_receive_queue.
> 
> [...]

Here is the summary with links:
  - [v3] net/x25: Fix to not accept on connected socket
    https://git.kernel.org/netdev/net-next/c/f2b0b5210f67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


