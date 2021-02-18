From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Thu, 18 Feb 2021 01:07:13 -0800
Message-ID: <CAJht_EN2ZO8r-dpou5M4kkg3o3J5mHvM7NdjS8nigRCGyih7mg@mail.gmail.com>
References: <20210216201813.60394-1-xie.he.0141@gmail.com> <YC4sB9OCl5mm3JAw@unreal>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQBztfjp/3MStXH0+mDXVbD87NdXIglzoEnDzflrmdo=;
        b=INyf+rS1a7pOuZUIhaR+wFHLLKpfHZAS7UUgssDvlYB3GEsesmLx/Dwx8MkLzl02Db
         NoWvuMnGyis3hfOs0LbWrnaYIs4Xu4LibjIJH7P2CTIbFGMCXjPpCvXeuzHXNv6+qkJ0
         ffWuVk4MgszZVYs531kCG+T4f7NaLTwB4LUzjPmIHwQwyd9dz+njhS/wBtMQHWDqhav0
         61LMCyWdXzpy5WeNP5XVrGo28WqQjN9w6lm+INpPGPZBpTaueOc/JpJ48Db0J1HHjBC4
         pmnah0vJHqY9sBUx7V2YUnd804JzEtrKInVgt3B20jRuOWo3xi23R9aQ364tziUDeI8B
         ftog==
In-Reply-To: <YC4sB9OCl5mm3JAw@unreal>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On Thu, Feb 18, 2021 at 12:57 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> It is nice that you are resending your patch without the resolution.
> However it will be awesome if you don't ignore review comments and fix this "3 - 1"
> by writing solid comment above.

I thought you already agreed with me? It looks like you didn't?

I still don't think there is any problem with my current way.

I still don't understand your point. What problem do you think is
there? Why is your way better than my way? I've already given multiple
reasons about why my way is better than yours. But you didn't explain
clearly why yours is better than mine.
