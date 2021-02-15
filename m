From: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net-next RFC v3] net: hdlc_x25: Queue outgoing LAPB frames
Date: Mon, 15 Feb 2021 20:54:40 +0200
Message-ID: <YCrDcMYgSgdKp4eX@unreal>
References: <20210215072703.43952-1-xie.he.0141@gmail.com>
 <YCo96zjXHyvKpbUM@unreal>
 <CAJht_EOQBDdwa0keS9XTKZgXE44_b5cHJt=fFaKy-wFDpe6iaw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613415284;
        bh=eo/4Fc82BsHSHFe3I6vwWIYa3nQLkkClzzx7vCGgZSs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tppWbswEkgV5Gzo7DB2+3AcEp7Rpd4v5bXyMABw+pmjdDBRMmOaHZvNXGXtL63n2C
         CMLKP+DMLzr77zDre3x48Io3F3dJnnxh9Fz0cgxtHQ+So+G1UxYqrqBdnp98H8AWAN
         ZUd86V93kIMOao6HixmADZrToW9RzzdSOTEF8ijCmNQRb6Kv63CswhjkflcKqFn7OL
         122qQ5XptSMCcjk0317K1EUcgbT1Uy1c/KGqCTnGTiJsIlM48zd3cF3v7lWovv16Lh
         exqkxmwWEALFOP/6K8sejW9rlqDZTP3hajPhISc/n6CuJy7oiTaZANQwJ5BlWEJGlm
         pEbr1A90Dnt2A==
Content-Disposition: inline
In-Reply-To: <CAJht_EOQBDdwa0keS9XTKZgXE44_b5cHJt=fFaKy-wFDpe6iaw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>

On Mon, Feb 15, 2021 at 09:23:32AM -0800, Xie He wrote:
> On Mon, Feb 15, 2021 at 1:25 AM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > > +     /* When transmitting data:
> > > +      * first we'll remove a pseudo header of 1 byte,
> > > +      * then the LAPB module will prepend an LAPB header of at most 3 bytes.
> > > +      */
> > > +     dev->needed_headroom = 3 - 1;
> >
> > 3 - 1 = 2
> >
> > Thanks
>
> Actually this is intentional. It makes the numbers more meaningful.
>
> The compiler should automatically generate the "2" so there would be
> no runtime penalty.

If you want it intentional, write it in the comment.

/* When transmitting data, we will need extra 2 bytes headroom,
 * which are 3 bytes of LAPB header minus one byte of pseudo header.
 */
 dev->needed_headroom = 2;
