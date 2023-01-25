From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH v2] net/x25: Fix to not accept on connected socket
Date: Wed, 25 Jan 2023 10:00:16 +0000
Message-ID: <167464081679.8627.16186557969987796753.git-patchwork-notify@kernel.org>
References: <20230123194323.GA116515@ubuntu>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674640816;
        bh=UamnZL0q5DHDLkY75y5Nxam4bD27yr/asZU4Aseivsc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=EyW1SugmykJvZL164x9ZsUbxj8gBJB3XPhzmvxffNbEXziji5GdzFH17KYAP7WrOb
         ok7DIaKNWqLpfmD8xxFDgvBhHoAFpgyuuGIMubKC6dIUMhEo/UviemnVo8h4KkHlU6
         F7s3FKNiShfjCTk4s/YrVcwWGR3/xaC7eWKROiM9rny3CnxQSJX1dw5eG/vGyTfFWo
         6aZjPItDWlg7YjlFAC2rmCku7Sq8UP03MAlkurJWp4G4UF8BDy+NE7anXjjOY96WUY
         k7zDygh6TgH5O57S+uhfsjZwZmHL9uheMkB07fMboiN3FwvzV71DANUfdTQQszlZwd
         qMFazTLIAAyqA==
In-Reply-To: <20230123194323.GA116515@ubuntu>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Hyunwoo Kim <v4bel@theori.io>
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, imv4bel@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon, 23 Jan 2023 11:43:23 -0800 you wrote:
> When listen() and accept() are called on an x25 socket
> that connect() succeeds, accept() succeeds immediately.
> This is because x25_connect() queues the skb to
> sk->sk_receive_queue, and x25_accept() dequeues it.
> 
> This creates a child socket with the sk of the parent
> x25 socket, which can cause confusion.
> 
> [...]

Here is the summary with links:
  - [v2] net/x25: Fix to not accept on connected socket
    https://git.kernel.org/netdev/net/c/f2b0b5210f67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


