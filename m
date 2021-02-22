From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Mon, 22 Feb 2021 08:14:07 +0100
Message-ID: <906d8114f1965965749f1890680f2547@dev.tdt.de>
References: <20210216201813.60394-1-xie.he.0141@gmail.com>
 <YC4sB9OCl5mm3JAw@unreal>
 <CAJht_EN2ZO8r-dpou5M4kkg3o3J5mHvM7NdjS8nigRCGyih7mg@mail.gmail.com>
 <YC5DVTHHd6OOs459@unreal>
 <CAJht_EOhu+Wsv91yDS5dEt+YgSmGsBnkz=igeTLibenAgR=Tew@mail.gmail.com>
 <YC7GHgYfGmL2wVRR@unreal>
 <CAJht_EPZ7rVFd-XD6EQD2VJTDtmZZv0HuZvii+7=yhFgVz68VQ@mail.gmail.com>
 <CAJht_EPPMhB0JTtjWtMcGbRYNiZwJeMLWSC5hS6WhWuw5FgZtg@mail.gmail.com>
 <20210219103948.6644e61f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EOru3pW6AHN4QVjiaERpLSfg-0G0ZEaqU_hkhX1acv0HQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_EOru3pW6AHN4QVjiaERpLSfg-0G0ZEaqU_hkhX1acv0HQ@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On 2021-02-19 21:28, Xie He wrote:
> On Fri, Feb 19, 2021 at 10:39 AM Jakub Kicinski <kuba@kernel.org> 
> wrote:
>> 
>> Not entirely sure what the argument is about but adding constants 
>> would
>> certainly help.
> 
> Leon wants me to replace this:
> 
> dev->needed_headroom = 3 - 1;
> 
> with this:
> 
> /* 2 is the result of 3 - 1 */
> dev->needed_headroom = 2;
> 
> But I don't feel his way is better than my way.
> 
>> More fundamentally IDK if we can make such a fundamental change here.
>> When users upgrade from older kernel are all their scripts going to
>> work the same? Won't they have to bring the new netdev up?
> 
> Yes, this patch will break backward compatibility. Users with old
> scripts will find them no longer working.
> 
> However, it's hard for me to find a better way to solve the problem
> described in the commit message.
> 
> So I sent this as an RFC to see what people think about this. (Martin
> Schiller seems to be OK with this.)

Well, I said I would like to test it.

I'm not really happy with this change because it breaks compatibility.
We then suddenly have 2 interfaces; the X.25 routings are to be set via
the "new" hdlc<x>_x25 interfaces instead of the hdlc<x> interfaces.

I currently just don't have a nicer solution to fix this queueing
problem either. On the other hand, since the many years we have been
using the current state, I have never noticed any problems with
discarded frames. So it might be more a theoretical problem than a
practical one.


> 
> I think users who don't use scripts can adapt quickly and users who
> use scripts can also trivally fix their scripts.
> 
> Actually many existing commits in the kernel also (more or less) cause
> some user-visible changes. But I admit this patch is a really big
> change.
