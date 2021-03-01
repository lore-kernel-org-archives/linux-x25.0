From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Mon, 01 Mar 2021 07:56:25 +0100
Message-ID: <ff200b159ef358494a922a676cbef8a6@dev.tdt.de>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_ENP3Y98jgj1peGa3fGpQ-qPaF=1gtyYwMcawRFW_UCpeA@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On 2021-02-27 00:03, Xie He wrote:
> On Fri, Feb 26, 2021 at 6:21 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> I have now had a look at it. It works as expected.
>> I just wonder if it would not be more appropriate to call
>> the lapb_register() already in x25_hdlc_open(), so that the layer2
>> (lapb) can already "work" before the hdlc<x>_x25 interface is up.
> 
> I think it's better not to keep LAPB running unless hdlc<x>_x25 is up.
> If I am the user, I would expect that when I change the X.25 interface
> to the DOWN state, the LAPB protocol would be completely stopped and
> the LAPB layer would not generate any new frames anymore (even if the
> other side wants to connect), and when I change the X.25 interface
> back to the UP state, it would be a fresh new start for the LAPB
> protocol.
> 
>> Also, I have a hard time assessing if such a wrap is really 
>> enforceable.
> 
> Sorry. I don't understand what you mean. What "wrap" are you referring 
> to?

I mean the change from only one hdlc<x> interface to both hdlc<x> and
hdlc<x>_x25.

I can't estimate how many users are out there and how their setup looks
like.

> 
>> Unfortunately I have no idea how many users there actually are.
