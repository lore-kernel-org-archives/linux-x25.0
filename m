From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Fri, 19 Feb 2021 12:28:12 -0800
Message-ID: <CAJht_EOru3pW6AHN4QVjiaERpLSfg-0G0ZEaqU_hkhX1acv0HQ@mail.gmail.com>
References: <20210216201813.60394-1-xie.he.0141@gmail.com> <YC4sB9OCl5mm3JAw@unreal>
 <CAJht_EN2ZO8r-dpou5M4kkg3o3J5mHvM7NdjS8nigRCGyih7mg@mail.gmail.com>
 <YC5DVTHHd6OOs459@unreal> <CAJht_EOhu+Wsv91yDS5dEt+YgSmGsBnkz=igeTLibenAgR=Tew@mail.gmail.com>
 <YC7GHgYfGmL2wVRR@unreal> <CAJht_EPZ7rVFd-XD6EQD2VJTDtmZZv0HuZvii+7=yhFgVz68VQ@mail.gmail.com>
 <CAJht_EPPMhB0JTtjWtMcGbRYNiZwJeMLWSC5hS6WhWuw5FgZtg@mail.gmail.com> <20210219103948.6644e61f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4EqFO0bHbbTwpYb76+dNzJNfpMa1CvcusLleWdgGeU=;
        b=FjbQtzavC+F6wFZFWqI/3sC7jEEjVbmpIItbY6mJdmalBiaERgiiTrttCFz6vibxqB
         ACzjaHvFiyT4LhlkZXHDFX41AvRRqzGRm3kyo1oP9dnjhEUCN9+yTn0tk0KmGQfRFPxi
         jSZ37aKyRXYnmrKrgVTxKRxeH/Y9G0gUepagvWzflo/A5CDWZcUaWf0+VE43qvrFfTtj
         LoMrthb51/s29XZifhv+MklYAlO4isQtEC3eDKR8ACfPCkLi9en75RqU3qVDUlMA+Tcg
         tXP5A6V7wIiqhECOAnBYymtn7F5J6yo/veej9rXon1y7MbY6zXYRTDvoSS7WRVJxGnrY
         +EzQ==
In-Reply-To: <20210219103948.6644e61f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On Fri, Feb 19, 2021 at 10:39 AM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Not entirely sure what the argument is about but adding constants would
> certainly help.

Leon wants me to replace this:

dev->needed_headroom = 3 - 1;

with this:

/* 2 is the result of 3 - 1 */
dev->needed_headroom = 2;

But I don't feel his way is better than my way.

> More fundamentally IDK if we can make such a fundamental change here.
> When users upgrade from older kernel are all their scripts going to
> work the same? Won't they have to bring the new netdev up?

Yes, this patch will break backward compatibility. Users with old
scripts will find them no longer working.

However, it's hard for me to find a better way to solve the problem
described in the commit message.

So I sent this as an RFC to see what people think about this. (Martin
Schiller seems to be OK with this.)

I think users who don't use scripts can adapt quickly and users who
use scripts can also trivally fix their scripts.

Actually many existing commits in the kernel also (more or less) cause
some user-visible changes. But I admit this patch is a really big
change.
