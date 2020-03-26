From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Subject: Re: [PATCH 1/2] wan/hdlc_x25: make lapb params configurable
Date: Thu, 26 Mar 2020 07:08:34 +0100
Message-ID: <m3v9mr8x7h.fsf@t19.piap.pl>
References: <20200113124551.2570-1-ms@dev.tdt.de>
        <20200113055316.4e811276@cakuba>
        <83f60f76a0cf602c73361ccdb34cc640@dev.tdt.de>
        <20200114045149.4e97f0ac@cakuba>
        <3b439730f93e29c9e823126b74c2fbd3@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 ni.piap.pl D5531441EC3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=piap.pl; s=mail;
        t=1585202916; bh=clbKiLn6qUATsS6QO/fUtOXJXjf33KFTkCDMmyg02uo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=iMNGF6WY331i4QFJdjveDasWP1Hd62KJpkcDJOlPrBkYPAQrC+vnXjbe133okFxbp
         H2MxtXbpUrITB5OuZLtd+QNjKlR+T9eiTVHH1zHbMoZeQEpHekNtG8lfmhicQaLYv3
         OK76HTmXZ7SePtnbguhSuGkUa0KEdFdUIxEno7E8=
In-Reply-To: <3b439730f93e29c9e823126b74c2fbd3@dev.tdt.de> (Martin Schiller's
        message of "Tue, 14 Jan 2020 14:33:51 +0100")
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="macroman"
To: Martin Schiller <ms@dev.tdt.de>
Cc: Jakub Kicinski <kubakici@wp.pl>, khc@pm.waw.pl, davem@davemloft.net, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I overlooked this mail, sorry.

Martin Schiller <ms@dev.tdt.de> writes:

> sethdlc validates the GENERIC_HDLC_VERSION at compile time.
>
> https://mirrors.edge.kernel.org/pub/linux/utils/net/hdlc/
>
> Another question:
> Where do I have to send my patch for sethdlc to?

I guess you have to put your own version somewhere. I don't have access
to hdlc directory at kernel.org anymore, this stuff (sync serial with
HDLC) is no longer in use around here.
--=20
Krzysztof Halasa

=C5=81UKASIEWICZ Research Network
Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
