From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v3 0/6] net/x25: netdev event handling
Date: Thu, 19 Nov 2020 00:09:15 -0800
Message-ID: <CAJht_EMb5uKo6J7BAaiC9mN-ZcG+xDGc2Q9NC0ybof61vr4m2w@mail.gmail.com>
References: <20201118135919.1447-1-ms@dev.tdt.de> <CAJht_EPB5g5ahHrVCM+K8MZG9u5bmqfjpB9-UptTt+bWqhyHWw@mail.gmail.com>
 <ae263ce5b1b31bfa763f755bdb3ef962@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PVVrHpLNgq+kl9A2aIZQl8Ll9b4XaLdyqAsmoMcdYJs=;
        b=Lt9kWa/44LbPO5/cPquY/oD00iPelLttboNoTpKbK9dVAWzH3RYKbgHDaeT6P23ez6
         XYjih+2Wx91QAfzcjVrjNcMRQqyKMzvKWszEcpIYw3l4r6MDSSxf6w+tsg82r209sIyJ
         IEGvTF5hruSESkPBKHd9ynQL4Fw5UaK/5mi3S9/aJHYwNANMhk2Fi5uPGPs8iLd0R+TY
         q/ATxd8/gZwHYIXOpNQW2VZwlEK4lPQJweq4lAc8Om3wvrsXoz6C61JbXMeYgzktl/o9
         a8nEhrjC+UR3qzkMKQRfh1Iig1LdAZBtpa2/9ZrJ0aUI/CPg4/NBgGPjEW6ESCBWn4VG
         ckUg==
In-Reply-To: <ae263ce5b1b31bfa763f755bdb3ef962@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Nov 18, 2020 at 11:02 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> On 2020-11-18 15:47, Xie He wrote:
> >
> > But... Won't it be better to handle L2 connections in L2 code?
> >
> > For example, if we are running X.25 over XOT, we can decide in the XOT
> > layer whether and when we reconnect in case the TCP connection is
> > dropped. We can decide how long we wait for responses before we
> > consider the TCP connection to be dropped.
> >
> > If we still want "on-demand" connections in certain L2's, we can also
> > implement it in that L2 without the need to change L3.
> >
> > Every L2 has its own characteristics. It might be better to let
> > different L2's handle their connections in their own way. This gives
> > L2 the flexibility to handle their connections according to their
> > actual link characteristics.
> >
> > Letting L3 handle L2 connections also makes L2 code too related to /
> > coupled with L3 code, which makes the logic complex.
>
> OK, I will give it a try. But we need to keep the possibility to
> initiate and terminate the L2 connection from L3.

OK. Thanks so much!

> In the on demand scenario i mentioned, the L2 should be connected when
> the first L3 logical channel goes up and needs to be disconnected, when
> the last L3 logical channel on an interface is cleared.

I see. Maybe we can do it this way:

When L3 wants to initiate the first L3 connection, it can check
whether the L2 connection is established, and if it is not, it can
instruct L2 to connect. This is the same as what the current code
(before this series) does.

When the last L3 connection is terminated, we can let L3 use the
one-byte header to "suggest" (rather than "instruct") L2 to terminate
the L2 connection. L2 can choose to either terminate the connection or
continue to keep it, based on whether it is in on-demand mode.
