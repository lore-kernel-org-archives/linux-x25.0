From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Thu, 18 Feb 2021 09:36:54 -0800
Message-ID: <CAJht_EOhu+Wsv91yDS5dEt+YgSmGsBnkz=igeTLibenAgR=Tew@mail.gmail.com>
References: <20210216201813.60394-1-xie.he.0141@gmail.com> <YC4sB9OCl5mm3JAw@unreal>
 <CAJht_EN2ZO8r-dpou5M4kkg3o3J5mHvM7NdjS8nigRCGyih7mg@mail.gmail.com> <YC5DVTHHd6OOs459@unreal>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xmf6pTNe7mQQ+6NHgcE8bVS8WWzHYXysNcfphF1I+24=;
        b=Y/8D/DbfQgqs+GHwMjEuxhzZCU1naE54M6ECflXmCALxpIV0AXdNrz2eQRDpXtFki5
         URJgtKjb+/zCNsyyRv0sKQ0oom1VGKhXLAcENdEsQUj2CslkwXOWuuTg77O8rgBXUsSI
         E4Xchs1spLREWPvvEip4Oi5pDq7yhTMQNsRiN3apzSRM1/4DTDz/tIktS4oZbFyc0P6P
         S2eThA6pR6nCXcCgq2GMoJNSAlJb5h+v7ae7/diE2HF8Zbp2e1E/S3iNJihZ+3tvY30c
         WRSxxvxRC5rdr4NUsysZfIRYrmF+YZfEb+g5w9TUPRZERGZjnj6SCn9FcUl+PG6LWKsv
         AHjw==
In-Reply-To: <YC5DVTHHd6OOs459@unreal>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On Thu, Feb 18, 2021 at 2:37 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> It is not me who didn't explain, it is you who didn't want to write clear
> comment that describes the headroom size without need of "3 - 1".

Why do I need to write unnecessary comments when "3 - 1" and the
current comment already explains everything?

> So in current situation, you added two things: comment and assignment.
> Both of them aren't serve their goals.

Why?

> Your comment doesn't explain
> enough and needs extra help

Why? My comment already explains everything.

> and your assignment is useless without
> comment.

My assignment is already very clear with my current comment. My
comment explains very clearly what this assignment means.
