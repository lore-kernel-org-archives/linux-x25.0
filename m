From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
Date: Sun, 9 Aug 2020 10:11:39 -0700
Message-ID: <CAJht_EM9q9u34LMAeYsYe5voZ54s3Z7OzxtvSomcF9a9wRvuCQ@mail.gmail.com>
References: <20200808175251.582781-1-xie.he.0141@gmail.com> <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mgOLBezWt79zIQjvAdBmYqr2eyqE9EwffvrtOtN04PU=;
        b=oBLCXUjlfrw4Fre6KD2wOrQhSVwagOpit8lWuYFs+toIXiUArJWCy86Re6GKyRN6BY
         97PeSSdm39pOiofcF7ufAjWYkjLXxjTARF5pAjRPRE3dyo5ZUwOu4W5zt7nBazPcHJj+
         JVkVGvtc5r0Rn+qCg6pONe+gjA0XH/gKEoOWqmjjE4HoJ+V3HaZKe4shnUSEQpnDpAKz
         U/v8rZ/Vz7nLgX3lsvyFhGQVgd6x/Hzw38qjqYj8kF4jhHsaPlZqT6rvPTAFu2yTOqH4
         fZK5HD9vFCbrBw2nczI9YgZbbtHtzVfpwrs2NNGDRHsbEBKoQKyRAgs8zZbZk8fYa68O
         TqiQ==
In-Reply-To: <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Sun, Aug 9, 2020 at 1:48 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Does this solve an actual observed bug?
>
> In many ways lapbeth is similar to tunnel devices. This is not common.

Thank you for your comment!

This doesn't solve a bug observed by me. But I think this should be
necessary considering the logic of the code.

Using "grep", I found that there were indeed Ethernet drivers that set
needed_tailroom. I found it was set in these files:
    drivers/net/ethernet/sun/sunvnet.c
    drivers/net/ethernet/sun/ldmvsw.c
Setting needed_tailroom may be necessary for this driver to run those
Ethernet devices.
