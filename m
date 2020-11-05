From: Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH net-next] net: x25_asy: Delete the x25_asy driver
Date: Thu, 5 Nov 2020 16:06:54 +0100
Message-ID: <CAK8P3a2bk9ZpoEvmhDpSv8ByyO-LevmF-W4Or_6RPRtV6gTQ1w@mail.gmail.com>
References: <20201105073434.429307-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604588832;
        bh=iGxDjGpgZgvh1at2/59sSPdVCtzZKM9jCmS50+iMi3E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RL8Yxi3b4nBNd50oejfwXK6xegX1iflPA7ERuLp1Ndd/RGOer8n4zqguIpdDv7REL
         0D3kedysHHVG0MONILeThjZnfZ70toRQGAo7rzWFijqay/AGv/7vkSSoSxNO8E855z
         Ze9Tjix7M53/tgPRrifDZ7YcBCnX0e9ZHhiU88x4=
In-Reply-To: <20201105073434.429307-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Martin Schiller <ms@dev.tdt.de>, Andrew Hendry <andrew.hendry@gmail.com>, linux-x25@vger.kernel.org

On Thu, Nov 5, 2020 at 8:34 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> This driver transports LAPB (X.25 link layer) frames over TTY links.
>
> I can safely say that this driver has no actual user because it was
> not working at all until:
> commit 8fdcabeac398 ("drivers/net/wan/x25_asy: Fix to make it work")
>
> The code in its current state still has problems:
>
> 1.
> The uses of "struct x25_asy" in x25_asy_unesc (when receiving) and in
> x25_asy_write_wakeup (when sending) are not protected by locks against
> x25_asy_change_mtu's changing of the transmitting/receiving buffers.
> Also, all "netif_running" checks in this driver are not protected by
> locks against the ndo_stop function.
>
> 2.
> The driver stops all TTY read/write when the netif is down.
> I think this is not right because this may cause the last outgoing frame
> before the netif goes down to be incompletely transmitted, and the first
> incoming frame after the netif goes up to be incompletely received.
>
> And there may also be other problems.
>
> I was planning to fix these problems but after recent discussions about
> deleting other old networking code, I think we may just delete this
> driver, too.
>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  Documentation/process/magic-number.rst        |   1 -
>  .../it_IT/process/magic-number.rst            |   1 -
>  .../zh_CN/process/magic-number.rst            |   1 -
>  arch/mips/configs/gpr_defconfig               |   1 -
>  arch/mips/configs/mtx1_defconfig              |   1 -
>  drivers/net/wan/Kconfig                       |  15 -
>  drivers/net/wan/Makefile                      |   1 -
>  drivers/net/wan/x25_asy.c                     | 836 ------------------
>  drivers/net/wan/x25_asy.h                     |  46 -
>  9 files changed, 903 deletions(-)
>  delete mode 100644 drivers/net/wan/x25_asy.c
>  delete mode 100644 drivers/net/wan/x25_asy.h

Adding Martin Schiller and Andrew Hendry, plus the linux-x25 mailing
list to Cc. When I last looked at the wan drivers, I think I concluded
that this should still be kept around, but I do not remember why.
OTOH if it was broken for a long time, that is a clear indication that
it was in fact unused.

Since you did the bugfix mentioned above, do you have an idea
when it could have last worked? I see it was originally merged in
linux-2.3.21, and Stephen Hemminger did a cleanup for
linux-2.6.0-rc3 that he apparently tested but also said "Not sure
if anyone ever uses this.".

Hopefully Martin or Andrew can provide a definite Ack or Nack on this.

      Arnd
