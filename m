From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net] net: lapbether: fix issue of invalid opcode in
 lapbeth_open()
Date: Tue, 08 Nov 2022 12:30:15 +0000
Message-ID: <166791061529.27754.528965881676739737.git-patchwork-notify@kernel.org>
References: <20221107011445.207372-1-shaozhengchao@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667910615;
        bh=SonIbouVyw/qkHMHGtqoXYaelFJP7EQ3+xGcdErC0FA=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=plBR5rVswRpwN9LGq1vX3pDPetOc11uyihNDnQuDA/wIKjEeswmCFvOxR24xXZGwP
         cbGqKp6wHxp2D2IwMevRWPFrG2a+k6/psjHlswvZfseMiYHwnbdX4jhx7m+/UyzYA0
         N6KyWp/N1t76C4gqsLVRdOzdwI9bFOtx9rGUOVq+8VqShLt5hx8zPRrmJIBp2059LZ
         N3qzzmCQ+7NIsvO+sAJxo6F3O/W56o4pxVDXIlP62lRZkireP6Rne92bnnfNTk7qCT
         NmlzFFGny01fxAISjtDZLBxooUqsm+LEymOPYjvOvQuD1m8jA2qmlFLctyoyWgHk1P
         jrkOTu+1+0X7Q==
In-Reply-To: <20221107011445.207372-1-shaozhengchao@huawei.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, xie.he.0141@gmail.com, weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 7 Nov 2022 09:14:45 +0800 you wrote:
> If lapb_register() failed when lapb device goes to up for the first time,
> the NAPI is not disabled. As a result, the invalid opcode issue is
> reported when the lapb device goes to up for the second time.
> 
> The stack info is as follows:
> [ 1958.311422][T11356] kernel BUG at net/core/dev.c:6442!
> [ 1958.312206][T11356] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> [ 1958.315979][T11356] RIP: 0010:napi_enable+0x16a/0x1f0
> [ 1958.332310][T11356] Call Trace:
> [ 1958.332817][T11356]  <TASK>
> [ 1958.336135][T11356]  lapbeth_open+0x18/0x90
> [ 1958.337446][T11356]  __dev_open+0x258/0x490
> [ 1958.341672][T11356]  __dev_change_flags+0x4d4/0x6a0
> [ 1958.345325][T11356]  dev_change_flags+0x93/0x160
> [ 1958.346027][T11356]  devinet_ioctl+0x1276/0x1bf0
> [ 1958.346738][T11356]  inet_ioctl+0x1c8/0x2d0
> [ 1958.349638][T11356]  sock_ioctl+0x5d1/0x750
> [ 1958.356059][T11356]  __x64_sys_ioctl+0x3ec/0x1790
> [ 1958.365594][T11356]  do_syscall_64+0x35/0x80
> [ 1958.366239][T11356]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> [ 1958.377381][T11356]  </TASK>
> 
> [...]

Here is the summary with links:
  - [net] net: lapbether: fix issue of invalid opcode in lapbeth_open()
    https://git.kernel.org/netdev/net/c/3faf7e14ec0c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


