From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v2 5/6] net/lapb: support netdev events
Date: Wed, 18 Nov 2020 05:03:44 -0800
Message-ID: <CAJht_EOSZRV9uBcRYq6OBLwFOX7uE9Nox+sFv-U0SXRkLaNBrQ@mail.gmail.com>
References: <20201116135522.21791-1-ms@dev.tdt.de> <20201116135522.21791-6-ms@dev.tdt.de>
 <CAJht_EM-ic4-jtN7e9F6zcJgG3OTw_ePXiiH1i54M+Sc8zq6bg@mail.gmail.com>
 <f3ab8d522b2bcd96506352656a1ef513@dev.tdt.de> <CAJht_EPN=hXsGLsCSxj1bB8yTYNOe=yUzwtrtnMzSybiWhL-9Q@mail.gmail.com>
 <c0c2cedad399b12d152d2610748985fc@dev.tdt.de> <CAJht_EO=G94_xoCupr_7Tt_-kjYxZVfs2n4CTa14mXtu7oYMjg@mail.gmail.com>
 <c60fe64ff67e244bbe9971cfa08713db@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Xq+1XmdEWFdb62Dr7GHbaDhMaJ4G5daMpt8CI66K5lk=;
        b=I22hH9NmSBSbNKBE+0Yy/i/DVDsWDTnEXW+CkKJ+sDlIy4a7PDPLY5arHYdW3cI62K
         fNn6c9XJ59WxiIxL4UdfcCUkBpA0nzj+F/HBxYbwe79Jv4dOW2qxx5Pe2YoDbW9ezukl
         XkfJvMWZ8jNnb1rFfhdMP5K+3T1YK7JlNvQfSAbKIHDZTgvWPP21a+rWLw7SlygnlkgS
         euuaAlqhkNFcrwsTxlcFR2heEV7CIYVipUq8C+CPcicDswHJuTcaTiYIJhSody10yOu/
         /n6/a+BLVzOdxQ327Dr4t34lgAMPn+Cl/Fnzf6Q046IJtB654HNTyA/yPUUWfyB6b1Yd
         lHIw==
In-Reply-To: <c60fe64ff67e244bbe9971cfa08713db@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Nov 18, 2020 at 12:49 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Ah, ok. Now I see what you mean.
> Yes, we should check the lapb->mode in lapb_connect_request().
...
> I also have a patch here that implements an "on demand" link feature,
> which we used for ISDN dialing connections.
> As ISDN is de facto dead, this is not relevant anymore. But if we want
> such kind of feature, I think we need to stay with the method to control
> L2 link state from L3.

I see. Hmm...

I guess for ISDN, the current code (before this patch series) is the
best. We only establish the connection when L3 has packets to send.

Can we do this? We let L2 handle all device-up / device-down /
carrier-up / carrier-down events. And when L3 has some packets to send
but it still finds the L2 link is not up, it will then instruct L2 to
connect.

This way we may be able to both keep the logic simple and still keep
L3 compatible with ISDN.
