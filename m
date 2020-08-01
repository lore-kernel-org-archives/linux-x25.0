From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Fri, 31 Jul 2020 22:33:07 -0400
Message-ID: <CA+FuTSeusqdfkqZihFhTE9vhcL5or6DEh8UffaKM2Px82z6BZQ@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_ENjHRExBEHx--xmqnOy1MXY_6F5XZ_exinSfa6xU_XDJg@mail.gmail.com>
 <CA+FuTSf_nuiah6rFy-KC1Taw+Wc4z0G7LzkAm-+Ms4FzYmTPEw@mail.gmail.com> <CAJht_ENYxy4pseOO9gY=0R0bvPPvs4GKrGJOUMx6=LPwBa2+Bg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wo/sjI8j94LhAs4vx5XNhrSguJuseQ++7dWpkZeVEI8=;
        b=AS8Q6OA7/AOd3V3yXn/q9HLFUPzItzWKEQnBI8ytvd5Pi8YsJJpT6SdRLf3nG3+iao
         FkY7F6PVWVp+uGlm8ylb9oH4UGQcZ4b6kZjiZQkSnA3AdwSzhpkSs4o16a3Gjn8MZxbY
         iQFRtMk75j0esZK824Ca6oDhV9p37Jl7sGe0W7Q6tze/dzB2yJ0u3TY3apwOXh37sT58
         jDgfp69t/AgsPYYTVe7wGQK37nPkbPmOhFonejcMVmQjnBS0JM3WGQ+jn71L8vKvAWw/
         rdj5EqyuGIQdFMsNKFNzoqFhFONkEyXSHEpE2IZfLbMUSAdDhaRJ5BVn9nxxooahT4HO
         Y40g==
In-Reply-To: <CAJht_ENYxy4pseOO9gY=0R0bvPPvs4GKrGJOUMx6=LPwBa2+Bg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Brian Norris <briannorris@chromium.org>

On Fri, Jul 31, 2020 at 4:41 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> Thank you for your thorough review comment!
>
> On Fri, Jul 31, 2020 at 7:13 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Thanks for fixing a kernel panic. The existing line was added recently
> > in commit 9dc829a135fb ("drivers/net/wan/lapbether: Fixed the value of
> > hard_header_len"). I assume a kernel with that commit reverted also
> > panics? It does looks like it would.
>
> Yes, that commit also fixed kernel panic. But that patch only fixed
> kernel panic when using AF_PACKET/DGRAM sockets. It didn't fix kernel
> panic when using AF_PACKET/RAW sockets. This patch attempts to fix
> kernel panic when using AF_PACKET/RAW sockets, too.

Ah, okay. That's good to know.

While this protocol is old and seemingly unmaintained, it probably is
still in use. But the packet interface is not the common datapath. We
have to be careful not to introduce regressions to that.

> > If this driver submits a modified packet to an underlying eth device,
> > it is akin to tunnel drivers. The hard_header_len vs needed_headroom
> > discussion also came up there recently [1]. That discussion points to
> > commit c95b819ad75b ("gre: Use needed_headroom"). So the general
> > approach in this patch is fine. Do note the point about mtu
> > calculations -- but this device just hardcodes a 1000 byte dev->mtu
> > irrespective of underlying ethernet device mtu, so I guess it has
> > bigger issues on that point.
>
> Yes, I didn't consider the issue of mtu calculation. Maybe we need to
> calculate the mtu of this device based on the underlying Ethernet
> device, too.
>
> We may also need to handle the situation where the mtu of the
> underlying Ethernet device changes.
>
> I'm not sure if the mtu of the device can be changed by the user
> without explicit support from the driver. If it can, we may also need
> to set max_mtu and min_mtu properly to prevent the user from setting
> it to invalid values.

I suggest to ignore mtu. It is out of scope of this patch, which does
address an unrelated real kernel panic.

> > But, packet sockets with SOCK_RAW have to pass a fully formed packet
> > with all the headers the ndo_start_xmit expects, i.e., it should be
> > safe for the device to just pull that many bytes. X25 requires the
> > peculiar one byte pseudo header you mention: lapbeth_xmit
> > unconditionally reads skb->data[0] and then calls skb_pull(skb, 1).
> > This could be considered the device hard header len.
>
> Yes, I agree that we can use hard_header_len (and min_header_len) to
> prevent packets shorter than 1 byte from passing.
>
> But because af_packet.c reserves a header space of needed_headroom for
> RAW sockets, but hard_header_len + needed_headroom for DGRAM sockets,
> it appears to me that af_packet.c expects hard_header_len to be the
> header length created by dev_hard_header. We can, however, set
> hard_header_len to 1 and let dev_hard_header generate a 0-sized
> header, but this makes af_packet.c to reserve an extra unused 1-byte
> header space for DGRAM sockets, and DGRAM sockets will not be
> protected by the 1-byte minimum length check like RAW sockets.

Good point.

> The best solution might be to implement header_ops for X.25 drivers
> and let dev_hard_header create this 1-byte header, so that
> hard_header_len can equal to the header length created by
> dev_hard_header. This might be the best way to fit the logic of
> af_packet.c. But this requires changing the interface of X.25 drivers
> so it might be a big change.

Agreed.

I quickly scanned the main x.25 datapath code. Specifically
x25_establish_link, x25_terminate_link and x25_send_frame. These all
write this 1 byte header. It appears to be an in-band communication
means between the network and data link layer, never actually ending
up on the wire?

Either lapbeth_xmit has to have a guard against 0 byte packets before
reading skb->data[0], or packet sockets should not be able to generate
those (is this actually possible today through PF_PACKET? not sure)

If SOCK_DGRAM has to always select one of the three values (0x00:
data, 0x01: establish, 0x02: terminate) the first seems most sensible.
Though if there is no way to establish a connection with
PF_PACKET/SOCK_DGRAM, that whole interface may still be academic.
Maybe eventually either 0x00 or 0x01 could be selected based on
lapb->state.. That however is out of scope of this fix.

Normally a fix should aim to have a Fixes: tag, but all this code
precedes git history, so that is not feasible here.
