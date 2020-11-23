From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Mon, 23 Nov 2020 02:08:03 -0800
Message-ID: <CAJht_EO+enBOFMkVVB5y6aRnyMEsOZtUBJcAvOFBS91y7CauyQ@mail.gmail.com>
References: <20201120054036.15199-1-ms@dev.tdt.de> <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
 <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
 <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de> <CAJht_EPc8MF1TjznSjWTPyMbsrw3JVqxST5g=eF0yf_zasUdeA@mail.gmail.com>
 <d85a4543eae46bac1de28ec17a2389dd@dev.tdt.de> <CAJht_EMjO_Tkm93QmAeK_2jg2KbLdv2744kCSHiZLy48aXiHnw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pq+GpfO2gw/px08Gc8Ao87p67ooWQK82Ig1Fe5tdBxQ=;
        b=mHnsPITnNU+s25kR1sMD6EGzHhppd68DOyo0El7jQGNzKNfOILf7LxeWw3vN2AuRCg
         cVIi0E8kKAWV3jvH5UC2C2KfkfAoAsCa6hOBrUyBmspU9Kzx0iWAgLPPseWDsaxMezQe
         06nYSprynZb+9kb90ljsXaq1IAdETsok4Cb4eq+6vrs/6mjhRH1hf45PKAuCsvWICMUq
         2dPPoji5Hx5td+6CrMuojI10lL53dU0fRmnAgi3krYky8E/VVLDHWj5yktF/LPS2VgTx
         j6z2m84lTOyDeoK3JIZMsGqeSnzlXB0D6cXuKBWH+PWoKlNqoQqRjAStqUTMIOt89WBV
         1OGQ==
In-Reply-To: <CAJht_EMjO_Tkm93QmAeK_2jg2KbLdv2744kCSHiZLy48aXiHnw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 23, 2020 at 1:36 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> Some drivers don't support carrier status and will never change it.
> Their carrier status will always be UP. There will not be a
> NETDEV_CHANGE event.
>
> lapbether doesn't change carrier status. I also have my own virtual
> HDLC WAN driver (for testing) which also doesn't change carrier
> status.
>
> I just tested with lapbether. When I bring up the interface, there
> will only be NETDEV_PRE_UP and then NETDEV_UP. There will not be
> NETDEV_CHANGE. The carrier status is alway UP.
>
> I haven't tested whether a device can receive NETDEV_CHANGE when it is
> down. It's possible for a device driver to call netif_carrier_on when
> the interface is down. Do you know what will happen if a device driver
> calls netif_carrier_on when the interface is down?

I just did a test on lapbether and saw there would be no NETDEV_CHANGE
event when the netif is down, even if netif_carrier_on/off is called.
So we can rest assured of this part.
