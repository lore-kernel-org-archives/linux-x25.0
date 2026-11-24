Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795541692;
	b=UzJFvzJ5LnAKczTz/UxWkifnG9IQ6gNovqkpmPOZl8VDO7xjwPn7VuP5EZ6aGJqrIu/c
	 HHr0g+F4vuO5jfTmwCYIOhtV+x4zETYXh1/8bXrs59KnEI19OwNe8i1FkX/SqGejyoGfZ
	 /GFuycEDG2nUTdZJqetu0lWBrW42dJD7H7Alaa1odPioZc81kxnViSGO6drz2YeEPdUjr
	 Kh7K8zEnCrljONOJ0YtqM65UPsjxjafMG+SkrW6+GkqSBqsmkuyOAekIja15Wabjt64Q6
	 hHNiz6AR4BIf4yb3Agh45SMqA6MRYANyhmtHEcSrxba8mgp+ADvt67+h4jgZ9+Qf2hw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795541692;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XBmnC24W8AXYN+2O9rvqWHkGjrVBXCobhK+i3wuM79I=;
	b=29ZFSVwWocmMDVp8lFLO5tz2tfF9zCWBDa9Xp/cCbbbymcR/9nIwidQXkIkRTiu4zV4R
	 Wc91mUE9uUCCkSZkbK7E5yM9OlAUKTvvLTm8srC+8mS4lmAsGHvtWo7w7GOOC4nqztA+N
	 xQtWHGTdkuDPBTctcA4F6RjgnypITp0kz8APf/TPTcyc78oXq/ivNzdp5ybSfIxvbvss9
	 3Oaiu7eD+xxdJtE9xs/+pNWz7xStqTE3JecbqRYD+4reoZlfeqm0ri2Ginx1gezU/FvZE
	 E21VTPa5fVnag1HP+gP5NtNruuvpZSrwKGxjCIvCZENquNr/ZzlVWCn50X2n0cEQ6aQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=HHrCeQgK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5687606A326
	for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 17:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5687606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=HHrCeQgK
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2f0213202fdso25356735ad.3
        for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 09:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795541691; cv=none;
        d=google.com; s=arc-20260327;
        b=NkX50H1SickqP6M4tkGuhQH2Y4qEoWjNhi6K+hyI0MjGPeIq+B8aG2Tc7GciHtRhZO
         DMJIYjyaBnhYUbMCBpMRHYZLwIAOmj5npjGUzypylSNybT8ny+EaIGxRVhbHes0FajNI
         TKjq9ASqiJEC+2tip/8BNPaiqRImG1I+FrGp8hUElVBQZe66QL1m9PwqLaYP/ouro2wR
         TaSSzx+kVPK13RdfIsezMAp09CmbwEDQUeF1ilPvG7EH4r/BZXGqPcOxYvaJY2RBVkbk
         afDFA49q/CuwFJ2yAfpEd9ScTjpQ2qhV5at3pki7R3Kffu2Ke7J2FCZQ73jKNO7JYsjj
         04bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XBmnC24W8AXYN+2O9rvqWHkGjrVBXCobhK+i3wuM79I=;
        fh=OtFpNvfUDcD7hE9h9lQSqLqkM7zT4wOBcM5dzf/RBLQ=;
        b=obS9GecQ5/HdGyVv7KStvEBIhHGzst52oT9Qt0NN6EaR21oG8OhUTnIK0blE3xJH1Y
         VTTHA+bvMOzBulEErkE4L6UAgwP87bKhYfup+zqK426NxBlnI5eLoG004iNWTx18cbRC
         wnFPErP+Zvs1lqvsjiDO68tUZBl8Z8raxSHQnfFBOZWf2emXHcxqInPJ4d/aFBTnQzWD
         NVdqUDF7o45Iv1Zv+DaHp0QTU6qtd6/0X147hNf9IM+F9o2FgDU/ZuSMHWigY2ldLNsc
         536tR06uK2aZ2MVGKmZE215yYpFyjHepluQyhVWBuoemdq+DN7KQp4XunatpJLWmlKeC
         0ehg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1795541691; x=1796146491; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XBmnC24W8AXYN+2O9rvqWHkGjrVBXCobhK+i3wuM79I=;
        b=HHrCeQgK/kBXJZ90aRHYJCoHRDaE82HsZ115cJLDYso+RPO71e0P2oCB3lgCU0MEgS
         vqh6phVdkz6ulUaoDB6e0l9qXvOSEIoCNR8KSiDiVRPP1eH/PJFHDDwfunnlA2EdZlpl
         IBc1H1MQCifglg++qUTABRftlRuR/pBz23mq1/edbPJ07HpWcQ/nQ99/W7hJb+mJamiF
         iS+HRsAVyYIlrP5fvIffCfiB9wn7spnsPetVxVjsy7/oH/YZVmk3MDTVudG9t+lq4Vov
         ZiT59zFmbR/7glqKQYhrwI/SlcgE56F6BJH34DFmhgVPkJwjU4EUv4gXctECwbp9F3xP
         kl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795541691; x=1796146491;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XBmnC24W8AXYN+2O9rvqWHkGjrVBXCobhK+i3wuM79I=;
        b=cUhpa4OT4o6Exnv/RzkAQfX6OV1EroLHr5IbzbdOF9mf67JgUXQR41iQEGtPA6JPgk
         82NcfKJqxHgFmvt9vRSVNL5QcLHz03dSKCt2jZj3TQSZVtbrppiBddWrkqf0rcjK4log
         ixV6Vb2cAuCFilzlDOCwdHasXYPPgIbHRDAHNp99Dzlv84r8qn9FkHDFsP72qSzwi10X
         MvQTxykGxv0NUgLbAp2isphfXCToCDVdaTOjDLDNH6naOmLrixDnGf17KebmpVgHXykC
         kFkkeoHId/e8xUZJWieXH0pYZqJjhY8iw3g/E12/dapy6dHzKy1PjfAZ3yrp0uUcLUK6
         nw7g==
X-Forwarded-Encrypted: i=1; AL+hErG9pTUR9Miva20RTQkVekkWn0fMP8LrKh6xAh1VdCHWRHNvoSr4aEI3XETkL4w+lCe1l+PMRQ7t7Q0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8g9DWWUma95sgNvhrG70fT2WD4PulPdNk60BPXfApc2RpLPQY9
	hBCbKpEZDaEArh3aeAe3BnPR5AoMvkWEMNr/GyBcMSJv+tfdKtJ0uyGR5s35HcOTAKbvXDcc1hT
	hsDax8/uNR3XJOmqHlKdqJaiIZer7daQ1JsTST9P8
X-Gm-Gg: AZFdTZd17qZme0RnknHFrUPt8TjAQBkZUbn0YQhRG+martq9OwZQF1GSc8LQsiznfT0
	pqOBV8kLO/T5B++IS/Nb6beCVxI8ou6S9VGtinsvtl5qke1Of9WUJ7ELzBggajtvdEQofJKMSdo
	Dzp7RV2Pysm3eVQrqCKB5XwaGat8AYTRB04qYmEuTEmIsCbAoJ4KAt8KpUSgc5O3P/Q+gksT8b3
	n/U1V6wPZDyVpKtd3fsTnZfEjUcVxSSzgyzxdyo++EpxKCdIAsUP6et3TFoxVR6DRtEGBYl6oOS
	WHKFNuJg9nbyzNLapi4luAyLvcpU+1zsQ6ubOO2IT2gD53H3OP5SrTBmCsmc5NSRzwcjSsgVjTp
	QQnzxY7jwd7e8PbuzDPRJtlR50utFSkXq0+Ez6ik0jMonxNJ4E5Cs0OudEkktNG8yPI0V
X-Received: by 2002:a17:902:dacc:b0:2db:3b35:1ac6 with SMTP id
 d9443c01a7336-2f03ef5a25amr159510795ad.5.1795541691316; Tue, 24 Nov 2026
 09:34:51 -0800 (PST)
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
 <CAHC9VhTLg2FLNf3sLe3+A=q5Mo4gKs+gB7zi5sQT1jizsOPuNQ@mail.gmail.com> <CA+X8SdjoyJT1i1Rf08psCsLQyPQ+yU_tAH0rCQPXpkm4DF_=Nw@mail.gmail.com>
In-Reply-To: <CA+X8SdjoyJT1i1Rf08psCsLQyPQ+yU_tAH0rCQPXpkm4DF_=Nw@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 24 Nov 2026 12:34:38 -0500
X-Gm-Features: Aa3M54qCAAAH8qnzn7NrvXOlemcU2WyGsLTrIJLHcpwId-DXnie5s0o5cb3103Q
Message-ID: <CAHC9VhSY5_NLka8n-yDVwv2FmXj9DF9PWWxomGv1_-mFzZ3Pmw@mail.gmail.com>
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
To: Wong Steve <shyckless@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stevewong@hust.edu.cn, 
	kaixuan.li@ntu.edu.sg
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 12:19=E2=80=AFPM Wong Steve <shyckless@gmail.com> w=
rote:
> > the x25_make_new() function is called by
> > x25_rx_call_request(), which as far as I can tell is on pretty
> > analogous to an accept() operation, is that correct?
>
> Yes. x25_rx_call_request() runs in the receive path
> (x25_lapb_receive_frame() -> x25_receive_data()) when a Call Request
> arrives for a listening socket. It is the X.25 counterpart of TCP
> creating the child socket for an incoming connection:
>
> - x25_find_listener() finds the listening socket,
> - x25_make_new() creates the new socket and copies the listener's
>   settings,
> - the new socket is queued on the listener's receive queue, and
> - x25_accept() later takes it off the queue and grafts it onto the
>   socket that accept() returns.

Great, thanks.

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
