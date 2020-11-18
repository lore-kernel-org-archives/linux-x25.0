From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v3 0/6] net/x25: netdev event handling
Date: Wed, 18 Nov 2020 06:47:55 -0800
Message-ID: <CAJht_EPB5g5ahHrVCM+K8MZG9u5bmqfjpB9-UptTt+bWqhyHWw@mail.gmail.com>
References: <20201118135919.1447-1-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpeXNv2DK2M3hwS0Spytct1KKHhQGCtOUMK4RpnJ4T4=;
        b=sXKRhHCke3eRPk50KGQv6Dm7zUZ2LIT2cvvLaR1REP2SBUzFCa51DORMzw/Dee2EE4
         6tTcCg29G1SfKDr/0kDT44Fg1Scri8gFoR9SOvIhGV+qsdI37gcBuuhfx6HOfD1kZvMt
         8gX18KQ7+xB0tMvNSllHKUl46Uf8L9yzYdEOxUWZrFzrDIQm7hKFVwl/89cV+IozmZ2k
         FKDZ3e4T5v1D1eM2zWAj62BmpJpcW3DyrQ0z6pMZQZFWkXxOODtvt/YwhVOzQzEiMaVs
         +uGH+pAu5jlUWIQ6D4HdtcUpkOrpnAYMliaIt4o9gDQeG+lZBTIl0W4y6f6eDzlsxtyU
         ubsQ==
In-Reply-To: <20201118135919.1447-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Nov 18, 2020 at 5:59 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> ---
> Changes to v2:
> o restructure complete patch-set
> o keep netdev event handling in layer3 (X.25)

But... Won't it be better to handle L2 connections in L2 code?

For example, if we are running X.25 over XOT, we can decide in the XOT
layer whether and when we reconnect in case the TCP connection is
dropped. We can decide how long we wait for responses before we
consider the TCP connection to be dropped.

If we still want "on-demand" connections in certain L2's, we can also
implement it in that L2 without the need to change L3.

Every L2 has its own characteristics. It might be better to let
different L2's handle their connections in their own way. This gives
L2 the flexibility to handle their connections according to their
actual link characteristics.

Letting L3 handle L2 connections also makes L2 code too related to /
coupled with L3 code, which makes the logic complex.

> o add patch to fix lapb_connect_request() for DCE
> o add patch to handle carrier loss correctly in lapb
> o drop patch for x25_neighbour param handling
>   this may need fixes/cleanup and will be resubmitted later.
>
> Changes to v1:
> o fix 'subject_prefix' and 'checkpatch' warnings
>
> ---
>
> Martin Schiller (6):
>   net/x25: handle additional netdev events
>   net/lapb: fix lapb_connect_request() for DCE
>   net/lapb: handle carrier loss correctly
>   net/lapb: fix t1 timer handling for DCE
>   net/x25: fix restart request/confirm handling
>   net/x25: remove x25_kill_by_device()
