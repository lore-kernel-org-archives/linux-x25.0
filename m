From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC v3] net: hdlc_x25: Queue outgoing LAPB frames
Date: Mon, 15 Feb 2021 11:08:02 -0800
Message-ID: <CAJht_EPy1Us72YGMune2G3s1TLB4TOCBFJpZt+KbVUV8uoFbfA@mail.gmail.com>
References: <20210215072703.43952-1-xie.he.0141@gmail.com> <YCo96zjXHyvKpbUM@unreal>
 <CAJht_EOQBDdwa0keS9XTKZgXE44_b5cHJt=fFaKy-wFDpe6iaw@mail.gmail.com> <YCrDcMYgSgdKp4eX@unreal>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wSIIQAoU/qUrHpFtDE4/r1lSSmKppFfAx3tPckyTMg=;
        b=WbZcgfONHMSwsib7jyirAckorAOZ9aIz8BGaGHSxzE9IBK0w2zS4RqERyv2kXqLehJ
         3t8lWW9K6eT2uy0zdiiz5yw0F973t4nNTNikpF/3wmhOu4W+uyQhaNPTzHPv6VQ/2hUY
         KnTwYi3LIV47D4qZMGp4KzyAZ5M5bA3FNgErZoYU6Jgld4bPjW3+WRUSdght+GGuXTZp
         daPGMuEim6QxghMcWiixp9ekOdJZUBSvPyCR3vEmPtVYD0uvuYoCgON6wsyhzteVgbij
         yi8/6n0rOG9nERGp9qWfRIavxLSavRIlWxuocVYOSKY7Xp42kWhkmvRtGstyQJR3MyiF
         /Ncg==
In-Reply-To: <YCrDcMYgSgdKp4eX@unreal>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>

On Mon, Feb 15, 2021 at 10:54 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> On Mon, Feb 15, 2021 at 09:23:32AM -0800, Xie He wrote:
> > On Mon, Feb 15, 2021 at 1:25 AM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > > +     /* When transmitting data:
> > > > +      * first we'll remove a pseudo header of 1 byte,
> > > > +      * then the LAPB module will prepend an LAPB header of at most 3 bytes.
> > > > +      */
> > > > +     dev->needed_headroom = 3 - 1;
> > >
> > > 3 - 1 = 2
> > >
> > > Thanks
> >
> > Actually this is intentional. It makes the numbers more meaningful.
> >
> > The compiler should automatically generate the "2" so there would be
> > no runtime penalty.
>
> If you want it intentional, write it in the comment.
>
> /* When transmitting data, we will need extra 2 bytes headroom,
>  * which are 3 bytes of LAPB header minus one byte of pseudo header.
>  */
>  dev->needed_headroom = 2;

I think this is unnecessary. The current comment already explains the
meaning of the "1" and the "3". There's no need for a reader of this
code to understand what a "2" is. That is the job of the compiler, not
the human reader.
