Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795540255;
	b=qeW8C1ezGqFkVb/qrRUXxIhaYlGava3RXFt7C5HzZn/H5/Uw/VskwhCdaVzQZCmUFIPc
	 6JDAXlDnXEnzvEu8Sr9XObNGkkDz6MfjNVu7PgNaiO1BWgvnKCqt/DXw1Uqw5ULS208eO
	 aaH43Rx0wWIo18IfpSzzGw3rJ5F+TXROWpG8IN6o+4stdjV1q1wjlvjIe8gPZ+tEE71u8
	 /FJIGLhUqrn4yMOhlXarR++8t+rece/KwO/ot5pHw0MljKuOw0GxPh85wC99hbb3yWYty
	 Z/ZHNCs70SVPpOC5st2XVeRrboHh1OMUg5pviMSCjTbhbn9EnLG6T/P2OLcJCOioGPw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540255;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=YD659iZbhB9OAfnpI+8tlGtmEiCdl2kb0qCNC7Yp8ls=;
	b=KSloOvLWteCfqaQ5mL+IeqvRqv+CaWOObXEh540hcsCzDypEh63GWhzyRuY31FUWZ/Ec
	 vXGIW4ySmT10EM+n85xZ1s2j1ZdyrN5laWNaDwNgwcEBa6dVhaRbSnFU8Pf/DaZ5HkBfH
	 y9YV611DhwLX013G00o/TS6DiNN/AGDz2fthVyZhYDydWhwVZz2z4HDD8wwFhyWZPKjh1
	 NjbaRl4lK1KFUL9EfAzXH6eci+kuaqx0NizWzCUhnhYxnDxqjq2SvtgnsAQ89JhBCNMh5
	 c3jvWloag0kgziD4BoljR+gPBDvpno6E2ksoQfCApcjiOM9heNV1kq74Nmp4Y4daaFQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XGZP1B9e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59EF606E171
	for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 17:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A59EF606E171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=XGZP1B9e
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdb75699c7cso1837970a12.2
        for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 09:10:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795540254; cv=none;
        d=google.com; s=arc-20260327;
        b=OW0Ie8qKee6D7tSPJ1iGYyCAvn91TR3TVm7adm2zAWp/143RjO9YQhEPmUawEIhvVi
         AtbXxP5brvn5QO8s6Z6oxJtZEn/OGCX87upx/PCauu6d4TnDnO5Rzoap2ZdhyJLSJSdQ
         kJZpjUirPzYPK/vjFpiGhUGbgRfunA8AJs01kjBE9Alj5pkSs2xx+uceog4ZpoXODLzP
         Lz2oWOffFL6EWX/RVtRGq7c9IEGpO7X64hfJejrGGl9KrR2t8oWFS2Bss4BoGLNFK/Qn
         vZhsax6z5Q3/NAa1xuvw/O62se2JsqEJ5y8Jw6y2iHwzgjK1PyQYaI6m+QTmnd29t5Jk
         Rwyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YD659iZbhB9OAfnpI+8tlGtmEiCdl2kb0qCNC7Yp8ls=;
        fh=h6WyALsMkL7zMk2+tiRNcwCyouei5qgrka2o+VKPtkY=;
        b=oPtxUIca+48nSU4dPHeO9N7Cd4v5qin7JhwxTghV+M/Ao5QzEooocexrwGZI8nMeQY
         2c1TRssGvK6PEZkwNMxTADRof8Ea1iN8ExEEvr9dWKqvYlmGzDa2dj/gGkFHsuAnOjCV
         40lj4AtYc78H7iIE6I6G4+5pkR6NnMcECPK8ntjf64hFPPxNxsEyTJ8x2VcFckQ1RRzu
         IZWH8bDNCQ+LDJJU5lcjqxaAHkAwTROc4Va6DUzZEhBqJO3tXpLQddrTIaM7nfoZRKH6
         H2lfDcpXKbIYe27zOfZVm3vrJ41tN9dXzH9yv7Ves/Q/OMlBDV22kwiLbAmzfo2TG2qk
         tDdw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795540254; x=1796145054; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YD659iZbhB9OAfnpI+8tlGtmEiCdl2kb0qCNC7Yp8ls=;
        b=XGZP1B9ebdkS8ePIk89ZuzQ1iCcHMbjCNYVdkW1Ikavfb7BfPm2cIFvIY/wrKRe72B
         sgtUsrG0y94ks58sAPWoPUZbaXTVzgig7BodyAWi6buZ0/NCmjX8E7Xfnq/JXDVG1uOG
         gZmhWdPv5Y4dY390ZwAB3s+ccss4ZSLw2/FwNYsfSGt8q4qrX7ZMBdKbJIYEOW8LtS7z
         Npr7U/WjzZAIMnhBXhD2TiYX3sPVYyxAi7D7cu4ltg1q/lUVnLTeEwduU2vlu+2Pccuk
         wuolouFPHsPqHmaPGaztToyeO/jvTkDu6eHV/VvaKPn2hibcKXvDCckQQZ30iZidEfwA
         ic6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540254; x=1796145054;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YD659iZbhB9OAfnpI+8tlGtmEiCdl2kb0qCNC7Yp8ls=;
        b=xTna8wJYltSheOm8LTb8ssrtL0eXtc5PkYf2bJQJrvHbdAI6K3nNzsqNVBXVeAiJb8
         W67qWRzaBQ/qQwfOs5EAjiqAXUKN+c0ewN1JDEU3cYRDXlqvC3gNBbtGiRlPg8NVJ/Wz
         VLU4qZawf3X9D1NBxYykpP3btupMWGluc76ykVS46KzzWHCYJEZnApBSpfSKzNV/1dZ8
         E/cfgoga8Vokr7QRR6wSuEczz9OBcfLy67eHUodbsJdWrZMkviF36u6/0wE9FqAvroEm
         lNEN/ep8DlSF2K7EoM/nJxjUth62TQrv17UDsZDePjTz+BnDNKIalOctGYL6TorrZ6XW
         IToQ==
X-Forwarded-Encrypted: i=1; AL+hErG63ONUL/HV1GFnDtv0YQ3I1/DHLMQrAc0n/Xej1upUFaKX2ov/Lyv4iM2WO78z/WQJuxCbhNamvzg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+jvkK3dwtfyLonWb3LhBxPDfVkhyC3hAa25jd8mHX1B8ifAfEX
	eA09puDIqbH96vjnz3NRvutlwfdVBIOBYowxkoRMTH6Vjbia/CWxsJgCq4pb69lFIKlH482CaQ7
	rh1O6Y2vxtIAbxV6MxutwpLE95HfE9qjhxmWLrhEN
X-Gm-Gg: AZFdTZe/2RhfIP+EfE/UWx40shf3siwiRbvbvhrJgDC0irEyg1AP+eZRoeJE6HFIqbT
	Y0B+10VN2EKQRheijwGXxm5L9ADAU/Zft+GWcGRdFDoXpaNH4LWNZi+PHis68dVFtCDcSyZoQir
	Jw7Ja6L4Lt070SaFScrhG4wP7iGC3SLpF8B4N63bGk3OxbomZTOecNMLJIaFN1oF5kRNrOgnaVB
	SoW3KGVBZAS4GlZw/2BN5+l9N/bxxGTkwrtxmZSEboKWrAmjn1zdwPGJZdvTRnOmtP+C8r+sGDA
	FR/QWTYITX/xJXBbDI2/Wz/1qIYiRy2/rWoUATBa8cq0K/FyKG7vPOq8JhLxxdDsZZotZ4aLi7N
	hnP35+IXShD4oJadphhscbs8woQOJAtXqXD/6baQih8FkKXi1ZiP7Ps+lvZEHejjAOivN
X-Received: by 2002:a17:90b:50:b0:3b0:9e2c:9b5f with SMTP id
 98e67ed59e1d1-3b41c7b6044mr14858398a91.2.1795540253878; Tue, 24 Nov 2026
 09:10:53 -0800 (PST)
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-x25-v1-1-4432d3892f8b@gmail.com> <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
In-Reply-To: <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Nov 2026 12:10:41 -0500
X-Gm-Features: Aa3M54pQl1423xvicd2W8eKUxg-iwZ3pBcyz1tFldZ8tVNfr4v2hJioLBtMFymY
Message-ID: <CAHC9VhTLg2FLNf3sLe3+A=q5Mo4gKs+gB7zi5sQT1jizsOPuNQ@mail.gmail.com>
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
To: Martin Schiller <ms@dev.tdt.de>
Cc: shyckless@gmail.com, davem@davemloft.net, kuba@kernel.org, 
	edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stevewong@hust.edu.cn, 
	kaixuan.li@ntu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 23, 2026 at 11:44=E2=80=AFAM Martin Schiller <ms@dev.tdt.de> wr=
ote:
>
> On Mon, 23 Nov 2026 01:31:20 +0100, Suyuan Wang wrote:
> > x25_make_new() creates the socket that accept() returns by copying
> > fields from the listening socket, but it never clones the listening
> > socket's LSM security state -- there is no security_sk_clone(osk, sk).
>
> Thanks!
>
> Acked-by: Martin Schiller <ms@dev.tdt.de>

My apologies, but I'm about as X.25 ignorant as possible, so a quick
question: the x25_make_new() function is called by
x25_rx_call_request(), which as far as I can tell is on pretty
analogous to an accept() operation, is that correct?

If that's the case (x25_rx_call_request() acting similar to accept()),
cloning the listening socket's LSM data makes sense, but if it's
something else we may want to leave the new socket as-is, labeled by
the process performing the operation.

--=20
paul-moore.com
