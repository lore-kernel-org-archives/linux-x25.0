From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a
 skb->len check
Date: Tue, 11 Aug 2020 12:50:01 +0200
Message-ID: <CA+FuTSfS1XX9ag6npPM95Tiu_hhuan+Foxe1B+_66M-cf+26UA@mail.gmail.com>
References: <20200809023548.684217-1-xie.he.0141@gmail.com>
 <CA+FuTSe-FaQFn4WNvVPJ1v+jVZAghgd1AZc-cWn2+GjPR4GzVQ@mail.gmail.com>
 <CAJht_EOao3-kA-W-SdJqKRiFMAFUxw7OARFGY5DL8pXvKd4TLw@mail.gmail.com>
 <CA+FuTSc7c+XTDU10Bh1ZviQomHgiTjiUvOO0iR1X95rq61Snrg@mail.gmail.com> <CAJht_EORX2intix=HxS+U+O1hiuSb25=GWi5ONHtFdEF_BS_Ng@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k2vKN6djCQsHiDDNdDQAZoPqXDVr1uTSX4rbhVukZV4=;
        b=StcvkEIk5iKzN5OGYcbplBV0OzvB0ZMp2ibijJdGRrErwoJvbHYeK1pKp/UpMPjzIr
         flsBwhMlc++z3LCK/yeVKDvDpro44dHfnkl2omnbhxAgoDG+P6IGd26n9CVSxcE9lfI3
         Dj3jE/cgQiQ8MsNtIQrlN/AYRSXLfZ9JsfZArNvSkObhtKbH7z+0RTuiJ3U8vZwj8DFL
         /0AGq3IaH/elcmhTxdiz5s46xDEiOiXeqFSpTvt6ltk37JWbFGjBQJIfCnOFipDyYzcu
         Tii8pcKUivwccp9vT96k74ltNumDEYTP6Ci0sLhtPwFwygkUYmWu1X7fGmrFHkCpWlmV
         fkjA==
In-Reply-To: <CAJht_EORX2intix=HxS+U+O1hiuSb25=GWi5ONHtFdEF_BS_Ng@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, andrew.hendry@gmail.com

> > > 2) The code quality of this driver is actually very low, and I also
> > > hope to improve it gradually. Actually this driver had been completely
> > > broken for many years and no one had noticed this until I fixed it in
> > > commit 8fdcabeac398 (drivers/net/wan/x25_asy: Fix to make it work)
> > > last month.
> >
> > Just curious: how come that netif_rx could be removed?
>
> When receiving data, the driver should only submit skb to upper layers
> after it has been processed by the lapb module, i.e., it should only
> call netif_rx in the function x25_asy_data_indication. The removed
> netif_rx is in the function x25_asy_bump. This function is responsible
> for passing the skb to the lapb module to process. It doesn't make
> sense to call netif_rx here. If we call netif_rx here, we may pass
> control frames that shouldn't be passed to upper layers (and have been
> consumed and freed by the lapb module) to upper layers.

Ah of course. Thanks for explaining.

> > One thing to keep in mind is that AF_PACKET sockets are not the normal
> > datapath. AF_X25 sockets are. But you mention that you also exercise
> > the upper layer? That gives confidence that these changes are not
> > accidentally introducing regressions for the default path while fixing
> > oddly crafted packets with (root only for a reason) packet sockets.
>
> Yes, I test with AF_X25 sockets too to make sure the changes are OK.
> I usually test AF_X25 sockets with:
> https://github.com/hyanggi/testing_linux/blob/master/network_x25/x25/server.c
> https://github.com/hyanggi/testing_linux/blob/master/network_x25/x25/client.c

Excellent. Thanks for the link. Good to know that these changes are
getting real code coverage.

> I became interested in X.25 when I was trying different address
> families that Linux supported. I tried AF_X25 sockets. And then I
> tried to use the X.25 link layer directly through AF_PACKET. I believe
> both AF_X25 sockets and AF_PACKET sockets need to work without
> problems with X.25 drivers - lapbether and x25_asy. There is another
> X.25 driver (hdlc_x25) in the kernel. I haven't been able to run that
> driver. But that driver seems to be the real driver which is really
> used, and I know Martin Schiller <ms@dev.tdt.de> is an active user and
> developer of that driver.

Great, sounds like we might have additional LAPB and X25 maintainers soon? :)

MAINTAINERS lists Andrew Hendry as maintainer for X.25. Please do CC them.
