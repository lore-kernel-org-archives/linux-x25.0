From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a
 skb->len check
Date: Mon, 10 Aug 2020 12:50:29 -0700
Message-ID: <CAJht_EORX2intix=HxS+U+O1hiuSb25=GWi5ONHtFdEF_BS_Ng@mail.gmail.com>
References: <20200809023548.684217-1-xie.he.0141@gmail.com>
 <CA+FuTSe-FaQFn4WNvVPJ1v+jVZAghgd1AZc-cWn2+GjPR4GzVQ@mail.gmail.com>
 <CAJht_EOao3-kA-W-SdJqKRiFMAFUxw7OARFGY5DL8pXvKd4TLw@mail.gmail.com> <CA+FuTSc7c+XTDU10Bh1ZviQomHgiTjiUvOO0iR1X95rq61Snrg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nak496W6Uz7095G3/h9V9Rt6HXnjw+oQmD5Xl3Awnvs=;
        b=AM3To5k5Za9uQQSjvLX3R3ekehxvw7Er/kX/CgCwd94GuMmqIM+9euuFFp+6dVhYDW
         trfMUqOiuualq6aaKk2WNfVhJ4/V0yc/16yH0+ZbMX/5sBRp2g42TFtKWBjGS7Ij8xHe
         nTQVmSgvpm7lAxSC9Tt8PKoV1GK9UdC2OZNYQgRQfuXpdZJr2SNouHUdzy04/m2kThL2
         CcmZcUtJ8qaum4rvIxv5x23995qRyH9LMLWEDdLdsrHsFfYww749X6tNSwnkO1RsOjOH
         ccQdpfUJjTrgHjwWUPqBs5ver+3v8rTJt5jDX0Id5uOOFaoNHFP4dev6XhX2RMvbmuoU
         YoVg==
In-Reply-To: <CA+FuTSc7c+XTDU10Bh1ZviQomHgiTjiUvOO0iR1X95rq61Snrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Mon, Aug 10, 2020 at 12:21 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Acked-by: Willem de Bruijn <willemb@google.com>

Thank you so much!

> > 1) I hope to set needed_headroom properly for all three X.25 drivers
> > (lapbether, x25_asy, hdlc_x25) in the kernel. So that the upper layer
> > (net/x25) can be changed to use needed_headroom to allocate skb,
> > instead of the current way of using a constant to estimate the needed
> > headroom.
>
> Which constant, X25_MAX_L2_LEN?

Yes, by grepping X25_MAX_L2_LEN in net/x25, I can see it is used in
various places to allocate and reserve the needed header space. For
example in net/x25/af_x25.c, the function x25_sendmsg allocates and
reserves a header space of X25_MAX_L2_LEN + X25_EXT_MIN_LEN.

> > 2) The code quality of this driver is actually very low, and I also
> > hope to improve it gradually. Actually this driver had been completely
> > broken for many years and no one had noticed this until I fixed it in
> > commit 8fdcabeac398 (drivers/net/wan/x25_asy: Fix to make it work)
> > last month.
>
> Just curious: how come that netif_rx could be removed?

When receiving data, the driver should only submit skb to upper layers
after it has been processed by the lapb module, i.e., it should only
call netif_rx in the function x25_asy_data_indication. The removed
netif_rx is in the function x25_asy_bump. This function is responsible
for passing the skb to the lapb module to process. It doesn't make
sense to call netif_rx here. If we call netif_rx here, we may pass
control frames that shouldn't be passed to upper layers (and have been
consumed and freed by the lapb module) to upper layers.

> One thing to keep in mind is that AF_PACKET sockets are not the normal
> datapath. AF_X25 sockets are. But you mention that you also exercise
> the upper layer? That gives confidence that these changes are not
> accidentally introducing regressions for the default path while fixing
> oddly crafted packets with (root only for a reason) packet sockets.

Yes, I test with AF_X25 sockets too to make sure the changes are OK.
I usually test AF_X25 sockets with:
https://github.com/hyanggi/testing_linux/blob/master/network_x25/x25/server.c
https://github.com/hyanggi/testing_linux/blob/master/network_x25/x25/client.c

I became interested in X.25 when I was trying different address
families that Linux supported. I tried AF_X25 sockets. And then I
tried to use the X.25 link layer directly through AF_PACKET. I believe
both AF_X25 sockets and AF_PACKET sockets need to work without
problems with X.25 drivers - lapbether and x25_asy. There is another
X.25 driver (hdlc_x25) in the kernel. I haven't been able to run that
driver. But that driver seems to be the real driver which is really
used, and I know Martin Schiller <ms@dev.tdt.de> is an active user and
developer of that driver.
