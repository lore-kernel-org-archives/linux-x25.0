From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net V2] net/x25: Fix null-ptr-deref caused by x25_disconnect
Date: Sat, 26 Mar 2022 18:50:10 +0000
Message-ID: <164832061055.28772.13748131132872742265.git-patchwork-notify@kernel.org>
References: <20220326104346.91790-1-duoming@zju.edu.cn>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648320610;
        bh=An/i1g5oXYjt2a1ViSlXAPzVxWsKvxZ9XRyMCj3S2C0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=KVLvFrJL8OY5a6wBnkpK28z7rYc2KJUE3PRQ7MFDyTKiqzMOCvA85pMJcm0PIXwgW
         gKdjrx0Rju03WOhg9SYIz/ERGsINsE5PnUP8mjMuLN8Qfdf4QJkxh5YdgpyZFsPxzY
         ow+tuUzDsBnCFaGZOPSodR8NWh5MfW58bpru73nZIn6mymg5eStN0MXAR9s+D3UUJH
         Vxqxas4l1hLpi1zB9u4/Ro1n0ES5I/qLu/Oc8v5fGGFVgy3f43j1+RCZl4QkeO0IWW
         heUZ22jdVRbLjcZS0116wo3xDh4ri6iovl7ZkF1gZjbHaUbHRrYe9la3WFFiLFEllS
         AnK+o/m1omPNA==
In-Reply-To: <20220326104346.91790-1-duoming@zju.edu.cn>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, tanxin.ctf@gmail.com, xiyuyang19@fudan.edu.cn, linma@zju.edu.cn

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Sat, 26 Mar 2022 18:43:46 +0800 you wrote:
> When the link layer is terminating, x25->neighbour will be set to NULL
> in x25_disconnect(). As a result, it could cause null-ptr-deref bugs in
> x25_sendmsg(),x25_recvmsg() and x25_connect(). One of the bugs is
> shown below.
> 
>     (Thread 1)                 |  (Thread 2)
> x25_link_terminated()          | x25_recvmsg()
>  x25_kill_by_neigh()           |  ...
>   x25_disconnect()             |  lock_sock(sk)
>    ...                         |  ...
>    x25->neighbour = NULL //(1) |
>    ...                         |  x25->neighbour->extended //(2)
> 
> [...]

Here is the summary with links:
  - [net,V2] net/x25: Fix null-ptr-deref caused by x25_disconnect
    https://git.kernel.org/netdev/net/c/7781607938c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


