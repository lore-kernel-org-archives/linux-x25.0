From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net/x25: fix restart request/confirm handling
Date: Wed, 9 Dec 2020 14:11:25 -0800
Message-ID: <CAJht_EPj-4bv6D=Ojz5KCbk0NTVfjRyEA3NmMw7etxrq8GKu8Q@mail.gmail.com>
References: <20201126063557.1283-1-ms@dev.tdt.de> <20201126063557.1283-5-ms@dev.tdt.de>
 <CAJht_EMZqcPdE5n3Vp+jJa1sVk9+vbwd-Gbi8Xqy19bEdbNNuA@mail.gmail.com>
 <CAJht_ENukJrnh6m8FLrHBwnKKyZpzk6uGWhS4_eUCyDzrCG3eA@mail.gmail.com>
 <3e314d2786857cbd5aaee8b83a0e6daa@dev.tdt.de> <CAJht_ENOhnS7A6997CAP5qhn10NMYSVD3xOxcbPGQFLGb8z_Sg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uvqGywsXM1Q06kTXA1nF8b4vLpxDf9nEtyONmvLvXGM=;
        b=Zq+Yu3XA+wvyZdRM8e4Pv4WUDnljBil3Rdnd5/iH1zHyhnKqVybEqrRx39Zz63QOcb
         p0ihDZQ9gbeQttpFWswj/2RwondenZznIseagFYmycOS/WcZXmAZcTeqfIM5JP80ysK7
         a+35kvUWUcpCxllNG7OTejzO+GfGoCpUWv/U+SPJFCwobrKM7EIq/upg5QXtxNmzyQfT
         idKz6Z3fA0R8/rsWf28z81yHBfu78y1wfeDjoRvmDwUvWUmYOhKjhxAYIS9BnQGABdtI
         ISeSeMSLO6Wboq1aweV691RbGSHBJgxp/prfpPf/vxY6IV21QIPLpJz7OViXY6Ecmyp/
         lQlg==
In-Reply-To: <CAJht_ENOhnS7A6997CAP5qhn10NMYSVD3xOxcbPGQFLGb8z_Sg@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 9, 2020 at 1:47 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Wed, Dec 9, 2020 at 1:41 AM Martin Schiller <ms@dev.tdt.de> wrote:
> >
> > Right.
> > By the way: A "Restart Collision" is in practice a very common event to
> > establish the Layer 3.
>
> Oh, I see. Thanks!

Hi Martin,

When you submit future patch series, can you try ensuring the code to
be in a completely working state after each patch in the series? This
makes reviewing the patches easier. After the patches get applied,
this also makes tracing bugs (for example, with "git bisect") through
the commit history easier.
