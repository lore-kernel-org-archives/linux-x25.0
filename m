From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Fri, 20 Nov 2020 15:11:08 -0800
Message-ID: <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
References: <20201120054036.15199-1-ms@dev.tdt.de> <20201120054036.15199-3-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWPMH4F8zpYKMQ+iVwWJvlmgxu/1LnPnr3HnFQg/Y88=;
        b=OiOHYUgLaPXz88CxKOhR4d3ZFqH0WOaQDpA+KqZxYvwRPo+uT1j6TXzvSd1Wk1VMVd
         huzg4SXZYqZnkcGlSFveMgn5IcRIktiabykZLdux4TCJtNsAtSk0F/fH/eeJ4oQxco1t
         Ussp3YptQZfqMjiLQ3hYdU0YPBKiZsGxnhyfE84XT1WO20knxUt48hhrCNu0MeoDUPrb
         8h5I/RvyrczBjFazMLoZ2d+CQ4HmM+87kGUkTUL86ogd0heqRPwue4uSF2gG5sTeg2nY
         xxr5G2svkZHRS5rWea3Wzq5yQNVPUc/7/7UlyS43zkCWDGCsLpkQuc58N+ohaQGlHVmn
         +z6Q==
In-Reply-To: <20201120054036.15199-3-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Should we also handle the NETDEV_UP event here? In previous versions
of this patch series you seemed to want to establish the L2 connection
on device-up. But in this patch, you didn't handle NETDEV_UP.

Maybe on device-up, we need to check if the carrier is up, and if it
is, we do the same thing as we do on carrier-up.
