From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
Date: Thu, 30 Jul 2020 17:24:27 -0700
Message-ID: <CA+ASDXPRLqq=vxnkF4z8=xvuqOKuuoqifvsNsERWg9uYJrFXgg@mail.gmail.com>
References: <20200726110524.151957-1-xie.he.0141@gmail.com>
 <20200728195246.GA482576@google.com> <CAJht_EOcRx=J5PiZwsSh+0Yb0=QJFahqxVbeMgFbSxh+cNZLew@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bCnm2zhl1XL25GtJr/etbA3HQMGW2EG8k+e5UYsAJpw=;
        b=lJtMgGbhxO85pPQ3zmFyvT81x30eZCJUjTqGcbLx9wGlUYe1jJjdPY6ReHw6gFzteV
         PGVcl91LOUNhqC6ggzpRMQ6AloWyvYhtERJOjsT7jyjSwQaTtyqF3aHUeBUqvy/VXOBh
         oblTtIls0ssqkEbpSn4i+FQqshusH5TL4zGs4=
In-Reply-To: <CAJht_EOcRx=J5PiZwsSh+0Yb0=QJFahqxVbeMgFbSxh+cNZLew@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>

On Tue, Jul 28, 2020 at 6:42 PM Xie He <xie.he.0141@gmail.com> wrote:
> On Tue, Jul 28, 2020 at 12:52 PM -0700
> Brian Norris <briannorris@chromium.org> wrote:
> > What is the intention with this X25 protocol? I guess the headers added
> > in lapbeth_data_transmit() are supposed to be "invisible", as with this
> > note in af_packet.c?
...
> This driver is not intended to be used with IPv4 or IPv6 protocols,
> but is intended to be used with a special "X.25" protocol. That's the
> reason the device type is ARPHRD_X25. I used "grep" in the X.25
> network layer code (net/x25) and I found there's nowhere
> "dev_hard_header" is called. I also used "grep" in all the X.25

That well could just be a bug in net/x25/. But from context, it does
appear that X.25 does not intend to expose its headers to higher
layers.

> drivers in the kernel (lapbether.c, x25_asy.c, hdlc_x25.c under
> drivers/net/wan) and I found no driver implemented "header_ops". So I
> think the X.25 networking code doesn't expect any header visible
> outside of the device driver, and X.25 drivers should make their
> headers invisible outside of them.
>
> So I think hard_header_len should be 0 for all X.25 drivers, so that
> they can be used correctly with af_packet.c.
>
> I don't know if this sounds plausible to you. If it does, could you
> please let me have your name in a "Reviewed_by" tag. It would be of
> great help to have your support. Thanks!

Sure, I can do that:

Reviewed-by: Brian Norris <briannorris@chromium.org>

I guess x25 is basically an abandoned project, if you're coming to me for this?
