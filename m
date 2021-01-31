From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB frames
Date: Sat, 30 Jan 2021 19:16:00 -0800
Message-ID: <CAJht_EMQVaKFx7Wjj75F2xVBTCdpmho64wP0bfX6RhFnzNXAZA@mail.gmail.com>
References: <20210127090747.364951-1-xie.he.0141@gmail.com>
 <20210128114659.2d81a85f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EOSB-m--Ombr6wLMFq4mPy8UTpsBri2CPsaRTU-aks7Uw@mail.gmail.com>
 <3f67b285671aaa4b7903733455a730e1@dev.tdt.de> <20210129173650.7c0b7cda@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EPMtn5E-Y312vPQfH2AwDAi+j1OP4zzpg+AUKf46XE1Yw@mail.gmail.com> <20210130111618.335b6945@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ohey/n9HC50LcT9SfB1APHEExDxmpN/T94GswSnA44U=;
        b=NQTJszeGFJ+SLfhMg24MZxPuqDcRn8iY0x6u0pvyOTcY7L3qThofp937GjRnHBtwyd
         GT9s01S9jxE4Wf2eQYuO6Kc29cIwkcnuDIcBQZE00zAquyuylJBYNWBIjYd8nOUmCc9n
         JvjTqHtDKkeDNQZIQveJycwgupWWZ3vId/nSy/Z+uXlsv7Gn40wdLIdlkpQy9W6TuQfW
         V2ckBfRWm9AdsPj+rQ8HU8qIfrgS80SeHd113c8Mgsci8mZOuCiaVOaJx1oLOoU8RwWS
         N5lLQHZvGkURl0la4UnDmwI+PVUa/NGM6JcOzWq4PMGzulwYOCjAQyOz1tyUteIN18id
         HCog==
In-Reply-To: <20210130111618.335b6945@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Sat, Jan 30, 2021 at 11:16 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Sounds like too much afford for a sub-optimal workaround.
> The qdisc semantics are borken in the proposed scheme (double
> counting packets) - both in term of statistics and if user decides
> to add a policer, filter etc.

Hmm...

Another solution might be creating another virtual device on top of
the HDLC device (similar to what "hdlc_fr.c" does), so that we can
first queue L3 packets in the virtual device's qdisc queue, and then
queue the L2 frames in the actual HDLC device's qdisc queue. This way
we can avoid the same outgoing data being queued to qdisc twice. But
this would significantly change the way the user uses the hdlc_x25
driver.

> Another worry is that something may just inject a packet with
> skb->protocol == ETH_P_HDLC but unexpected structure (IDK if
> that's a real concern).

This might not be a problem. Ethernet devices also allow the user to
inject raw frames with user constructed headers. "hdlc_fr.c" also
allows the user to bypass the virtual circuit interfaces and inject
raw frames directly on the HDLC interface. I think the receiving side
should be able to recognize and drop invalid frames.

> It may be better to teach LAPB to stop / start the internal queue.
> The lower level drivers just needs to call LAPB instead of making
> the start/wake calls directly to the stack, and LAPB can call the
> stack. Would that not work?

I think this is a good solution. But this requires changing a lot of
code. The HDLC subsystem needs to be changed to allow HDLC Hardware
Drivers to ask HDLC Protocol Drivers (like hdlc_x25.c) to stop/wake
the TX queue. The hdlc_x25.c driver can then ask the LAPB module to
stop/wake the queue.

So this means new APIs need to be added to both the HDLC subsystem and
the LAPB module, and a number of HDLC Hardware Drivers need to be
changed to call the new API of the HDLC subsystem.

Martin, do you have any suggestions?
