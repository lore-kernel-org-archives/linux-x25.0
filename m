From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB
 frames
Date: Fri, 29 Jan 2021 17:36:50 -0800
Message-ID: <20210129173650.7c0b7cda@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210127090747.364951-1-xie.he.0141@gmail.com>
        <20210128114659.2d81a85f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <CAJht_EOSB-m--Ombr6wLMFq4mPy8UTpsBri2CPsaRTU-aks7Uw@mail.gmail.com>
        <3f67b285671aaa4b7903733455a730e1@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611970611;
        bh=kJ14/IhYXRvZTWrg7H8aHCDirFH2aGuRYF/UVQtqtJU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lEWGaplwXv2Hvceix/Ei/PwlKAZd1hHbQZLkTQ5RnPq8+8qhfogrLOfHb1BG4PKSn
         G9oUIbnDGYIT9OIE2YLkngQ6GXeltsGDNZt6DzC2G9ylVFczpmgPhsWMK4R34OXbkI
         mhMlD6FIEw/wRDrMSDcVclesqOSRTAte5n2l/SaIqe7NdT6xtR4qelLYI3eSdYXLTT
         uLzKXc7cYtOGtwCAUkv9nrYbLiPY53laSp7Ih7LzEHW3j4nWxagHVG6GGofWpw8mIx
         6kSKy+PCKZtAcoCyUmCQQlURWyATER0SdxuOanNP+e85BimKCN7nSvFIBpmvtJ8ReF
         LoWst6uEmS1cA==
In-Reply-To: <3f67b285671aaa4b7903733455a730e1@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: Xie He <xie.he.0141@gmail.com>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Fri, 29 Jan 2021 06:56:10 +0100 Martin Schiller wrote:
> On 2021-01-28 23:06, Xie He wrote:
> > On Thu, Jan 28, 2021 at 11:47 AM Jakub Kicinski <kuba@kernel.org> 
> > wrote:  
> >> 
> >> Noob question - could you point at or provide a quick guide to 
> >> layering
> >> here? I take there is only one netdev, and something maintains an
> >> internal queue which is not stopped when HW driver stops the qdisc?  
> > 
> > Yes, there is only one netdev. The LAPB module (net/lapb/) (which is
> > used as a library by the netdev driver - hdlc_x25.c) is maintaining an
> > internal queue which is not stopped when the HW driver stops the
> > qdisc.
> > 
> > The queue is "write_queue" in "struct lapb_cb" in
> > "include/net/lapb.h". The code that takes skbs out of the queue and
> > feeds them to lower layers for transmission is at the "lapb_kick"
> > function in "net/lapb/lapb_out.c".
> > 
> > The layering is like this:
> > 
> > Upper layer (Layer 3) (net/x25/ or net/packet/)
> > 
> > ^
> > | L3 packets (with control info)
> > v
> > 
> > The netdev driver (hdlc_x25.c)
> > 
> > ^
> > | L3 packets
> > v
> > 
> > The LAPB Module (net/lapb/)
> > 
> > ^
> > | LAPB (L2) frames
> > v
> > 
> > The netdev driver (hdlc_x25.c)
> > 
> > ^
> > | LAPB (L2) frames
> > | (also called HDLC frames in the context of the HDLC subsystem)
> > v
> > 
> > HDLC core (hdlc.c)
> > 
> > ^
> > | HDLC frames
> > v
> > 
> > HDLC Hardware Driver  
> 
> @Xie: Thank you for the detailed presentation.

Indeed, thanks for the diagram.

I'm still struggling to wrap my head around this.

Did you test your code with lockdep enabled? Which Qdisc are you using?
You're queuing the frames back to the interface they came from - won't
that cause locking issues?
