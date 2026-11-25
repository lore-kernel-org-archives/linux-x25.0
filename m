Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596757;
	b=WhqOfBsQviTuNHrL1jrARjraaXZhT6xpUAw9phIBDbj+X4vj6V0YGiA3zGPMD2nGtE+W
	 qNzgM0dlMplPDMo5Hn2AMUM38W7hBxoPeqETSX45Xb9gvy4GDawb6q474cdotFek61fde
	 AowfHef+T6kVhNhdSQR2LUo0/X1PJCqbp9MLQBpTROsoHbOOuu9d7FwVM4YY1HecxcF6J
	 +N11qefo9nyvwMe14Th3C4R4edSIQ79/j7f+GNmSQ3ysLLaDl9u0p26ob7MIvvwhfdfPh
	 SjhMg1rDYekJ4SZrbWxUykVumVw9TRtuRLoSjMFGcub8JrPYQ3llZOPgYKSDZ9lLR0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596757;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate:
	 X-purgate-type:X-purgate-ID;
	bh=rtWODANaW3QrEUkm7m0VLLRF2EVLfsZ+Q8gjr3KiCak=;
	b=J4jOADvFbjYnO8PEVaK0P1sCwbZhcBHYC6fF4OKbWA/n9ZARMk4wTp11b349KN3WuvSY
	 ZnGnegzhD9a0JbmJAIkR091Ii/xuKO10I4tK8/nR6qkkny+4M1c8yPcv4Zqu6rKUQoMDo
	 7YQLBBXOolUypXJr0b8eAU9ts62LIrjfoArx7CBJs5fOcSM7KLYVCwrLONDH18zs99Ste
	 lXiBQnijAnq3ehIoGEd7fdDtTJCwp2AW6nOCGBV3yDCbDN7Bb+cC5bhCBUWrXC0hI7+bh
	 iQqqbI8E1ruQRwdoEOvA/2HfNo3Am2Uogu1FujwxUnsPr97gx4Xjv8MgZbUGGRQBSGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=lRNROCel;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E020606A333;
	Wed, 25 Nov 2026 08:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E020606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=lRNROCel
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6803393a3a=ms@dev.tdt.de>)
	id 1xW8js-007kEz-Rz; Wed, 25 Nov 2026 09:52:28 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xW8js-000yV4-B0; Wed, 25 Nov 2026 09:52:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795596747;
	bh=rtWODANaW3QrEUkm7m0VLLRF2EVLfsZ+Q8gjr3KiCak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRNROCel6SQbyjUXya+DSUTRe6gwobKAW/Q+MPzEWm/YBUmCLB20iV9EtVgA2EYDh
	 K1dtdcfS3JOMPSPpke4kauJMKKf0daPBzGfKDBOdYOfQMapeiI884y004jTFG6U8PQ
	 bjeXuCqXVqQPdAQIYxUuUh87yvAi25c6Xs2i1lDCr3p5L1Et9kNI6627eJiSDX0f2W
	 QvD1lY+33lnuhIoo3XRvmLtyLW0XeiNnCR07soeh0ls/Gn3JHEJm+ufku/LISOMaJZ
	 XJyulnh0ysg1RPc0NfX8sqkIq4x+7wekHIuLbZEZbrQCud8hrM7QsBmSNjhyxn0hLf
	 YIr1uHibcx/mw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 87023240041;
	Wed, 25 Nov 2026 09:52:27 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 731BC240036;
	Wed, 25 Nov 2026 09:52:27 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id E44BC29D20;
	Wed, 25 Nov 2026 09:52:26 +0100 (CET)
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Nov 2026 09:52:26 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Yu Gao <SuperSkidder@qq.com>
Cc: netdev@vger.kernel.org, linux-x25@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Xie He <xie.he.0141@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	syzbot+059a2795ad4cff2a2695@syzkaller.appspotmail.com,
	syzbot+8328573e4d0514392471@syzkaller.appspotmail.com
Subject: Re: [PATCH net 0/2] net: lapbether: fix lock cycles reported by
 syzbot
Organization: TDT AG
In-Reply-To: <tencent_AD34C10B65771ADD86725F3221EE31778507@qq.com>
References: <tencent_AD34C10B65771ADD86725F3221EE31778507@qq.com>
Message-ID: <9361755745d807ce6beee97873db197c@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1795596748-5A415D96-8560CA2B/0/0

On Wed, 25 Nov 2026 05:59:07 +0100, Yu Gao wrote:
> Patch 1 stops holding up_lock across calls into LAPB and removes it.

Thanks, this is a small and clean way to break both cycles. Both entry
points into LAPB run in an RCU read-side critical section, so
synchronize_net() covers them, and LAPB serializes the rest under
lapb->lock, so lapbeth_xmit() doesn't need the TX lock.

> No end-to-end test with X.25 sockets was done.

With the series applied on top of the pending x25_kill_by_neigh() fix,
an X.25 end-to-end test over two lapbether devices on a veth pair
passes with lockdep and without warnings: calls over the link, a LAPB
disconnect and a restart while calls are up, and
"ip link set lapb0 down".

For the series:
Acked-by: Martin Schiller <ms@dev.tdt.de>
