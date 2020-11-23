From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Mon, 23 Nov 2020 11:38:34 +0100
Message-ID: <16b7e74e6e221f43420da7836659d7df@dev.tdt.de>
References: <20201120054036.15199-1-ms@dev.tdt.de>
 <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
 <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
 <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de>
 <CAJht_EPc8MF1TjznSjWTPyMbsrw3JVqxST5g=eF0yf_zasUdeA@mail.gmail.com>
 <d85a4543eae46bac1de28ec17a2389dd@dev.tdt.de>
 <CAJht_EMjO_Tkm93QmAeK_2jg2KbLdv2744kCSHiZLy48aXiHnw@mail.gmail.com>
 <CAJht_EO+enBOFMkVVB5y6aRnyMEsOZtUBJcAvOFBS91y7CauyQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJht_EO+enBOFMkVVB5y6aRnyMEsOZtUBJcAvOFBS91y7CauyQ@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-23 11:08, Xie He wrote:
> On Mon, Nov 23, 2020 at 1:36 AM Xie He <xie.he.0141@gmail.com> wrote:
>> 
>> Some drivers don't support carrier status and will never change it.
>> Their carrier status will always be UP. There will not be a
>> NETDEV_CHANGE event.

Well, one could argue that we would have to repair these drivers, but I
don't think that will get us anywhere.

 From this point of view it will be the best to handle the NETDEV_UP in
the lapb event handler and establish the link analog to the
NETDEV_CHANGE event if the carrier is UP.

>> 
>> lapbether doesn't change carrier status. I also have my own virtual
>> HDLC WAN driver (for testing) which also doesn't change carrier
>> status.
>> 
>> I just tested with lapbether. When I bring up the interface, there
>> will only be NETDEV_PRE_UP and then NETDEV_UP. There will not be
>> NETDEV_CHANGE. The carrier status is alway UP.
>> 
>> I haven't tested whether a device can receive NETDEV_CHANGE when it is
>> down. It's possible for a device driver to call netif_carrier_on when
>> the interface is down. Do you know what will happen if a device driver
>> calls netif_carrier_on when the interface is down?
> 
> I just did a test on lapbether and saw there would be no NETDEV_CHANGE
> event when the netif is down, even if netif_carrier_on/off is called.
> So we can rest assured of this part.
