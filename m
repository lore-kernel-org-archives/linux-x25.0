From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
Date: Sun, 9 Aug 2020 10:48:07 +0200
Message-ID: <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com>
References: <20200808175251.582781-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GKI56+bDaX14CCr0kM6K85vrY7pTEhw0ASbGvetXsUY=;
        b=PvIFeFiDyWS1xZmw3w/29x+ATXIEqrfaERQ5aQWzR1x+gOyXFF4sJIJVlcjSljlZde
         TPAKbtYU83qY38G65Xda9O3mLX3FJT4pL5VLgi1TiPcSAUOhwHcL2cv3Pv2LEKtHhj7c
         3vLOBdUjtzzXf7tu/Q+vkDVU4uIcHTT35/2v+xB/FwJqqJPhMK30zAlYOvS/BlNH84Zr
         Qm/dQeVmm6H+1U3qbm7x2KMcyETgSpgr9rxRurDfc4fLjHZ7K9okCeNAEylzNwRET+Dq
         deaEeF6M/eX73zVSUg+7iTfbhM1tUkEnzVNsTY5Jclv0ye0YvFuRr3k1rLLWmKw2I433
         sPNw==
In-Reply-To: <20200808175251.582781-1-xie.he.0141@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin Schiller <ms@dev.tdt.de>

On Sat, Aug 8, 2020 at 7:53 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> The underlying Ethernet device may request necessary tailroom to be
> allocated by setting needed_tailroom. This driver should also set
> needed_tailroom to request the tailroom needed by the underlying
> Ethernet device to be allocated.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  drivers/net/wan/lapbether.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> index 1ea15f2123ed..cc297ea9c6ec 100644
> --- a/drivers/net/wan/lapbether.c
> +++ b/drivers/net/wan/lapbether.c
> @@ -340,6 +340,7 @@ static int lapbeth_new_device(struct net_device *dev)
>          */
>         ndev->needed_headroom = -1 + 3 + 2 + dev->hard_header_len
>                                            + dev->needed_headroom;
> +       ndev->needed_tailroom = dev->needed_tailroom;

Does this solve an actual observed bug?

In many ways lapbeth is similar to tunnel devices. This is not common.
