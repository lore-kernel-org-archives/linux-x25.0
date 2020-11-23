From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Mon, 23 Nov 2020 01:36:45 -0800
Message-ID: <CAJht_EMjO_Tkm93QmAeK_2jg2KbLdv2744kCSHiZLy48aXiHnw@mail.gmail.com>
References: <20201120054036.15199-1-ms@dev.tdt.de> <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
 <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
 <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de> <CAJht_EPc8MF1TjznSjWTPyMbsrw3JVqxST5g=eF0yf_zasUdeA@mail.gmail.com>
 <d85a4543eae46bac1de28ec17a2389dd@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LoHYGvz7BTMS2beu4vcf2km2aXO54uIdqhk7iR0tRXo=;
        b=gjKK+jfD3wcBFkFwYwGRGqY2VZyOTNowyhcwkXXJVW+/62mwFrHik+SbBG3lqiQm2h
         nTwwxoOG+i61bAwRePrnuYSO+x30xWNAdkoTX8gvm/byF56yoyHaKJJ6LiRN+Nr6a9jn
         8D8WsAfAPl97V9WhsxwPqL/VvYF4sE9noj2fPqngcfHh0hFueP7KPe0cNsBgmci2TDTV
         HFSEV0d3EoMQ79G6XeUbYxEmYvNRxetdoQTHTY3j4T6YPelQGEXB+xvw+74SvxIbj3Yr
         otwIUXJxxqQKcnhSYZt3l0h8zp/fe2LEZy1DZtpRRKojZSh1wZF8yuzI85v54vMZh6SR
         vVCA==
In-Reply-To: <d85a4543eae46bac1de28ec17a2389dd@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 23, 2020 at 1:00 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> AFAIK the carrier can't be up before the device is up. Therefore, there
> will be a NETDEV_CHANGE event after the NETDEV_UP event.
>
> This is what I can see in my tests (with the HDLC interface).
>
> Is the behaviour different for e.g. lapbether?

Some drivers don't support carrier status and will never change it.
Their carrier status will always be UP. There will not be a
NETDEV_CHANGE event.

lapbether doesn't change carrier status. I also have my own virtual
HDLC WAN driver (for testing) which also doesn't change carrier
status.

I just tested with lapbether. When I bring up the interface, there
will only be NETDEV_PRE_UP and then NETDEV_UP. There will not be
NETDEV_CHANGE. The carrier status is alway UP.

I haven't tested whether a device can receive NETDEV_CHANGE when it is
down. It's possible for a device driver to call netif_carrier_on when
the interface is down. Do you know what will happen if a device driver
calls netif_carrier_on when the interface is down?
