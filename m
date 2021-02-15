From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC v3] net: hdlc_x25: Queue outgoing LAPB frames
Date: Mon, 15 Feb 2021 09:23:32 -0800
Message-ID: <CAJht_EOQBDdwa0keS9XTKZgXE44_b5cHJt=fFaKy-wFDpe6iaw@mail.gmail.com>
References: <20210215072703.43952-1-xie.he.0141@gmail.com> <YCo96zjXHyvKpbUM@unreal>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sLQol9oxPeOG1Kr+YSSO0W5V4v2gUOFh7QiJCDdWNqU=;
        b=PkxBFU5nVbo5oAYYa/lQpvEaEElCvLWhl43ILCDOizN0iRgnF7V6yqP6qzHIU6WwCo
         HW4tHjJF1xxu2ds31Pbjpj8r4MsTNwTEtlSRgxhJQreeLE3McunlDsmvy/FoGa42cGr8
         3wpDfMRo8hRMO2hEoD1r3EuWvn/FqeCaHahfd1TfnbQb/246+9jWL9AS886OLFia/OzI
         H51eHKJ0HBpSVqlXQdskpc6in/V9HpuqIbdqZe/xI9CamRfb0mZ8zOcD1LnrbFpholCp
         2cP9YhTwIDwzEdW7bGvqX2xG9zUXPlyNE6CV8TzI/2XyBn9aVntjE8bM48rB4ZsYXUxF
         xP0A==
In-Reply-To: <YCo96zjXHyvKpbUM@unreal>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>

On Mon, Feb 15, 2021 at 1:25 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> > +     /* When transmitting data:
> > +      * first we'll remove a pseudo header of 1 byte,
> > +      * then the LAPB module will prepend an LAPB header of at most 3 bytes.
> > +      */
> > +     dev->needed_headroom = 3 - 1;
>
> 3 - 1 = 2
>
> Thanks

Actually this is intentional. It makes the numbers more meaningful.

The compiler should automatically generate the "2" so there would be
no runtime penalty.
