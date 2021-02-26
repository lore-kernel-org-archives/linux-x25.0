From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Fri, 26 Feb 2021 15:20:55 +0100
Message-ID: <e1750da4179aca52960703890e985af3@dev.tdt.de>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_EPBJhhdCBoon=WMuPBk-sxaeYOq3veOpAd2jq5kFqQHBg@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On 2021-02-22 09:56, Xie He wrote:
> On Sun, Feb 21, 2021 at 11:14 PM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> I'm not really happy with this change because it breaks compatibility.
>> We then suddenly have 2 interfaces; the X.25 routings are to be set 
>> via
>> the "new" hdlc<x>_x25 interfaces instead of the hdlc<x> interfaces.
>> 
>> I currently just don't have a nicer solution to fix this queueing
>> problem either. On the other hand, since the many years we have been
>> using the current state, I have never noticed any problems with
>> discarded frames. So it might be more a theoretical problem than a
>> practical one.
> 
> This problem becomes very serious when we use AF_PACKET sockets,
> because the majority of frames would be dropped by the hardware
> driver, which significantly impacts transmission speed. What I am
> really doing is to enable adequate support for AF_PACKET sockets,
> allowing users to use the bare (raw) LAPB protocol. If we take this
> into consideration, this problem is no longer just a theoretical
> problem, but a real practical issue.

I have now had a look at it. It works as expected.
I just wonder if it would not be more appropriate to call
the lapb_register() already in x25_hdlc_open(), so that the layer2
(lapb) can already "work" before the hdlc<x>_x25 interface is up.


Also, I have a hard time assessing if such a wrap is really enforceable.
Unfortunately I have no idea how many users there actually are.


> 
> If we don't want to break backward compatibility, there is another 
> option:
> We can create a new API for the HDLC subsystem for stopping/restarting
> the TX queue, and replace all HDLC hardware drivers' netif_stop_queue
> and netif_wake_queue calls with calls to this new API. This new API
> would then call hdlc_x25 to stop/restart its internal queue.
> 
> But this option would require modifying all HDLC hardware drivers'
> code, and frankly, not all HDLC hardware drivers' developers care
> about running X.25 protocols on their hardware. So this would cause
> both hardware driver instabilities and confusion for hardware driver
> developers.
