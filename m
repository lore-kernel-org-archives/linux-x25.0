From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB frames
Date: Mon, 1 Feb 2021 06:02:44 -0800
Message-ID: <CAJht_EOs1HOcRRpVo_RZEQPECVPrKpu5vk0Pe-XmRe4htmEuOw@mail.gmail.com>
References: <20210127090747.364951-1-xie.he.0141@gmail.com>
 <20210128114659.2d81a85f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EOSB-m--Ombr6wLMFq4mPy8UTpsBri2CPsaRTU-aks7Uw@mail.gmail.com>
 <3f67b285671aaa4b7903733455a730e1@dev.tdt.de> <20210129173650.7c0b7cda@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EPMtn5E-Y312vPQfH2AwDAi+j1OP4zzpg+AUKf46XE1Yw@mail.gmail.com>
 <20210130111618.335b6945@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EMQVaKFx7Wjj75F2xVBTCdpmho64wP0bfX6RhFnzNXAZA@mail.gmail.com>
 <36a6c0769c57cd6835d32cc0fb95bca6@dev.tdt.de> <CAJht_ENs1Rnf=2iX8M1ufF=StWHKTei3zuKv-xBtkhDsY-xBOA@mail.gmail.com>
 <1628f9442ccf18f9c08c98f122053fc0@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uBdiP9H9SlNL4alzj1It88DmnB+e5Qmtpx4oL95Is3k=;
        b=SXoeBbQT5lJYINofg0/xkVOTIolowtnIDEP9fr2GtQ9A5duj3KLOXGPVbMddAjVfmH
         5ZmlZC48QLqZXb9NQ6SKrrvtRr41J+2L0X1BYERIQ0hM9h7J+VoYH+W04wq9wJlfxRxm
         T8MEeQP3KfzTdTgEBuwFrCdGVZHVTDVbdaFiiSzCQpfjN7pmFXFlHm3s4MVqiSm8Q1QP
         jCPt9JZNwH4Dx73Teh0uihHD+LhCQfVA2HkwWH9y5y4+ewkX/J1tAsMNugSHOaaTfGyP
         1gzTmkLRiK2YlmCvCOZD5vLvdhrt/iJNImrdLu3XJ9//FyGNrVEizVJOfx04oYH9T0l5
         iOhQ==
In-Reply-To: <1628f9442ccf18f9c08c98f122053fc0@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Mon, Feb 1, 2021 at 5:14 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> But control frames are currently sent past the lapb write_queue.
> So another queue would have to be created.
>
> And wouldn't it be better to have it in the hdlc_x25 driver, leaving
> LAPB unaffected?

Hmm.. Indeed. I agree.

I also think the queue needs to be the qdisc queue, so that it'll be
able to respond immediately to hardware drivers' netif_wake_queue
call.

Initially I was considering using the qdisc of the HDLC device to
queue the outgoing L2 frames again (after their corresponding L3
packets having already gone through the queue). But Jakub didn't like
the idea of queuing the same data twice. I also found that if an L3
packet was sent through the qdisc without being queued, and LAPB
didn't queue it either, then the emitted L2 frame must be queued in
the qdisc. This is both not optimal and causing problems when using
the "noqueue" qdisc.

Maybe the only way is to create a virtual device on top of the HDLC
device, using the virtual device to queue L3 packets and using the
actual HDLC device to queue L2 frames.
