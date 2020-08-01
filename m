From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Sat, 1 Aug 2020 09:30:40 -0400
Message-ID: <CA+FuTSdJ1c0R2qmKtm9vWpKnMv=-B0yAaronGkqg=jYZBfqceA@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_ENjHRExBEHx--xmqnOy1MXY_6F5XZ_exinSfa6xU_XDJg@mail.gmail.com>
 <CA+FuTSf_nuiah6rFy-KC1Taw+Wc4z0G7LzkAm-+Ms4FzYmTPEw@mail.gmail.com>
 <CAJht_ENYxy4pseOO9gY=0R0bvPPvs4GKrGJOUMx6=LPwBa2+Bg@mail.gmail.com>
 <CA+FuTSeusqdfkqZihFhTE9vhcL5or6DEh8UffaKM2Px82z6BZQ@mail.gmail.com> <CAJht_EO4b=jC8KarwZyF1M3T57MrFCDvo-+Agnm9qD4pSCmODQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v3C9Qa2vvBuXW0NiH2BbzW1dmdPuZEiz1+gKzQUudVo=;
        b=qxMxZnYwCxy6AFjcJqZXgJnMjC7YsJhWTmcUDtnhzHPmJeGAFfP8wTtxbIXSzr49g/
         2iqWM+ydNLLVw5AFK97KUC8LGAwejRyEyGhu7YcJ19XleNgqVpB8EGU6ZgOqfXvQqRB2
         W3AH/5mncL3pM0om77RNroucRNt3nLkYTMO63+shCrFfhZk4V+KySrTvr/hXfw7LNxih
         zqVQmg3r3htPUb28h2FFYKpDiMvVeo2OgpsstbrY4Tht0EddQLaa9jhmapudu4HKakzh
         QtduZOcPn8bd6A++x3yxtCHJ9hZ1/T9N10/z6564eVLVFn1aNbmlzdqshm3QVFEUYOWr
         5ESA==
In-Reply-To: <CAJht_EO4b=jC8KarwZyF1M3T57MrFCDvo-+Agnm9qD4pSCmODQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Brian Norris <briannorris@chromium.org>

On Sat, Aug 1, 2020 at 8:46 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Fri, Jul 31, 2020 at 7:33 PM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > I quickly scanned the main x.25 datapath code. Specifically
> > x25_establish_link, x25_terminate_link and x25_send_frame. These all
> > write this 1 byte header. It appears to be an in-band communication
> > means between the network and data link layer, never actually ending
> > up on the wire?
>
> Yes, this 1-byte header is just a "fake" header that is only for
> communication between the network layer and the link layer. It never
> ends up on wire.
>
> I think we can think of it as the Ethernet header for Wifi drivers.
> Although Wifi doesn't actually use the Ethernet header, Wifi drivers
> use a "fake" Ethernet header to communicate with code outside of the
> driver. From outside, it appears that Wifi drivers use the Ethernet
> header.
>
> > > The best solution might be to implement header_ops for X.25 drivers
> > > and let dev_hard_header create this 1-byte header, so that
> > > hard_header_len can equal to the header length created by
> > > dev_hard_header. This might be the best way to fit the logic of
> > > af_packet.c. But this requires changing the interface of X.25 drivers
> > > so it might be a big change.
> >
> > Agreed.
>
> Actually I tried this solution today. It was easier to implement than
> I originally thought. I implemented header_ops to make dev_hard_header
> generate the 1-byte header. And when receiving, (according to the
> requirement of af_packet.c) I pulled this 1-byte header before
> submitting the packet to upper layers. Everything worked fine, except
> one issue:
>
> When receiving, af_packet.c doesn't handle 0-sized packets well. It
> will drop them. This causes an AF_PACKET/DGRAM socket to receive no
> indication when it is connected or disconnected. Do you think this is
> a problem?

The kernel interface cannot be changed. If packet sockets used to pass
the first byte up to userspace, they have to continue to do so.

So I think you can limit the header_ops to only dev_hard_header.

> Actually I'm also afraid that future changes in af_packet.c
> will make 0-sized packets not able to pass when sending as well.
>
> > Either lapbeth_xmit has to have a guard against 0 byte packets before
> > reading skb->data[0], or packet sockets should not be able to generate
> > those (is this actually possible today through PF_PACKET? not sure)
> >
> > If SOCK_DGRAM has to always select one of the three values (0x00:
> > data, 0x01: establish, 0x02: terminate) the first seems most sensible.
> > Though if there is no way to establish a connection with
> > PF_PACKET/SOCK_DGRAM, that whole interface may still be academic.
> > Maybe eventually either 0x00 or 0x01 could be selected based on
> > lapb->state.. That however is out of scope of this fix.
>
> Yes, I think the first solution may be better, because we need to have
> a way to drop 0-sized DGRAM packets (as long as we need to include the
> 1-byte header when sending DGRAM packets) and I'm not aware
> af_packet.c can do this.
>
> Yes, I think maybe the best way is to get rid of the 1-byte header
> completely and use other ways to ask the driver to connect or
> disconnect, or let it connect and disconnect automatically.

Fixes should be small and targeted. Any larger refactoring is
best addressed in a separate net-next patch.



> > Normally a fix should aim to have a Fixes: tag, but all this code
> > precedes git history, so that is not feasible here.
>
> Thanks for pointing this out!
