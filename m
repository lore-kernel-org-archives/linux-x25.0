From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Mon, 1 Feb 2021 02:49:09 -0800
Message-ID: <CAJht_EPGk871aqK-1+=W7vGZrX8QY8LDVF26jkFjm3veeQmPWw@mail.gmail.com>
References: <20210201055706.415842-1-xie.he.0141@gmail.com> <204c18e95caf2ae84fb567dd4be0c3ac@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3ahVfaMAWzVEmDVakumdMajUgJJioFFzCyRQz4vDITs=;
        b=Rmoj8mVpr1W7qSeYZBZ0qhcys4NlgEkxlzHARgrrzK0bU0xgpWaD8jygwlPmiWCDyU
         NVQqBQNNEJ3++zbaToXcHRYb5fYuyAOUCWC+DDS8cYrEVCjpnU+c8qESkyg/cL3oJVvZ
         E3tQcp0e1yg+yhxAvo+F55prKc+eX2OSK7UCv25a/W1BYXjpc/YJDeAb57L9CbfqLcYR
         apmT+tduUXgHmP2IZ5HMh0gcqpjK+kjO0vbWopdcT0KgGWQCddBniXrT6JgGVMI+14DW
         bH9CQjn6JRX1zArG1tKsQd9kZWycm4Pac3mjCAc1+Nj3ce4WDjzqo3V7jbxqQE7be+E/
         CLjw==
In-Reply-To: <204c18e95caf2ae84fb567dd4be0c3ac@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Feb 1, 2021 at 2:05 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> What kind of packages do you mean are corrupted?
> ETH_P_X25 or ETH_P_HDLC?

I mean ETH_P_X25. I was using "lapbether.c" to test so there was no ETH_P_HDLC.

> I have also sent a patch here in the past that addressed corrupted
> ETH_P_X25 frames on an AF_PACKET socket:
>
> https://lkml.org/lkml/2020/1/13/388
>
> Unfortunately I could not track and describe exactly where the problem
> was.

Ah... Looks like we had the same problem.

> I just wonder when/where is the logically correct place to copy the skb.
> Shouldn't it be copied before removing the pseudo header (as I did in my
> patch)?

I think it's not necessary to copy it before removing the pseudo
header, because "skb_pull" will not change any data in the data
buffer. "skb_pull" will only change the values of "skb->data" and
"skb->len". These values are not shared between clones of skbs, so
it's safe to change them without affecting other clones of the skb.

I also choose to copy the skb in the LAPB module (rather than in the
drivers) because I see all drivers have this problem (including the
recently deleted x25_asy.c driver), so it'd be better to fix this
issue in the LAPB module, for all drivers.
