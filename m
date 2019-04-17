From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v3 1/3] net: rework SIOCGSTAMP ioctl handling
Date: Wed, 17 Apr 2019 17:56:43 -0400
Message-ID: <CAF=yD-KkUveFFj_j721kML0rMJF=uDcVQv+RQO4N6xjorHCtZg@mail.gmail.com>
References: <20190417205404.1877560-1-arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NBpTCXhk2LilYeHlTZ3sbhr04hptB1DMCc+g6ITMMFk=;
        b=WvOAB7yp0DjrGk7XtpK+Eg3nRcid8g/E3xiHzSOhiM3mRCvK5eRRFosPpRH57vE5ji
         xedtLDefaNvxYJRu+PV5moJVt7WLEpOHF9E9vxaf7g1toqmcXeEtYX3r7/G2Yr6hCsTJ
         mWAamB+V/TGRgGbianHw5tY7hUCokegEEKhqoHV3mRrnpMkvSsAfvt+V3KBu1ifwi9vg
         OJdHGZ+S2bHs5DcmPAR3keOObdHwo3aQkZDkPkvGVhxBYMjB0rwyWsQ2JL1+6bzQlln4
         o8k1dfesvVNghv4Oi8jEr85OfwnGQuT2UuTECuG0TIgKnYY37c+Ml8XQ8Jty0AKBfvoS
         oxPA==
In-Reply-To: <20190417205404.1877560-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Network Development <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, y2038 Mailman List <y2038@lists.linaro.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, Neil Horman <nhorman@tuxdriver.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org, Bluez mailing list <linux-bluetooth@vger.kernel.org>, linux-can@vger.kernel.org, dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org

On Wed, Apr 17, 2019 at 4:54 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> socket protocol handlers, and all of those end up calling the same
> sock_get_timestamp()/sock_get_timestampns() helper functions, which
> results in a lot of duplicate code.
>
> With the introduction of 64-bit time_t on 32-bit architectures, this
> gets worse, as we then need four different ioctl commands in each
> socket protocol implementation.
>
> To simplify that, let's add a new .gettstamp() operation in
> struct proto_ops, and move ioctl implementation into the common
> sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> through.
>
> We can reuse the sock_get_timestamp() implementation, but generalize
> it so it can deal with both native and compat mode, as well as
> timeval and timespec structures.
>
> Acked-by: Stefan Schmidt <stefan@datenfreihafen.org>
> Acked-by: Neil Horman <nhorman@tuxdriver.com>
> Acked-by: Marc Kleine-Budde <mkl@pengutronix.de>
> Link: https://lore.kernel.org/lkml/CAK8P3a038aDQQotzua_QtKGhq8O9n+rdiz2=WDCp82ys8eUT+A@mail.gmail.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Willem de Bruijn <willemb@google.com>
