From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net v5] net: lapb: Add locking to the lapb module
Date: Fri, 22 Jan 2021 13:49:58 -0800
Message-ID: <CAJht_EOr99tmcm44gM=K7T6mtwkBE0TGJ0jQ8HmCE2Nx3=eqQw@mail.gmail.com>
References: <20210121002129.93754-1-xie.he.0141@gmail.com> <b42575d44fb7f5c1253635a19c3e21e2@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xS49M72a2b/S7Fz9V9KsweEDhqR+Pq3GaKTvjEl5lTo=;
        b=ZZGHsg+tqXeE60XCB/EYVRkqTgygVmcptUIAIHwECriYYJaqC/JYzyHt3/YZzQx+ea
         Qn84U2hM2my38R/FHtL47OR2CW2ZjYy8YaGFeeLGBxLM4rjo428als/KdqcjuxQVTYwA
         QvbrfYyRS1WkN/2KAID1fAp3nUP1DG2GqpprgbvkBBiagdAYZlniQNagbzWL073vNjBl
         8QoUFnmr4GIgxce2JIASkpfcc0O5FRgQsSrVDvvPfPITujuplVSvGX839Oi0dg9am+zj
         9ov+kRrTQ40YHlf7c6eqxbPCugzxZq71TDaPBBsxs0MFUaw60s2xBKEZVfn/hBGhWVqn
         tl4g==
In-Reply-To: <b42575d44fb7f5c1253635a19c3e21e2@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Jan 22, 2021 at 1:07 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> I don't have the opportunity to test this at the moment, but code looks
> reasonable so far. Have you tested this at runtime?

Thanks! Yes, I have tested this using hdlc_x25.c, lapbether.c and (the
deleted) x25_asy.c drivers.
