From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: Re: [PATCH 4/4] [RFC] staging/net: move AF_X25 into drivers/staging
Date: Wed, 11 Dec 2019 08:10:34 +0100
Message-ID: <m3d0cvjq1h.fsf@t19.piap.pl>
References: <20191209151256.2497534-1-arnd@arndb.de>
        <20191209151256.2497534-4-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl 8B26144395F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1576048235; bh=NzjEtJBbGMnp7Oker2Ku1W7VereultBIRwFu42VbqH0=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ddfu2lN5c/GDpBgFP7CSUj0b136P+lVeJ7gwAXrjiOc/imCh/fKKl06s4jiNWd3W6
         ghZTZ3rWpbxy0U0jx8x6F4oyrkOb+j4jZNenBXXxV0t87/bTxylOTmAAjyPY2pKW0j
         p+4ER4qIEmPNUzF+DwzgjA2TKIAZAhR6S+H4y0LA=
In-Reply-To: <20191209151256.2497534-4-arnd@arndb.de> (Arnd Bergmann's message
        of "Mon, 9 Dec 2019 16:12:56 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="macroman"
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>, Andrew Hendry <andrew.hendry@gmail.com>, linux-x25@vger.kernel.org, Kevin Curtis <kevin.curtis@farsite.com>, "R.J.Dunlop" <bob.dunlop@farsite.com>, Zhao Qiang <qiang.zhao@nxp.com>, syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com, syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com

Arnd,

Arnd Bergmann <arnd@arndb.de> writes:

> - Most other supported HDLC hardware that we supoprt is for the ISA or
>   PCI buses.

I would be surprised if there is anybody left with ISA sync serial
stuff, but the PCI hardware still has some users - these machines don't
need to be upgraded yearly. Most people have migrated away, though.
--=20

Krzysztof Halasa

=C5=81UKASIEWICZ Research Network
Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
