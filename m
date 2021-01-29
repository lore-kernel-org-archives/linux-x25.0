From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB
 frames
Date: Fri, 29 Jan 2021 06:56:10 +0100
Message-ID: <3f67b285671aaa4b7903733455a730e1@dev.tdt.de>
References: <20210127090747.364951-1-xie.he.0141@gmail.com>
 <20210128114659.2d81a85f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EOSB-m--Ombr6wLMFq4mPy8UTpsBri2CPsaRTU-aks7Uw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJht_EOSB-m--Ombr6wLMFq4mPy8UTpsBri2CPsaRTU-aks7Uw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>

On 2021-01-28 23:06, Xie He wrote:
> On Thu, Jan 28, 2021 at 11:47 AM Jakub Kicinski <kuba@kernel.org> 
> wrote:
>> 
>> Noob question - could you point at or provide a quick guide to 
>> layering
>> here? I take there is only one netdev, and something maintains an
>> internal queue which is not stopped when HW driver stops the qdisc?
> 
> Yes, there is only one netdev. The LAPB module (net/lapb/) (which is
> used as a library by the netdev driver - hdlc_x25.c) is maintaining an
> internal queue which is not stopped when the HW driver stops the
> qdisc.
> 
> The queue is "write_queue" in "struct lapb_cb" in
> "include/net/lapb.h". The code that takes skbs out of the queue and
> feeds them to lower layers for transmission is at the "lapb_kick"
> function in "net/lapb/lapb_out.c".
> 
> The layering is like this:
> 
> Upper layer (Layer 3) (net/x25/ or net/packet/)
> 
> ^
> | L3 packets (with control info)
> v
> 
> The netdev driver (hdlc_x25.c)
> 
> ^
> | L3 packets
> v
> 
> The LAPB Module (net/lapb/)
> 
> ^
> | LAPB (L2) frames
> v
> 
> The netdev driver (hdlc_x25.c)
> 
> ^
> | LAPB (L2) frames
> | (also called HDLC frames in the context of the HDLC subsystem)
> v
> 
> HDLC core (hdlc.c)
> 
> ^
> | HDLC frames
> v
> 
> HDLC Hardware Driver

@Xie: Thank you for the detailed presentation.

> 
>> Sounds like we're optimizing to prevent drops, and this was not
>> reported from production, rather thru code inspection. Ergo I think
>> net-next will be more appropriate here, unless Martin disagrees.
> 
> Yes, I have no problem in targeting net-next instead. Thanks!

I agree.
