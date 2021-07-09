From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 6/6] net: wireguard: rename 'mod_init' & 'mod_exit'
 functions to be module-specific
Date: Fri, 9 Jul 2021 12:21:39 +0200
Message-ID: <CAHmME9rUJndFC-6KAxGL3w6Ka4WgyP_m5DS+1_vuHdQowonSOg@mail.gmail.com>
References: <20210709021747.32737-1-rdunlap@infradead.org> <20210709021747.32737-7-rdunlap@infradead.org>
Mime-Version: 1.0
Return-path: <linux-crypto-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1625826113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7dR0/VUJHKDLRMz9yU5Zdn5RWQOxI+Wc0vq05RWjQvE=;
        b=SvQ1Je064yhDKpHtC+rohJT39TVuxD85wqjML8PO3gxEcEu4/YVvk3iaUzENwcWcM5wqDH
        thvwKk3BjAVh7F3FOpUHcQhDhnWXtVUhiWZl/AB9a/0FYWH9OU9sN96yOgwmH9E5N6HbE3
        GTlcQVkPe26jsPPQ4IgmztdiwLeX+Qk=
In-Reply-To: <20210709021747.32737-7-rdunlap@infradead.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andres Salomon <dilinger@queued.net>, linux-geode@lists.infradead.org, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Christian Gromm <christian.gromm@microchip.com>, Krzysztof Halasa <khc@pm.waw.pl>, Netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org, WireGuard mailing list <wireguard@lists.zx2c4.com>

Hi Randy,

The commit subject line should be:

wireguard: main: rename 'mod_init' & 'mod_exit' functions to be module-specific

And:

On Fri, Jul 9, 2021 at 4:17 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> -static int __init mod_init(void)
> +static int __init wireguard_init(void)

wg_mod_init

> -static void __exit mod_exit(void)
> +static void __exit wireguard_exit(void)

wg_mod_exit

Thanks,
Jason
