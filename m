From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Tue, 24 Nov 2020 06:29:44 +0100
Message-ID: <39b6386b4ce7462f6cb4448020735ed5@dev.tdt.de>
References: <20201120054036.15199-1-ms@dev.tdt.de>
 <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
 <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
 <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de>
 <CAJht_EPc8MF1TjznSjWTPyMbsrw3JVqxST5g=eF0yf_zasUdeA@mail.gmail.com>
 <d85a4543eae46bac1de28ec17a2389dd@dev.tdt.de>
 <CAJht_EMjO_Tkm93QmAeK_2jg2KbLdv2744kCSHiZLy48aXiHnw@mail.gmail.com>
 <CAJht_EO+enBOFMkVVB5y6aRnyMEsOZtUBJcAvOFBS91y7CauyQ@mail.gmail.com>
 <16b7e74e6e221f43420da7836659d7df@dev.tdt.de>
 <CAJht_EPtPDOSYfwc=9trBMdzLw4BbTzJbGvaEgWoyiy2624Q+Q@mail.gmail.com>
 <20201123113622.115c474b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EOA4+DSjnKYZX3udrXX9jGHRmFw3OQesUb3AncD2oowwA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_EOA4+DSjnKYZX3udrXX9jGHRmFw3OQesUb3AncD2oowwA@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-23 23:09, Xie He wrote:
> On Mon, Nov 23, 2020 at 11:36 AM Jakub Kicinski <kuba@kernel.org> 
> wrote:
>> 
>> > >  From this point of view it will be the best to handle the NETDEV_UP in
>> > > the lapb event handler and establish the link analog to the
>> > > NETDEV_CHANGE event if the carrier is UP.
>> >
>> > Thanks! This way we can make sure LAPB would automatically connect in
>> > all situations.
>> >
>> > Since we'll have a netif_carrier_ok check in NETDEV_UP handing, it
>> > might make the code look prettier to also have a netif_carrier_ok
>> > check in NETDEV_GOING_DOWN handing (for symmetry). Just a suggestion.
>> > You can do whatever looks good to you :)
>> 
>> Xie other than this the patches look good to you?
>> 
>> Martin should I expect a respin to follow Xie's suggestion
>> or should I apply v4?
> 
> There should be a respin because we need to handle the NETDEV_UP
> event. The lapbether driver (and possibly some HDLC WAN drivers)
> doesn't generate carrier events so we need to do auto-connect in the
> NETDEV_UP event.

I'll send a v5 with the appropriate change.
