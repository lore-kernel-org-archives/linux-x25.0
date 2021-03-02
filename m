From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Tue, 02 Mar 2021 08:04:20 +0100
Message-ID: <41b77b1c3cf1bb7a51b750faf23900ef@dev.tdt.de>
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
 <906d8114f1965965749f1890680f2547@dev.tdt.de>
 <CAJht_EPBJhhdCBoon=WMuPBk-sxaeYOq3veOpAd2jq5kFqQHBg@mail.gmail.com>
 <e1750da4179aca52960703890e985af3@dev.tdt.de>
 <CAJht_ENP3Y98jgj1peGa3fGpQ-qPaF=1gtyYwMcawRFW_UCpeA@mail.gmail.com>
 <ff200b159ef358494a922a676cbef8a6@dev.tdt.de>
 <CAJht_EMG27YU+Jxtb2qeq1nXwu8uV8FXQPr62OcNHsE7DozD1g@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJht_EMG27YU+Jxtb2qeq1nXwu8uV8FXQPr62OcNHsE7DozD1g@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On 2021-03-01 09:56, Xie He wrote:
> On Sun, Feb 28, 2021 at 10:56 PM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> >> Also, I have a hard time assessing if such a wrap is really
>> >> enforceable.
>> >
>> > Sorry. I don't understand what you mean. What "wrap" are you referring
>> > to?
>> 
>> I mean the change from only one hdlc<x> interface to both hdlc<x> and
>> hdlc<x>_x25.
>> 
>> I can't estimate how many users are out there and how their setup 
>> looks
>> like.
> 
> I'm also thinking about solving this issue by adding new APIs to the
> HDLC subsystem (hdlc_stop_queue / hdlc_wake_queue) for hardware
> drivers to call instead of netif_stop_queue / netif_wake_queue. This
> way we can preserve backward compatibility.
> 
> However I'm reluctant to change the code of all the hardware drivers
> because I'm afraid of introducing bugs, etc. When I look at the code
> of "wan/lmc/lmc_main.c", I feel I'm not able to make sure there are no
> bugs (related to stop_queue / wake_queue) after my change (and even
> before my change, actually). There are even serious style problems:
> the majority of its lines are indented by spaces.
> 
> So I don't want to mess with all the hardware drivers. Hardware driver
> developers (if they wish to properly support hdlc_x25) should do the
> change themselves. This is not a problem for me, because I use my own
> out-of-tree hardware driver. However if I add APIs with no user code
> in the kernel, other developers may think these APIs are not
> necessary.

I don't think a change that affects the entire HDLC subsystem is
justified, since the actual problem only affects the hdlc_x25 area.

The approach with the additional hdlc<x>_x25 is clean and purposeful and
I personally could live with it.

I just don't see myself in the position to decide such a change at the
moment.

@Jakub: What is your opinion on this.
