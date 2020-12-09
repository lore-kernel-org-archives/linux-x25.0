From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v7 4/5] net/x25: fix restart request/confirm
 handling
Date: Wed, 09 Dec 2020 10:40:59 +0100
Message-ID: <3e314d2786857cbd5aaee8b83a0e6daa@dev.tdt.de>
References: <20201126063557.1283-1-ms@dev.tdt.de>
 <20201126063557.1283-5-ms@dev.tdt.de>
 <CAJht_EMZqcPdE5n3Vp+jJa1sVk9+vbwd-Gbi8Xqy19bEdbNNuA@mail.gmail.com>
 <CAJht_ENukJrnh6m8FLrHBwnKKyZpzk6uGWhS4_eUCyDzrCG3eA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJht_ENukJrnh6m8FLrHBwnKKyZpzk6uGWhS4_eUCyDzrCG3eA@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-12-09 10:17, Xie He wrote:
> On Wed, Dec 9, 2020 at 1:01 AM Xie He <xie.he.0141@gmail.com> wrote:
>> 
>> On Wed, Nov 25, 2020 at 10:36 PM Martin Schiller <ms@dev.tdt.de> 
>> wrote:
>> >
>> >         switch (nb->state) {
>> >         case X25_LINK_STATE_0:
>> > -               nb->state = X25_LINK_STATE_2;
>> > -               break;
>> >         case X25_LINK_STATE_1:
>> >                 x25_transmit_restart_request(nb);
>> >                 nb->state = X25_LINK_STATE_2;
>> 
>> What is the reason for this change? Originally only the connecting
>> side will transmit a Restart Request; the connected side will not and
>> will only wait for the Restart Request to come. Now both sides will
>> transmit Restart Requests at the same time. I think we should better
>> avoid collision situations like this.
> 
> Oh. I see. Because in other patches we are giving L2 the ability to
> connect by itself, both sides can now appear here to be the
> "connected" side. So we can't make the "connected" side wait as we did
> before.

Right.
By the way: A "Restart Collision" is in practice a very common event to
establish the Layer 3.
