From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Mon, 23 Nov 2020 00:31:36 -0800
Message-ID: <CAJht_EPc8MF1TjznSjWTPyMbsrw3JVqxST5g=eF0yf_zasUdeA@mail.gmail.com>
References: <20201120054036.15199-1-ms@dev.tdt.de> <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
 <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com> <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A2OCYPW48+EaJEiSvyQJ2+kFYlsiz/LUK7yoFIj7s/0=;
        b=ARYHclAhefMjQHT4pgy8KkNlOofEUe0LkbQSPGkdnzqUV2+hD6tBxSunTjYE5sCLw5
         uvuR9gciPL3KO0c8LfdT/WsDQyWWd+8g4+W/ZeM7hApLOw7CHS6PwFO0uXjUfPIpW8Rd
         atZazrkI4VZL27dree/jNephYhEoySeNnC0jFyiocUZ8WlGVYoIqytNkHjT/0gmiGaOx
         S2qdJszwvrGaAonzGFg9OAPsvqYO5yNiCoSt7nS2C8dHNUDX2EvA1Pa+Sj0kgJawS9td
         uJZB6Sp8xX5ouYYG2dtlYMSJ4/ani1XY3s1n5qXaCSlAnTxylkV4YOteyF2R5YeO31N9
         txqg==
In-Reply-To: <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Sun, Nov 22, 2020 at 10:55 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> No, they aren't independent. The carrier can only be up if the device /
> interface is UP. And as far as I can see a NETDEV_CHANGE event will also
> only be generated on interfaces that are UP.
>
> So you can be sure, that if there is a NETDEV_CHANGE event then the
> device is UP.

OK. Thanks for your explanation!

> I removed the NETDEV_UP handling because I don't think it makes sense
> to implicitly try to establish layer2 (LAPB) if there is no carrier.

As I understand, when the device goes up, the carrier can be either
down or up. Right?

If this is true, when a device goes up and the carrier then goes up
after that, L2 will automatically connect, but if a device goes up and
the carrier is already up, L2 will not automatically connect. I think
it might be better to eliminate this difference in handling. It might
be better to make it automatically connect in both situations, or in
neither situations.

If you want to go with the second way (auto connect in neither
situations), the next (3rd) patch of this series might be also not
needed.

I just want to make the behavior of LAPB more consistent. I think we
should either make LAPB auto-connect in all situations, or make LAPB
wait for L3's instruction to connect in all situations.

> And with the first X.25 connection request on that interface, it will
> be established anyway by x25_transmit_link().
>
> I've tested it here with an HDLC WAN Adapter and it works as expected.
>
> These are also the ideal conditions for the already mentioned "on
> demand" scenario. The only necessary change would be to call
> x25_terminate_link() on an interface after clearing the last X.25
> session.
>
> > On NETDEV_GOING_DOWN, we can also check the carrier status first and
> > if it is down, we don't need to call lapb_disconnect_request.
>
> This is not necessary because lapb_disconnect_request() checks the
> current state. And if the carrier is DOWN then the state should also be
> LAPB_STATE_0 and so lapb_disconnect_request() does nothing.

Yes, I understand. I just thought adding this check might make the
code cleaner. But you are right.
