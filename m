From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/x25_asy: Fix to make it work
Date: Wed, 8 Jul 2020 12:04:33 -0700
Message-ID: <CAJht_EOqgWh0dShG258C3uoYdQga+EUae34tvL9HhqpztAv1PQ@mail.gmail.com>
References: <20200708043754.46554-1-xie.he.0141@gmail.com> <20200708.101321.1049330296069021543.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tMh+N4AelkPm2oxZYynrDFABsoJu3LSOWaAFcX31Lf8=;
        b=bbuDMatH/BcR0zzFHOI3DZgIsYWFm64I++XTTIGrVi2+xdx+pMM7n6CWrcgGn5kk0i
         9e5MqVzqDEY/IA7Im1fKWhdJiRKtfl7Qq8p5IDvRHdTqK0Z2wt64Ry9T98MygfZUlqwp
         Qvzg4nK1jLVyn/mGtdIZOW7XkKepbBTEo4dIP+8SdeLhOXJ42t3sgyvKMGgcHOZhayvd
         TtC6m0u4TIQKMnkDUVOaL52hHtEZJZS1kolgpG5EmwQ1uRr136gJG6UcRsArjIbsZ7qa
         7vwxbXzTd84lNdeCAo6LroBh/EkJBk7GEO4HDF3NcDv1EF6g5Wm0JiudEmXiXL2s+98+
         fJiw==
In-Reply-To: <20200708.101321.1049330296069021543.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Shannon Nelson <snelson@pensando.io>, Martin Habets <mhabets@solarflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, Jul 8, 2020 at 10:13 AM -0700
> Something's not right, because I find it hard to believe this has been
> so fundamentally broken for such a long period of time.
>
> Maybe the drivers all handle things differently, and whilst your change
> might fix some drivers, it will break others.
>
> I'm not applying this until this situation is better understood.

Yes, it was hard for me to believe, too.

At first when I tried this driver, it was silently not able to establish
LAPB connections, I found that it was because it was ignoring
2-byte frames. I changed it to make 2-byte frames pass. Then I
encountered kernel panic. I don't know how to solve it, so I looked
at the way "lapbether" does things and changed this driver according
to the "lapbether" driver. And it worked.

The "lapbether" driver and this driver both use the "lapb" module to
implement the LAPB protocol, so they should implement LAPB-related
code in the same way.

This patch only changes this driver and does not affect other drivers.

I don't know how I can better explain this situation. Please tell me
anything I can do to help. Thanks!
