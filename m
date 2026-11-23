Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.37.255.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795458449;
	b=adDRDnh+cMlCOoUjh7zvgks5p8KOCmauOkWBT9NWt105DnPEV4eIdFdmW1efMhS2nZZ/
	 Kd3L9TfRUNRaaNZfEI8dwuluT5L+4rWYn27aIJPu44hVzWwGodb5mcdeEduwiEWi6npgq
	 QSRVgG2aYqnK6g16sOltIvz7cVM5GuGJIdIrP9j4xjGL5zWBC2dGQKaiEPk6Hl9yWxWjO
	 HUtvLfwRpSppmMCb+IQjElH5bj4QACI2TY14D+aZLWW8BfTGjDv7a8Hz6tVAzoSnBWLWD
	 uHMJ7hsKbGRC4UOhsQLwBRiDX39UZewhPccScyqeK+M9rAga8a02nRghTYON+wBhi5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795458449;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Date:From:To:Cc:Subject:
	 Organization:In-Reply-To:References:Message-ID:X-Sender:User-Agent:
	 X-Spam-Status:X-Spam-Checker-Version:Content-Transfer-Encoding:
	 X-purgate-type:X-purgate-ID:X-purgate;
	bh=KYU9FnKKEwUpONcl8aqvXDzyTNAbdpw9nzDao/RcizU=;
	b=AHOZZ7U6MmlKF+igd8TNTV1sCQ3398bMkWHNyItTQ1YsD3yTebvgvuqDNRHmK29jvICi
	 lZjGfj8YAcyo3ZHMRfgYKMVOvXhYjNCbskoBKWJgK3KWUTyte1rSugIZSPEXuN9JkdN4e
	 c4gsxq8hTfeERq2f8nrQGST4bBMwzBv1CdM1zOeBGe9MMX1x6qoVOKiN4JqzqNye4rOOY
	 lMsRBlPQlzi7y7nwxIvnnYI4Xw+lz+mq8ZdPsGnpRY/7YubeyfdygrLmfnoPIEiDAKnRC
	 E30d9WgVs7N8w4R9Agz4S+yMSYe4f9i8rZg64trx5XAm8A75Yie85t2MdZ8YiHXdiKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=ntK9UZT0;
	arc=none smtp.remote-ip=194.37.255.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDFC606A31A;
	Mon, 23 Nov 2026 18:27:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FDFC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=ntK9UZT0
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68018334f9=ms@dev.tdt.de>)
	id 1xVYl8-00ARxz-Mf; Mon, 23 Nov 2026 19:27:22 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVYl7-00HKPk-T1; Mon, 23 Nov 2026 19:27:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795458441;
	bh=KYU9FnKKEwUpONcl8aqvXDzyTNAbdpw9nzDao/RcizU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ntK9UZT0e98jDxbu56SLpejGePiq+hmGziOaymKRMoUK/HB7oR80tK/gRGMidMXTf
	 wXFqcxs22JxYEv+FEty+9/PZzuO2UxXCptKH9PhSzFoJgfeSo1fHeSA5ffx9Q41DJN
	 36sOmm5rUHCapPaAEHrmR5phB5szfnhponty8S4uA1pLdnP4o87pIxp7Tp2M+JDMDY
	 t8/5mKUL4Q+8Te9FXvvp9PnVeWWkUjdDgS8IUmPTZnVsd2G14TtqRL09HkdBhUCsZG
	 EFjZjgsoEn+RSej1OOtM1EhismCre9gTN5TqG/ouUTwi4wfljI7TFMp5xYyaTfjHl7
	 vGEab63pl61mg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 2980B240041;
	Mon, 23 Nov 2026 19:27:21 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 21DAA240036;
	Mon, 23 Nov 2026 19:27:21 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id D344A2AE6F;
	Mon, 23 Nov 2026 19:27:20 +0100 (CET)
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Mon, 23 Nov 2026 19:27:20 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: benquike@gmail.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wan: lapbether: validate frame length and headroom
 in lapbeth_rcv() and xmit
Organization: TDT AG
In-Reply-To: <178994368506.2160803.16241878291781749602@kernel.org>
References: <20260919223433.3882618-1-benquike@gmail.com>
 <178994368506.2160803.16241878291781749602@kernel.org>
Message-ID: <c16e43680ec701ef94f3f40499fc345a@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-type: clean
X-purgate-ID: 151534::1795458442-79D55B36-477689C0/0/0
X-purgate: clean

On Mon, 21 Sep 2026 00:34:45 +0200, netdev-bot wrote:
> - [High] The commit message describes two changes that are not present =
in
>   the diff.
> - [High] In lapbeth_rcv() (drivers/net/wan/lapbether.c:135-142) the wir=
e-
>   supplied 2-byte length `len =3D skb->data[0] + skb->data[1] * 256;` i=
s=E2=80=A6

I agree with the review. The useful part of the change is the switch
from skb_trim() to pskb_trim_rcsum(): skb_trim() warns and does not
trim at all if the received skb is nonlinear. That is what the commit
message should describe.

Hui, for a v2 for net, as a new thread with [PATCH net v2] in the
subject, please:

- describe the actual change and its effect;
- drop frames whose length field is larger than the received data,
  as the subject promises;
- count skb->len after the trim instead of the length field;
- drop the Assisted-by: line, as for the lapb_decode() patch.

Charging the receive counters to the Ethernet device instead of the
LAPB device is a separate issue and can be a separate patch.

If you don't have time for these two patches, let me know and I'll
take them over.
