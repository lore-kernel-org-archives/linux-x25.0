From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next] net: x25: Remove unimplemented X.25-over-LLC
 code stubs
Date: Wed, 9 Dec 2020 14:53:55 -0800
Message-ID: <CAJht_EMQFtR_-QH=QMHt9+cLcNO6LHBSy2fy=mgbic+=JUsR-Q@mail.gmail.com>
References: <20201209033346.83742-1-xie.he.0141@gmail.com> <801dc0320e484bf7a5048c0cddac12af@AcuMS.aculab.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lanATv4oPPkDwFaB9qQIK45VqUMTlXl+oCa+92TkqwA=;
        b=a1LJT7CHqVkFmpPPq4vfKK2iHYDskt9d+GXuzzpCWibXJC1W/p0QZTjJR6YKYQR8Iz
         RzGqgrBd52sbdim6Bi9MPNMld+VVyXPFECoaK0mUOwvsB8tZTlaaNoJFMeOW8cQxTEet
         lI3pKj2aVudpw8X5z1WYy0+uKlJRUqJQsJy6gFgVJPNL4dSi+TmO1BuDaLsbP4oy5tw3
         H5WtWrkk5M6zfPoLmutuxcfzxOm6iqz5McABNS85JISQj1//HO1QtV7/qyCObtYUhNUm
         b6uKHxTOtbtrue3mIGyVoYQxQjfmytvIoF1YMI7gbYFOPsi3LFgtdRscTtaBi5Kh7RSZ
         hwCg==
In-Reply-To: <801dc0320e484bf7a5048c0cddac12af@AcuMS.aculab.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Laight <David.Laight@aculab.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Wed, Dec 9, 2020 at 1:21 PM David Laight <David.Laight@aculab.com> wrote:
>
> I always wondered about running Class 2 transport directly over LLC2
> (rather than Class 4 over LLC1).
> But the only LLC2 user was netbios - and microsoft's LLC2 was broken.
> Not to mention the window probing needed to handle systems that
> said they supported a window of (IIRC) 15 but would discard the
> 5th back to back frame.

To me, LLC1 and LLC2 are to Ethernet what UDP and TCP are to IP
networks. I think we can use LLC1 and LLC2 wherever UDP and TCP can be
used, as long as we are in the same LAN and are willing to use MAC
addresses as the addresses. X.25 layer 3 certainly can also run over
LLC2.

Linux actually has support for LLC1 and LLC2. User space programs can
transmit data directly over LLC1 and LLC2 using "AF_LLC" sockets.
