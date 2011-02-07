From: Andrew Hendry <andrew.hendry@gmail.com>
Subject: Re: x25: possible skb leak on bad facilities
Date: Mon, 7 Feb 2011 17:29:43 +1100
Message-ID: <AANLkTik8hg5G2FYDCoRgh72v-_euGWKix9Fxm89UdXie@mail.gmail.com>
References: <20110131130826.GC16804@shadowen.org>
	<AANLkTik-ywwtNg2AxAXtsKYJviDp=1zCZ-43JXp9i3g6@mail.gmail.com>
	<20110206.202824.260090071.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=okMjYgayavDiisiJ4wovLZcrfxe1y6G4oXtplVd1LR4=;
        b=e2t8Ojg62Tmk9i+orRF/g42PMRZDEVXave+z2iEo6ywIuhwmeX2BR/RxZMjSn0oX2w
         sVnKRJmb4gqOW0I2TILCH3Z7SjLGDIyqW2gsvga9JsAGFRv50SFx2Z763PcPTZy+eqCI
         ChXCgL4y+Wh9Las4nX1jYFMHRxzKGOKwF06eQ=
In-Reply-To: <20110206.202824.260090071.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: apw@canonical.com, john@calva.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tim.gardner@canonical.com

The issue is a bit more complex than Andy's patch, I think I have a full fix.
Burning it in on test system now, if thats OK ill post patch in a few hours.


On Mon, Feb 7, 2011 at 3:28 PM, David Miller <davem@davemloft.net> wrote:
> From: Andrew Hendry <andrew.hendry@gmail.com>
> Date: Tue, 1 Feb 2011 22:55:13 +1100
>
>> There are two callers, when I was crashing it I don't remember it
>> using the backlog path.
>> x25_process_rx_frame is called from both x25_backlog_rcv and also
>> x25_receive_data (via x25_lapb_receive_frame)
>>
>> But reviewing that second path now it looks like it will also leak, -1
>> would make it skip the kfree_skb there as well.
>> So patch looks good to me, when I have some time I'll run it through
>> the environment I had setup originally to confirm.
>
> Andrew, have you had a chance to do this yet?
>
