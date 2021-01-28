From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB frames
Date: Thu, 28 Jan 2021 14:06:58 -0800
Message-ID: <CAJht_EOSB-m--Ombr6wLMFq4mPy8UTpsBri2CPsaRTU-aks7Uw@mail.gmail.com>
References: <20210127090747.364951-1-xie.he.0141@gmail.com> <20210128114659.2d81a85f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwbhYTYlKJc3qWdffrQGsNa7auYkd8037d2LbAoaq+4=;
        b=db/3JuT74AtHbaNhPY2iun2rxxrUDTOmNcTQ6ISyxUVI80SvBONASBZrgcArON/+Dx
         sODZKu+kRLiq/khuiNm/HKLWRc8fAiF/157bhEUHqqfIMbLB6o9auw/wjx9LXaEzSIx7
         9DrA63JAq/e1DFj/sZ0FShOYkVaNit+f/UhRoaxN+oxD6C0r47FXz1muA3xlsnMwoepc
         AnUTV7wnnkvlp/9vBmGtzZASlGWhSnDmKdtnthItkTQUIXi8Ym2415vaiWjFOb3m+764
         I5W3QDM2PF9Ta5jfeGPIyocwaLbaJ2E/XoXgGmDOdqy+zBiL4hyBLkSICq3bpvSXj9Fg
         OrVg==
In-Reply-To: <20210128114659.2d81a85f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>

On Thu, Jan 28, 2021 at 11:47 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Noob question - could you point at or provide a quick guide to layering
> here? I take there is only one netdev, and something maintains an
> internal queue which is not stopped when HW driver stops the qdisc?

Yes, there is only one netdev. The LAPB module (net/lapb/) (which is
used as a library by the netdev driver - hdlc_x25.c) is maintaining an
internal queue which is not stopped when the HW driver stops the
qdisc.

The queue is "write_queue" in "struct lapb_cb" in
"include/net/lapb.h". The code that takes skbs out of the queue and
feeds them to lower layers for transmission is at the "lapb_kick"
function in "net/lapb/lapb_out.c".

The layering is like this:

Upper layer (Layer 3) (net/x25/ or net/packet/)

^
| L3 packets (with control info)
v

The netdev driver (hdlc_x25.c)

^
| L3 packets
v

The LAPB Module (net/lapb/)

^
| LAPB (L2) frames
v

The netdev driver (hdlc_x25.c)

^
| LAPB (L2) frames
| (also called HDLC frames in the context of the HDLC subsystem)
v

HDLC core (hdlc.c)

^
| HDLC frames
v

HDLC Hardware Driver

> Sounds like we're optimizing to prevent drops, and this was not
> reported from production, rather thru code inspection. Ergo I think
> net-next will be more appropriate here, unless Martin disagrees.

Yes, I have no problem in targeting net-next instead. Thanks!
