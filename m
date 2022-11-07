From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net] net: lapbether: fix issue of dev reference count leakage
 in lapbeth_device_event()
Date: Mon, 07 Nov 2022 09:40:15 +0000
Message-ID: <166781401532.17779.17066719090536498926.git-patchwork-notify@kernel.org>
References: <20221103090537.282969-1-shaozhengchao@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667814015;
        bh=eGeEgr0/KwhblYgi5vtUy4mDQ1/GCwRgKOb0nMCdRFI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=DoFnS8+GAdtVtqK4E447+mL47anTSPVWtZ0KR/3cNJ1VaCRHC/SbbpzrSkGzapTBg
         A4c4lbLm7W8OkXtiN8SN8olJC3OIaClwFRNjWJR25D92FR8SoZ1keuPOjl+1x5LB26
         nWBchFAsOUqqVp/lz4pnwa7YyrjdmdjQwiYF7Rf8wmF3HGN3ebHgW0o+cIyGik8rWF
         RVddaEGYqm04/PvHWbrbpCl14ZyCUZiB4eHPT44+a/XATL/d8ouyed0r8IlGGDqb21
         r2kBmrpIE6n3+63nVm7q6EqyD4U0AbH1CImgGKIkbsUCa5Eaye8Mkbi+wxrSrbm+32
         J6xoPtEGwIJkg==
In-Reply-To: <20221103090537.282969-1-shaozhengchao@huawei.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 3 Nov 2022 17:05:37 +0800 you wrote:
> When following tests are performed, it will cause dev reference counting
> leakage.
> a)ip link add bond2 type bond mode balance-rr
> b)ip link set bond2 up
> c)ifenslave -f bond2 rose1
> d)ip link del bond2
> 
> [...]

Here is the summary with links:
  - [net] net: lapbether: fix issue of dev reference count leakage in lapbeth_device_event()
    https://git.kernel.org/netdev/net/c/531705a76549

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


