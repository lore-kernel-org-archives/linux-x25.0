From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Mon, 23 Nov 2020 14:09:43 -0800
Message-ID: <CAJht_EOA4+DSjnKYZX3udrXX9jGHRmFw3OQesUb3AncD2oowwA@mail.gmail.com>
References: <20201120054036.15199-1-ms@dev.tdt.de> <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
 <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
 <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de> <CAJht_EPc8MF1TjznSjWTPyMbsrw3JVqxST5g=eF0yf_zasUdeA@mail.gmail.com>
 <d85a4543eae46bac1de28ec17a2389dd@dev.tdt.de> <CAJht_EMjO_Tkm93QmAeK_2jg2KbLdv2744kCSHiZLy48aXiHnw@mail.gmail.com>
 <CAJht_EO+enBOFMkVVB5y6aRnyMEsOZtUBJcAvOFBS91y7CauyQ@mail.gmail.com>
 <16b7e74e6e221f43420da7836659d7df@dev.tdt.de> <CAJht_EPtPDOSYfwc=9trBMdzLw4BbTzJbGvaEgWoyiy2624Q+Q@mail.gmail.com>
 <20201123113622.115c474b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FA3bZWejjzUky+cRUDelSVf+reBgBIWV9vO6dtK4fYI=;
        b=cUmfrb3nRvaRxOO7vYL2kyuceAP4S2Lb6WvrYCOPs9nqxPdHdFzmYnsShUdQyjh6ic
         Hu0Pg+okTXYE+CKl3uwDoRHEcbZ8SK3VCPTTJE97fc5AuR/MEo22EfW6DINwVaLx2UBv
         ruK81gxj6Vafguega2sA5w7GjXleqeF43MSh15H+cDgNa9APVzXlLNMJZcRdZErT0kmn
         bUxCdAV2j14kVEZ7uai6Wcgzqg4B2dZp3s15at7VE9akgMQ1C6dc/49RMj74bpzPLpNU
         O1Cn73+n8SAKWFkDKLfSh3Z6zN256I1hpLwliR6h0mC9HPWN+/GeT+WIfvtHzvdI9/ss
         mr/w==
In-Reply-To: <20201123113622.115c474b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin Schiller <ms@dev.tdt.de>, Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 23, 2020 at 11:36 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> > >  From this point of view it will be the best to handle the NETDEV_UP in
> > > the lapb event handler and establish the link analog to the
> > > NETDEV_CHANGE event if the carrier is UP.
> >
> > Thanks! This way we can make sure LAPB would automatically connect in
> > all situations.
> >
> > Since we'll have a netif_carrier_ok check in NETDEV_UP handing, it
> > might make the code look prettier to also have a netif_carrier_ok
> > check in NETDEV_GOING_DOWN handing (for symmetry). Just a suggestion.
> > You can do whatever looks good to you :)
>
> Xie other than this the patches look good to you?
>
> Martin should I expect a respin to follow Xie's suggestion
> or should I apply v4?

There should be a respin because we need to handle the NETDEV_UP
event. The lapbether driver (and possibly some HDLC WAN drivers)
doesn't generate carrier events so we need to do auto-connect in the
NETDEV_UP event.
