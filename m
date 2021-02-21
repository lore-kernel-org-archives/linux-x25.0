From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Sun, 21 Feb 2021 11:13:34 -0800
Message-ID: <CAJht_ENK=X1hXhM2qkwZW6xoFwMB5R+iS0GSnsXR3EERd+S35g@mail.gmail.com>
References: <20210216201813.60394-1-xie.he.0141@gmail.com> <YC4sB9OCl5mm3JAw@unreal>
 <CAJht_EN2ZO8r-dpou5M4kkg3o3J5mHvM7NdjS8nigRCGyih7mg@mail.gmail.com>
 <YC5DVTHHd6OOs459@unreal> <CAJht_EOhu+Wsv91yDS5dEt+YgSmGsBnkz=igeTLibenAgR=Tew@mail.gmail.com>
 <YC7GHgYfGmL2wVRR@unreal> <CAJht_EPZ7rVFd-XD6EQD2VJTDtmZZv0HuZvii+7=yhFgVz68VQ@mail.gmail.com>
 <CAJht_EPPMhB0JTtjWtMcGbRYNiZwJeMLWSC5hS6WhWuw5FgZtg@mail.gmail.com>
 <20210219103948.6644e61f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EOru3pW6AHN4QVjiaERpLSfg-0G0ZEaqU_hkhX1acv0HQ@mail.gmail.com> <YDIAIwLVQK0P4EQW@unreal>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9okeHahnxkQIyczL5QktCGq4Y0Vq91gH7S23ae5Xnxo=;
        b=ZVyvhv+PO5zERn53QqLCYhRDu/Jd831HCK2eVChketfdSpEZbSeL1z/aaPFo2vnvR+
         25NrSf2RBYEw/2jgb4TzsEuXAuu0CgdBWBjN6/FZbldIgnVbOryelwcts9SMGC2vXrcK
         nrEVbWyHLo6uUnSK8iUnIZ0qBiEKU7OkcysTCPwkxe4FZjdTyHw7514agzy/ZflykECN
         /K4zIxWGiNMo0ShlxNA1tnKhp+hJjjwVUsbfV3ozj3/iZ7l3MZBbTutwzg0dCEAjjXnL
         zixXdaV7BfjAZPNbYxmY9kiBshChyxJ0Vbn6VARZHR5TLWr8ZfVX6OTTMePxbFhNOnSr
         VzFg==
In-Reply-To: <YDIAIwLVQK0P4EQW@unreal>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leon Romanovsky <leon@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On Sat, Feb 20, 2021 at 10:39 PM Leon Romanovsky <leon@kernel.org> wrote:
>
> > Yes, this patch will break backward compatibility. Users with old
> > scripts will find them no longer working.
>
> Did you search in debian/fedora code repositories to see if such scripts exist
> as part of any distro package?

I just tried to search in Debian and Fedora packages but didn't seem
to find anything related.

I searched "hdlc" and "x25". The only things I can find are "AX.25"
related things. But "AX.25" is not related to "X.25".

I guess a script that brings a network interface up might not be very
useful? So we might not be able to find it in public repositories.
