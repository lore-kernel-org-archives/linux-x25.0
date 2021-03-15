From: patchwork-bot+netdevbpf@kernel.org
Subject: Re: [PATCH net v2] net: hdlc_x25: Prevent racing between "x25_close" and
 "x25_xmit"/"x25_rx"
Date: Mon, 15 Mar 2021 19:40:08 +0000
Message-ID: <161583720808.23197.12484881848858187227.git-patchwork-notify@kernel.org>
References: <20210314112103.45242-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615837208;
        bh=R6h91gj5vHVWc+MLmad2vahHrwu1cI9nPg/3KlKm1Ak=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bgB4/GWfciXHLp6OVakDQlza2U7uGPeTnbrtwn4xtUpvwlVz3qFLLULd+obaT+nLr
         vjkhLQNrXzZmC9WVzA3XIcVbObp3zrTJ1mzps2HU7iwQj3uN0MDn1r7cyUQUNQ4bpf
         WUByKsTieYqGlu5TWo7AnFhG9q5fqz8DGM/deWDb3n/qB64uVNfvCozI6isDeGo0ez
         E6AGIBGWY5H1t3efvNE6X1YJR/jDYakSbM/JvhEi1GEWzpX3Ad1jc4I4qfQVWgmsyK
         GnMep7afF8Z5tmaz0SOdB1I7plO2SKUO2nGcXjdnEbQdd+XqK2QSKWJ3PNzLExeFL3
         ADbGprf5CRXvQ==
In-Reply-To: <20210314112103.45242-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: ms@dev.tdt.de, khc@pm.waw.pl, davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Sun, 14 Mar 2021 04:21:01 -0700 you wrote:
> "x25_close" is called by "hdlc_close" in "hdlc.c", which is called by
> hardware drivers' "ndo_stop" function.
> "x25_xmit" is called by "hdlc_start_xmit" in "hdlc.c", which is hardware
> drivers' "ndo_start_xmit" function.
> "x25_rx" is called by "hdlc_rcv" in "hdlc.c", which receives HDLC frames
> from "net/core/dev.c".
> 
> [...]

Here is the summary with links:
  - [net,v2] net: hdlc_x25: Prevent racing between "x25_close" and "x25_xmit"/"x25_rx"
    https://git.kernel.org/netdev/net/c/bf0ffea336b4

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


