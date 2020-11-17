From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v2 3/6] net/x25: replace x25_kill_by_device with x25_kill_by_neigh
Date: Tue, 17 Nov 2020 11:50:23 -0800
Message-ID: <CAJht_EN0fhD08+wH5kSBWvciHU7uM7iKJu_UcEXwZBKssuqNVw@mail.gmail.com>
References: <20201116135522.21791-1-ms@dev.tdt.de> <20201116135522.21791-4-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDAEmhNdku9VAWF7fGVJyr3eF+5Nl9MfyP1c5wCk+Qg=;
        b=Lm0ry1bUCaP1i76eXxbXB695bO5Z9mRG8713U6+3u15LHetOu1oB3JAwSaD9bZtvcC
         /wyLo0KKvWQTKGowO5utZS58GfnQC08x5pAJcm/ehyy5v3dciOXl6wptSQuqLxxzUmb3
         8Tx/wikGTWiMWXarqZWrxvgIKWKM25YNwcQ370iQQEwRBe8r2EHpWoUKAo6lqYQM4XDB
         hZPpPymDK7V3Uy9ON8H/9oODLOFcf98mfcG0bFSq4RKzXwiX35gQuGJH7/wEZCqDNtJd
         Qj6QNC22AbtezIceA5870sZ3qKZlgw5FNFZ0LUM5GlRMb3QDQeRzpc4tboYr9s10VifI
         Gvsg==
In-Reply-To: <20201116135522.21791-4-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 16, 2020 at 6:00 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Remove unnecessary function x25_kill_by_device.

> -/*
> - *     Kill all bound sockets on a dropped device.
> - */
> -static void x25_kill_by_device(struct net_device *dev)
> -{
> -       struct sock *s;
> -
> -       write_lock_bh(&x25_list_lock);
> -
> -       sk_for_each(s, &x25_list)
> -               if (x25_sk(s)->neighbour && x25_sk(s)->neighbour->dev == dev)
> -                       x25_disconnect(s, ENETUNREACH, 0, 0);
> -
> -       write_unlock_bh(&x25_list_lock);
> -}
> -
>  /*
>   *     Handle device status changes.
>   */
> @@ -273,7 +257,11 @@ static int x25_device_event(struct notifier_block *this, unsigned long event,
>                 case NETDEV_DOWN:
>                         pr_debug("X.25: got event NETDEV_DOWN for device: %s\n",
>                                  dev->name);
> -                       x25_kill_by_device(dev);
> +                       nb = x25_get_neigh(dev);
> +                       if (nb) {
> +                               x25_kill_by_neigh(nb);
> +                               x25_neigh_put(nb);
> +                       }
>                         x25_route_device_down(dev);
>                         x25_link_device_down(dev);
>                         break;

This patch might not be entirely necessary. x25_kill_by_neigh and
x25_kill_by_device are just two helper functions. One function takes
nb as the argument and the other one takes dev as the argument. But
they do almost the same things. It doesn't harm to keep both. In C++
we often have different functions with the same name doing almost the
same things.

The original code also seems to be a little more efficient than the new code.
