From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Mon, 23 Nov 2020 11:36:22 -0800
Message-ID: <20201123113622.115c474b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
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
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606160184;
        bh=wyyqOuDYJh+AENslY1QRQ2MYtUOAEJj713mUgHNbm2k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ami1Tl/eoich0lFepOwEEEpAaqrVO4wquM/Ues8XEjmxk8OuMwa5Jq+3wgPwI7Plc
         3Pfu+ZZNSqVEsHez8dJ1Olp08sItKNVHQ6lhQ8tVvRJzRH3orB0WsM1cgBGv4jltk2
         ogG+DlweXUSVUazw89w4CF/SM7pXGVNmcH5dpF7Q=
In-Reply-To: <CAJht_EPtPDOSYfwc=9trBMdzLw4BbTzJbGvaEgWoyiy2624Q+Q@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>, Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, 23 Nov 2020 03:17:54 -0800 Xie He wrote:
> On Mon, Nov 23, 2020 at 2:38 AM Martin Schiller <ms@dev.tdt.de> wrote:
> > Well, one could argue that we would have to repair these drivers, but I
> > don't think that will get us anywhere.  
> 
> Yeah... One problem I see with the Linux project is the lack of
> docs/specs. Often we don't know what is right and what is wrong.

More of a historic thing than a requirement AFAIK. Some software
devices, e.g. loopback will not generate carrier events. But in this
case looks like all the devices Martin wants to handle are lapb.

> >  From this point of view it will be the best to handle the NETDEV_UP in
> > the lapb event handler and establish the link analog to the
> > NETDEV_CHANGE event if the carrier is UP.  
> 
> Thanks! This way we can make sure LAPB would automatically connect in
> all situations.
> 
> Since we'll have a netif_carrier_ok check in NETDEV_UP handing, it
> might make the code look prettier to also have a netif_carrier_ok
> check in NETDEV_GOING_DOWN handing (for symmetry). Just a suggestion.
> You can do whatever looks good to you :)

Xie other than this the patches look good to you?

Martin should I expect a respin to follow Xie's suggestion 
or should I apply v4?
