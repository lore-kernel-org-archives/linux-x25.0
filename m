From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Fri, 31 Jul 2020 13:40:38 -0700
Message-ID: <CAJht_ENYxy4pseOO9gY=0R0bvPPvs4GKrGJOUMx6=LPwBa2+Bg@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_ENjHRExBEHx--xmqnOy1MXY_6F5XZ_exinSfa6xU_XDJg@mail.gmail.com>
 <CA+FuTSf_nuiah6rFy-KC1Taw+Wc4z0G7LzkAm-+Ms4FzYmTPEw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uD+/m62r6hde+eEk8FbuyWYY9SyQ1g17seylKKn4ScI=;
        b=iBgR0RQZdQSu15Ft8/oJQoP9cEOetjtrQ2DYEy8vrt9bg0N6ImHfJ5G4tzTnBSDwwV
         OqbD94zJDNtSkGg8VurDmpRZZflbt1A2soYYurx8/lEFyPjBoc19t6NAM1InEDvaCfDD
         i3lwVE9CtYG6PWVB9xufUB6hNFhaS5ynuHiAoQx0fqcmH/05Rx4zC5FaJrZ+SRAyTOj8
         DbP/KmFrtbH6DcbpN6XrBos5uG2gfwn+EMxweqKBhMbAafz9RCUPJTWZmtOvI75LuZQt
         IKGaO6XFxSLFTq7ti3cUC9nF+2YAvW90OxiYe5434JT0gd0Y1et0acwcpOJY4UpvNaLw
         heqQ==
In-Reply-To: <CA+FuTSf_nuiah6rFy-KC1Taw+Wc4z0G7LzkAm-+Ms4FzYmTPEw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Brian Norris <briannorris@chromium.org>

Thank you for your thorough review comment!

On Fri, Jul 31, 2020 at 7:13 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Thanks for fixing a kernel panic. The existing line was added recently
> in commit 9dc829a135fb ("drivers/net/wan/lapbether: Fixed the value of
> hard_header_len"). I assume a kernel with that commit reverted also
> panics? It does looks like it would.

Yes, that commit also fixed kernel panic. But that patch only fixed
kernel panic when using AF_PACKET/DGRAM sockets. It didn't fix kernel
panic when using AF_PACKET/RAW sockets. This patch attempts to fix
kernel panic when using AF_PACKET/RAW sockets, too.

> If this driver submits a modified packet to an underlying eth device,
> it is akin to tunnel drivers. The hard_header_len vs needed_headroom
> discussion also came up there recently [1]. That discussion points to
> commit c95b819ad75b ("gre: Use needed_headroom"). So the general
> approach in this patch is fine. Do note the point about mtu
> calculations -- but this device just hardcodes a 1000 byte dev->mtu
> irrespective of underlying ethernet device mtu, so I guess it has
> bigger issues on that point.

Yes, I didn't consider the issue of mtu calculation. Maybe we need to
calculate the mtu of this device based on the underlying Ethernet
device, too.

We may also need to handle the situation where the mtu of the
underlying Ethernet device changes.

I'm not sure if the mtu of the device can be changed by the user
without explicit support from the driver. If it can, we may also need
to set max_mtu and min_mtu properly to prevent the user from setting
it to invalid values.

> But, packet sockets with SOCK_RAW have to pass a fully formed packet
> with all the headers the ndo_start_xmit expects, i.e., it should be
> safe for the device to just pull that many bytes. X25 requires the
> peculiar one byte pseudo header you mention: lapbeth_xmit
> unconditionally reads skb->data[0] and then calls skb_pull(skb, 1).
> This could be considered the device hard header len.

Yes, I agree that we can use hard_header_len (and min_header_len) to
prevent packets shorter than 1 byte from passing.

But because af_packet.c reserves a header space of needed_headroom for
RAW sockets, but hard_header_len + needed_headroom for DGRAM sockets,
it appears to me that af_packet.c expects hard_header_len to be the
header length created by dev_hard_header. We can, however, set
hard_header_len to 1 and let dev_hard_header generate a 0-sized
header, but this makes af_packet.c to reserve an extra unused 1-byte
header space for DGRAM sockets, and DGRAM sockets will not be
protected by the 1-byte minimum length check like RAW sockets.

The best solution might be to implement header_ops for X.25 drivers
and let dev_hard_header create this 1-byte header, so that
hard_header_len can equal to the header length created by
dev_hard_header. This might be the best way to fit the logic of
af_packet.c. But this requires changing the interface of X.25 drivers
so it might be a big change.
