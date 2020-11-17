From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v2 4/6] net/x25: support NETDEV_CHANGE notifier
Date: Tue, 17 Nov 2020 03:41:24 -0800
Message-ID: <CAJht_ENE5fGr-rgOd-5Tk_g5RJibaWBn_ey5Avo-2R2opMGcDA@mail.gmail.com>
References: <20201116135522.21791-1-ms@dev.tdt.de> <20201116135522.21791-5-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yK3guKziVoImJRhpkshknGVxmHiW95ym33CYvh9hWIg=;
        b=iAHVYAOVqqisGtYQ1zLY0u5RV/IpSgDvGtHY1zSzhYT9KvPCYxuNdAunM+7uEjoFom
         lBX2sOiIKtsoUpPB0B7BV76aN70jI5fFWwzYRD31JMCXP4VbREULcfWlywAHWQd3ZL5w
         2mJbP8rHhnFr6kvAEdxqyi28oM+a0wnOhDymiLhVM09ENww3vx+wgfreo0t0V/8aQqbZ
         TaK4/x77n4c6aR8488P0z2ZbTTjvDD6Q2Ir+2k930YktFjt5W0yMrZ2C2SKq93/s7B8V
         gy0nLp6SWcVavACgJo+o3lvZpvlWKPSrPkkWAhLb5IMCzWmc29cBHeWcKf5xe1T825QT
         wRhw==
In-Reply-To: <20201116135522.21791-5-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 16, 2020 at 6:00 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> This makes it possible to handle carrier lost and detection.
> In case of carrier lost, we shutdown layer 3 and flush all sessions.
>
> @@ -275,6 +275,19 @@ static int x25_device_event(struct notifier_block *this, unsigned long event,
>                                  dev->name);
>                         x25_link_device_remove(dev);
>                         break;
> +               case NETDEV_CHANGE:
> +                       pr_debug("X.25: got event NETDEV_CHANGE for device: %s\n",
> +                                dev->name);
> +                       if (!netif_carrier_ok(dev)) {
> +                               pr_debug("X.25: Carrier lost -> set link state down: %s\n",
> +                                        dev->name);
> +                               nb = x25_get_neigh(dev);
> +                               if (nb) {
> +                                       x25_link_terminated(nb);
> +                                       x25_neigh_put(nb);
> +                               }
> +                       }
> +                       break;
>                 }
>         }

I think L2 will notify L3 if the L2 connection is terminated. Is this
patch necessary?
