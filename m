From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net-next] net: x25: Use list_for_each_entry() to simplify code
 in x25_route.c
Date: Thu, 10 Jun 2021 21:10:04 +0000
Message-ID: <162335940457.9889.14285326201925967368.git-patchwork-notify@kernel.org>
References: <20210610124826.3833818-1-wanghai38@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623359404;
        bh=l14ZhZfB2w4EtQwcXkG2sxnF5xa2hYaN1kEeDUONisE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=t95FyLButH/bS2lTq4tDRm5j05UdtWhPeELFzN5lKdK8mYbw1bvSxdD4zXHUFFPF6
         fKZc74cp5iCWExKTTNs6GgtfbYSdG+AOj5fa0DW32ZMjOK2iZRdBC2qgfp7Ver85Q2
         3QmES26xwsalLl1ANQRCESLVdJBWt5EsOT7FARYuTNxLvdEzmhMrYa0ylqrklBbEAc
         Vslh8qOFK9n7UpdIaXE7M3ifzMOEcqXt8Z39d5cWYWzBOuC4+ZRZyqSNdoY+mx9RH4
         HG0k1tAjiKCibOvZvCLeui7bl1jO5SZbEO96RNtD6+AhmVri61nKF9hL/S0PThzRt/
         dyxQEGrgr5OWw==
In-Reply-To: <20210610124826.3833818-1-wanghai38@huawei.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wang Hai <wanghai38@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, ms@dev.tdt.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Thu, 10 Jun 2021 20:48:26 +0800 you wrote:
> Convert list_for_each() to list_for_each_entry() where
> applicable. This simplifies the code.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  net/x25/x25_route.c | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)

Here is the summary with links:
  - [net-next] net: x25: Use list_for_each_entry() to simplify code in x25_route.c
    https://git.kernel.org/netdev/net-next/c/bc831facf8a1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


