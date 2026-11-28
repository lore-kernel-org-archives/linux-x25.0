Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795851413;
	b=RQIyDE2tU3tg0GZwsluKkeh/n3nbOiiOPbMdfZppeey94HtKLrdF+eIxekcamumidxBa
	 skYrbvIlUlvHt1qmGsQFucpPGayX+GQKJEA2YO96IoZbxJA9Oh/wj417CXngiDpLac24A
	 yrY9pSmoInYdPwP27qTlDEJ5wvEbVXQwRKsV5+c/epfVrzx0Co8QGiY2fpOYhF/gBTVLT
	 zpwavN0B3v/aPAg+zGGx5iwEWUILjuUaGt3jNRBwATyRcBGs9cL3HP0otDCOQNCtcKC4v
	 CLkez9ifCgDT0U6yJkzepe2oQctqXUaus6CLSUVf5BKLHCoY6IFw+TW/JY0kF/D5vDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795851413;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Date:From:To:Cc:Subject:
	 Organization:In-Reply-To:References:Message-ID:X-Sender:User-Agent:
	 X-Spam-Status:X-Spam-Checker-Version:Content-Transfer-Encoding:
	 X-purgate-ID:X-purgate-type:X-purgate;
	bh=a2IM2yRtMGBwveos7w0jxFJ914XYJxxYuz7Z+0YeLYw=;
	b=Nh56Lzh0wvdsH+bF3SV6aWY+e8P4NNYHLyahE8sHFw6uuq2FtR3Ko+aihNsGXloOYw5z
	 XaV35XA7m0lXP84z0U7Js/D5rxrtPbe7gZqDlD7w+6y+QbBfdqArFAZXsUheWxk+TOXt3
	 r1KAJzH6S7ey5fEJm53Z5aR3CCaeZm52fIfiVq0A+4ahYjRcC9gx3owtaUXh4L1OfuHHz
	 TqLoftGBUNU3qy6rVJvbhPD+CH6JhoLIAt4Sqr6/BkkcX2mUqc2pVz8crxsclpIvTTAje
	 1XNaIEUlfeIR/8OMTyK0SDzX9dxgWzmNrNmUTNVgbj3IJTFljHyHSdmUCxpBYlb6VJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=P1G2AQqc;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97591606A31C;
	Sat, 28 Nov 2026 07:36:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97591606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=P1G2AQqc
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68062c6ca6=ms@dev.tdt.de>)
	id 1xXCz9-006Uj1-Mk; Sat, 28 Nov 2026 08:36:39 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xXCz8-000Om5-1j; Sat, 28 Nov 2026 08:36:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795851397;
	bh=a2IM2yRtMGBwveos7w0jxFJ914XYJxxYuz7Z+0YeLYw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=P1G2AQqcfQWW7X0nMwpFstuhYo5FmVrvfpB/2nROlREVB20qMZclr3ffh2DCEvaTK
	 azXUACntLWhVLpHolxX/FbOh99kzgkzMwp5uljvkZvUYpEGt+0s5CwbGhLIvNwKaDz
	 E5OrUexiqjCCfHtPIcLfJVOGs5DMs38zPzG8QhEF7YU6PxPchnCfajJeIlyqs2j7Tm
	 VcL4xiKO9KM1Qrf/+h0ctcs8zMOhUHcP/VY+nnm7hE1VVsEx6WWSYsF+HlqEGxUwxl
	 Zrn7N/p3/6voHZkvMS4IBr2IKdMJ2VMw+WFJwwtdRBe+bDFBoIXrOh/ZHMeYbriqxU
	 kOaqvjmMqBVEw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 56C25240041;
	Sat, 28 Nov 2026 08:36:37 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 36DC3240036;
	Sat, 28 Nov 2026 08:36:37 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id BEA7B2A7AE;
	Sat, 28 Nov 2026 08:36:36 +0100 (CET)
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
Date: Sat, 28 Nov 2026 08:36:36 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, willemb@google.com, horms@kernel.org,
	linma@zju.edu.cn, duoming@zju.edu.cn, xiyuyang19@fudan.edu.cn,
	tanxin.ctf@gmail.com, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, ngocthang2710.1999@gmail.com,
	847807867@qq.com, krystianmkaniewski@gmail.com,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/2] net/x25: don't call lock_sock() from softirq
 in x25_kill_by_neigh()
Organization: TDT AG
In-Reply-To: <179585053119.3135.1065383095936227619@kernel.org>
References: <20261127-x25-kill-by-neigh-v2-1-c7cdcc9f1320@dev.tdt.de>
 <179585053119.3135.1065383095936227619@kernel.org>
Message-ID: <2bc1bca886a970c1ed3da2eab7ff0709@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
Content-Transfer-Encoding: quoted-printable
X-purgate-ID: 151534::1795851398-51B09C46-661BD4AB/0/0
X-purgate-type: clean
X-purgate: clean

On Sat, 28 Nov 2026 08:22:11 +0100, netdev-bot wrote:
> - [Medium] net/x25/af_x25.c: the patch adds `!test_bit(X25_KILL_FLAG,
>   ...)` to __x25_find_socket().
> - [Medium] The X25_KILL_FLAG checks that the patch adds in x25_kick()
>   (net/x25/x25_out.c) and x25_write_internal() (net/x25/x25_subr.c) are=
=E2=80=A6

Both are valid. I'll send a v3 that clears X25_KILL_FLAG only after
x25_disconnect() has reset the LCI, and that takes the socket spinlock
around transmissions in process context and around the backlog
processing, so that a flagged socket cannot send frames of the old call
after the restart has been confirmed.
