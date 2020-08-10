From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
Date: Mon, 10 Aug 2020 09:31:43 +0200
Message-ID: <CA+FuTSdBNn218kuswND5OE4vZ4mxz3_hTDkcRmZn2Z9-gaYQZg@mail.gmail.com>
References: <20200808175251.582781-1-xie.he.0141@gmail.com>
 <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com> <CAJht_EM9q9u34LMAeYsYe5voZ54s3Z7OzxtvSomcF9a9wRvuCQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJo6TZcaNoJonrq3wQzaYlOn0q7KCaKbS7KLCKU2QzA=;
        b=J526to2DvxuRZ8736kFIZtIMrd+wGpUCmG9v/rejtCm6ZNbh/i5xF906ohsgmAiJ78
         FPeEcYbsYrJ3+Qiyi7vfxUQIT0YTtEeGabjI+phjc6DvfO3d/No2a/62W+3KjbK9N1yE
         C8EIRoSvnU2dzVpWyvin8SRVuszcz2foFihxhvFK6OQYA/F+eJS2pfM1+0cTYy/Z4bn3
         SKofNlcHWdAd0oGfiCt5GOYGUbIDXX+ZVEcHaE/xSSqEV02cBBNtLQs86tNIL+zkUeut
         lIqtPEQSc3Ru8im6pH2QAvwoxYV0EO8jBYG12kwkquzTCdgHQqKnVDF9bVWjNAizum9R
         S8Ug==
In-Reply-To: <CAJht_EM9q9u34LMAeYsYe5voZ54s3Z7OzxtvSomcF9a9wRvuCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Sun, Aug 9, 2020 at 7:12 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Sun, Aug 9, 2020 at 1:48 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > Does this solve an actual observed bug?
> >
> > In many ways lapbeth is similar to tunnel devices. This is not common.
>
> Thank you for your comment!
>
> This doesn't solve a bug observed by me. But I think this should be
> necessary considering the logic of the code.
>
> Using "grep", I found that there were indeed Ethernet drivers that set
> needed_tailroom. I found it was set in these files:
>     drivers/net/ethernet/sun/sunvnet.c
>     drivers/net/ethernet/sun/ldmvsw.c
> Setting needed_tailroom may be necessary for this driver to run those
> Ethernet devices.

What happens when a tunnel device passes a packet to these devices?
That will also not have allocated the extra tailroom. Does that cause
a bug?
