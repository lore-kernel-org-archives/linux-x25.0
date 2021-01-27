From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB frames
Date: Wed, 27 Jan 2021 12:29:32 -0800
Message-ID: <CAJht_ENmxCBk=h68CN55qySMAiYhcgS0AtVzo6RvS5xf_6EkRw@mail.gmail.com>
References: <20210127090747.364951-1-xie.he.0141@gmail.com> <77971dffcff441c3ad3d257825dc214b@AcuMS.aculab.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=35nce9wUdGps1xFNE+LJWAtds0eN6VprBugB5bMnyd4=;
        b=lc9qa04WTv0m3c/3XhNlf7uDFlWXVko6oHEt3W5ZOc7fHSaDKbtZ68UbdT4Tc/5/Oc
         yyk+MkwlyYN8ZFDLTWHgZcIQHop2n8EmepZG23sNKQrG+JYzWUm8728P25A1iZ/zcy+t
         vD4hxI/jiBWYfvMgGIXVJ9RPVrbaqUxOx16nXJqWyANmiJeyvvQZPGhkO4vkKQz6wMRV
         heAbzQs9/EnqBMQ6vC1aBk2gjPS0tTyKWPMmF30xznDpB7PnrtydWfmjINUnTUXT9W3x
         9L5VO6zli5WtQIeLuAtl3pkGTlE1pik/uKVxFFcij2Qpyeagse7GDi5OgHuHR6L6Ey51
         bfBg==
In-Reply-To: <77971dffcff441c3ad3d257825dc214b@AcuMS.aculab.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Laight <David.Laight@aculab.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>

On Wed, Jan 27, 2021 at 2:14 AM David Laight <David.Laight@aculab.com> wrote:
>
> If I read this correctly it adds a (potentially big) queue between the
> LAPB code that adds the sequence numbers to the frames and the hardware
> that actually sends them.

Yes. The actual number of outgoing LAPB frames being queued depends on
how long the hardware driver stays in the TX busy state, and is
limited by the LAPB sending window.

> IIRC [1] there is a general expectation that the NR in a transmitted frame
> will be the same as the last received NS unless acks are being delayed
> for flow control reasons.
>
> You definitely want to be able to ack a received frame while transmitting
> back-to-back I-frames.
>
> This really means that you only want 2 frames in the hardware driver.
> The one being transmitted and the next one - so it gets sent with a
> shared flag.
> There is no point sending an RR unless the hardware link is actually idle.

If I understand correctly, what you mean is that the frames sent on
the wire should reflect the most up-to-date status of what is received
from the wire, so queueing outgoing LAPB frames is not appropriate.

But this would require us to deal with the "TX busy" issue in the LAPB
module. This is (as I said) not easy to do. I currently can't think of
a good way of doing this.

Instead, we can think of the TX queue as part of the "wire". We can
think of the wire as long and having a little higher latency. I
believe the LAPB protocol has no problem in handling long wires.

What do you think?
