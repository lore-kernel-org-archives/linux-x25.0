From: =?utf-8?Q?Krzysztof_Ha=C5=82asa?= <khalasa@piap.pl>
Subject: Re: [PATCH 5/6 v2] net: hdlc: rename 'mod_init' & 'mod_exit'
 functions to be module-specific
Date: Mon, 19 Jul 2021 07:45:21 +0200
Message-ID: <m3y2a2zwjy.fsf@t19.piap.pl>
References: <20210711223148.5250-1-rdunlap@infradead.org>
        <20210711223148.5250-6-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 795F4C3F2A51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1626673524; bh=xH3yU1unl5seSQwdZbQWwx5A9ON1+nGOmgWR8IFn5r8=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=L7U05iMv3oK92oCUuG5CTlxppqcc0E6eKg9JErEbxAKkTlJL107YThmaj1R9//agf
         ujEHiof3dy3tIle/ZvOryphYwiEfqEPiMWKwlENA/Tzv3jq7JttbBCzB0lDDauFBMk
         lA27aWd7d+osdxmPHbr2zUAKGu54dYjmQaG1nnxk=
Sender: khalasa@piap.pl
In-Reply-To: <20210711223148.5250-6-rdunlap@infradead.org> (Randy Dunlap's
        message of "Sun, 11 Jul 2021 15:31:47 -0700")
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andres Salomon <dilinger@queued.net>, linux-geode@lists.infradead.org, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, Christian Gromm <christian.gromm@microchip.com>, Krzysztof Halasa <khc@pm.waw.pl>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org, wireguard@lists.zx2c4.com

Hi Randy,

Randy Dunlap <rdunlap@infradead.org> writes:

> Rename module_init & module_exit functions that are named
> "mod_init" and "mod_exit" so that they are unique in both the
> System.map file and in initcall_debug output instead of showing
> up as almost anonymous "mod_init".

>  drivers/net/wan/hdlc_cisco.c   |    8 ++++----
>  drivers/net/wan/hdlc_fr.c      |    8 ++++----
>  drivers/net/wan/hdlc_ppp.c     |    8 ++++----
>  drivers/net/wan/hdlc_raw.c     |    8 ++++----
>  drivers/net/wan/hdlc_raw_eth.c |    8 ++++----
>  drivers/net/wan/hdlc_x25.c     |    8 ++++----

Sorry for the delay.

Acked-by: Krzysztof Halasa <khalasa@piap.pl>
--=20
Krzysztof Ha=C5=82asa

Sie=C4=87 Badawcza =C5=81ukasiewicz
Przemys=C5=82owy Instytut Automatyki i Pomiar=C3=B3w PIAP
Al. Jerozolimskie 202, 02-486 Warszawa
