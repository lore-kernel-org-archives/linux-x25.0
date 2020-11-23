From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Mon, 23 Nov 2020 03:17:54 -0800
Message-ID: <CAJht_EPtPDOSYfwc=9trBMdzLw4BbTzJbGvaEgWoyiy2624Q+Q@mail.gmail.com>
References: <20201120054036.15199-1-ms@dev.tdt.de> <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
 <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
 <87a620b6a55ea8386bffefca0a1f8b77@dev.tdt.de> <CAJht_EPc8MF1TjznSjWTPyMbsrw3JVqxST5g=eF0yf_zasUdeA@mail.gmail.com>
 <d85a4543eae46bac1de28ec17a2389dd@dev.tdt.de> <CAJht_EMjO_Tkm93QmAeK_2jg2KbLdv2744kCSHiZLy48aXiHnw@mail.gmail.com>
 <CAJht_EO+enBOFMkVVB5y6aRnyMEsOZtUBJcAvOFBS91y7CauyQ@mail.gmail.com> <16b7e74e6e221f43420da7836659d7df@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c7qAoRDEBVkDADtuqAeO2Rb/J+k1l2uuc/tv5XiZIz0=;
        b=oBIa9Kk7yDENh2JR7iXYy+f7wKXrPKCeVdZAtdqXZ8CkA/5jDtHw/T1V/prn2ogng+
         wucjqc3cEu0nvuWiWLyWMkiYd03btoUcIMRHqpcSGZMG+WFrH18R0PZNgtHpdDcsbAFy
         /d0PDYsNI6fmxhlchkW1F/910DBlkEkVGshR5uiuFxPqR6Y8XZByXCap3jHGaUxg50Vj
         L+BE34h7As+Spm28EMnn+IJWN0aj/q9imsh3AfjSQiAmMV4UY3JO5oh/UvxyJ25YlqhE
         GpTEFHEnKXAxpTlWPRYlScpv9MmOMMFoGwXkmtAuZHYlcxwny8GE2tsM7fxxbq4xra+O
         DE0Q==
In-Reply-To: <16b7e74e6e221f43420da7836659d7df@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 23, 2020 at 2:38 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Well, one could argue that we would have to repair these drivers, but I
> don't think that will get us anywhere.

Yeah... One problem I see with the Linux project is the lack of
docs/specs. Often we don't know what is right and what is wrong.

>  From this point of view it will be the best to handle the NETDEV_UP in
> the lapb event handler and establish the link analog to the
> NETDEV_CHANGE event if the carrier is UP.

Thanks! This way we can make sure LAPB would automatically connect in
all situations.

Since we'll have a netif_carrier_ok check in NETDEV_UP handing, it
might make the code look prettier to also have a netif_carrier_ok
check in NETDEV_GOING_DOWN handing (for symmetry). Just a suggestion.
You can do whatever looks good to you :)

Thanks!
