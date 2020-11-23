From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Mon, 23 Nov 2020 07:55:18 +0100
Message-ID: <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de>
References: <20201120054036.15199-1-ms@dev.tdt.de>
 <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
 <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-21 00:50, Xie He wrote:
> On Fri, Nov 20, 2020 at 3:11 PM Xie He <xie.he.0141@gmail.com> wrote:
>> 
>> Should we also handle the NETDEV_UP event here? In previous versions
>> of this patch series you seemed to want to establish the L2 connection
>> on device-up. But in this patch, you didn't handle NETDEV_UP.
>> 
>> Maybe on device-up, we need to check if the carrier is up, and if it
>> is, we do the same thing as we do on carrier-up.
> 
> Are the device up/down status and the carrier up/down status
> independent of each other? If they are, on device-up or carrier-up, we
> only need to try establishing the L2 connection if we see both are up.

No, they aren't independent. The carrier can only be up if the device /
interface is UP. And as far as I can see a NETDEV_CHANGE event will also
only be generated on interfaces that are UP.

So you can be sure, that if there is a NETDEV_CHANGE event then the
device is UP.

I removed the NETDEV_UP handling because I don't think it makes sense
to implicitly try to establish layer2 (LAPB) if there is no carrier.
And with the first X.25 connection request on that interface, it will
be established anyway by x25_transmit_link().

I've tested it here with an HDLC WAN Adapter and it works as expected.

These are also the ideal conditions for the already mentioned "on
demand" scenario. The only necessary change would be to call
x25_terminate_link() on an interface after clearing the last X.25
session.

> On NETDEV_GOING_DOWN, we can also check the carrier status first and
> if it is down, we don't need to call lapb_disconnect_request.

This is not necessary because lapb_disconnect_request() checks the
current state. And if the carrier is DOWN then the state should also be
LAPB_STATE_0 and so lapb_disconnect_request() does nothing.
