From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH 6/6 v2] wireguard: main: rename 'mod_init' & 'mod_exit'
 functions to be module-specific
Date: Sun, 8 Aug 2021 22:22:42 +0200
Message-ID: <CAHmME9pqLEmNKu1gZDsvTbukzqv8O2kCp6ndQROTu9RzcPnrVA@mail.gmail.com>
References: <20210711223148.5250-1-rdunlap@infradead.org> <20210711223148.5250-7-rdunlap@infradead.org>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1628454176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hwMXHfWfY1HwtKLFV1C9p+LNgMMZXcsO9o0YDBO5lpY=;
        b=A0sw1zzmJnofdfzUawTVUJ/IciosRPm+uLSnUwvRtxnt3LLTFNSDU3h+vGfe5Ndi/FowLf
        LjS9JXZosImxK0b2413SmCNhwokBiJNYwudSG+/oplPjozb+FLIT20ujRPfGod4q0ap87N
        uNReM6HlnDnqYV9jeL/fJoBYqMuXSu4=
In-Reply-To: <20210711223148.5250-7-rdunlap@infradead.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andres Salomon <dilinger@queued.net>, linux-geode@lists.infradead.org, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Christian Gromm <christian.gromm@microchip.com>, Krzysztof Halasa <khc@pm.waw.pl>, Netdev <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org, WireGuard mailing list <wireguard@lists.zx2c4.com>

Hi Randy,

Thanks, I've applied this to the wireguard stable tree, and it'll be
sent off to netdev during the next push there.

Regards,
Jason
