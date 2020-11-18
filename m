From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v2 5/6] net/lapb: support netdev events
Date: Wed, 18 Nov 2020 14:57:02 +0100
Message-ID: <b494372c616c811ab8814e42c907434f@dev.tdt.de>
References: <20201116135522.21791-1-ms@dev.tdt.de>
 <20201116135522.21791-6-ms@dev.tdt.de>
 <CAJht_EM-ic4-jtN7e9F6zcJgG3OTw_ePXiiH1i54M+Sc8zq6bg@mail.gmail.com>
 <f3ab8d522b2bcd96506352656a1ef513@dev.tdt.de>
 <CAJht_EPN=hXsGLsCSxj1bB8yTYNOe=yUzwtrtnMzSybiWhL-9Q@mail.gmail.com>
 <c0c2cedad399b12d152d2610748985fc@dev.tdt.de>
 <CAJht_EO=G94_xoCupr_7Tt_-kjYxZVfs2n4CTa14mXtu7oYMjg@mail.gmail.com>
 <c60fe64ff67e244bbe9971cfa08713db@dev.tdt.de>
 <CAJht_EOSZRV9uBcRYq6OBLwFOX7uE9Nox+sFv-U0SXRkLaNBrQ@mail.gmail.com>
 <CAJht_EMd5iKmdvePgYzWYXnG=5LxQopStzz_Lk9uNSkRyrudqw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJht_EMd5iKmdvePgYzWYXnG=5LxQopStzz_Lk9uNSkRyrudqw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-18 14:46, Xie He wrote:
> On Wed, Nov 18, 2020 at 5:03 AM Xie He <xie.he.0141@gmail.com> wrote:
>> 
>> On Wed, Nov 18, 2020 at 12:49 AM Martin Schiller <ms@dev.tdt.de> 
>> wrote:
>> >
>> > I also have a patch here that implements an "on demand" link feature,
>> > which we used for ISDN dialing connections.
>> > As ISDN is de facto dead, this is not relevant anymore. But if we want
>> > such kind of feature, I think we need to stay with the method to control
>> > L2 link state from L3.
>> 
>> I see. Hmm...
>> 
>> I guess for ISDN, the current code (before this patch series) is the
>> best. We only establish the connection when L3 has packets to send.
>> 
>> Can we do this? We let L2 handle all device-up / device-down /
>> carrier-up / carrier-down events. And when L3 has some packets to send
>> but it still finds the L2 link is not up, it will then instruct L2 to
>> connect.
>> 
>> This way we may be able to both keep the logic simple and still keep
>> L3 compatible with ISDN.
> 
> Another solution might be letting ISDN automatically connect when it
> receives the first packet from L3. This way we can still free L3 from
> all handlings of L2 connections.

ISDN is not important now. Also the I4L subsystem has been removed.

I have now completely reworked the patch-set and it is now much tidier.
For now I left the event handling completely in X.25 (L3).

I will now send the whole thing as v3 and we can discuss it further.
