Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420685;
	b=lJavv7W4VdkVHwMagqno6Kingj0HiIIdnw7h1PH+BIV6cdDuawPV16Q+6S/aMHEzp7Et
	 PU06olEM2x1pQSJU5xi7bToYiVrVAdx12vWS9X19oemgMa4ix1aFqEjIQ9vNIYTIQpy5S
	 N082CovEAvoriw8hI0JHWb75rERoK89EQJiXxGRPdqOj30eZP8bfafIuB2c5Ib9T79zwE
	 uyL9eL5oU9mgmpfDy7sUdB+y887hQKtLwPUsicae0J5iwzJ2ZDJPSFbqcOUvYZBY6cZEd
	 eZ+0l5RSTyl5NeixZUtRSnrBpArIP9kYmh+1DTId6WVjKg/MnTkBAweDQ1tK/ikTI6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420685;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate:
	 X-purgate-type:X-purgate-ID;
	bh=SNHm202/e+FOtZ2uxCzYO9hiduPnu8am59Fo+bkDzhE=;
	b=VZehtjyE86rr5s3Y5jl8luAUyNgibUjifMzUWLk0mA2CRZe3z7NL5MB9p7XCBkmAPh7D
	 /Hyqi9aY7bOCTXR7eUK502oAykgQwI3PMTzslMNwdhruX8b+WyaKDxAQ0zSa60nAh+qqS
	 +0Sixsn4JtETsgOWDRQWEg3NOMqutBDwtzetJCM9rFp2pPbBAR8+ZTmk9+DKvSOnFzJIJ
	 x6QLZcvbLzDhtF4pUlOTgHx9oJuT1erQb9GzDxalwcjKaq6vlQ6Tpxme2T83NiBEj6+N9
	 7D5MRxYjixyG8KFJmdG+dNP1+Goqg1qXYnWwzfVR4uKvaFu/nPC6adZ0J8KsLKsH6bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=M12l+2D9;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139C7606A31A;
	Mon, 23 Nov 2026 07:58:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 139C7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=M12l+2D9
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68018334f9=ms@dev.tdt.de>)
	id 1xVOvp-00CyZa-FF; Mon, 23 Nov 2026 08:57:45 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVOvo-00E5s7-A1; Mon, 23 Nov 2026 08:57:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795420663;
	bh=SNHm202/e+FOtZ2uxCzYO9hiduPnu8am59Fo+bkDzhE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M12l+2D9bY8UmGckh0umt8MlP7tLtIr0LGiLPDPqiXFivccj2PhVhCIXGwlA5lxNg
	 jvcd/Yf1KdkTQVcBMKlfDFtaL3knxenoda9VN1rqhraPe2AGnb9W8c/11Pb0HTTUxw
	 q0rxS4WQTyug5rchfpgD1BbCRuxclnK7mXGAaIwPcg0XlfdVgP4ilfxlxp2ssQ9fkY
	 EQDk2FL112jq5Vwmfxh4Zx4vk9ZD1KJf8emfBsn+Pb6LzrTrvPHcVsUuTqEe3+QDnj
	 4LQ9tr/hb98atujz74Aumo5+49yShs65EUwSULCnO/7aOJntX4n++1bh3sy0veMp4/
	 gbqKojzB6DxcQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 914B8240040;
	Mon, 23 Nov 2026 08:57:43 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 7C29A240036;
	Mon, 23 Nov 2026 08:57:43 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 524CF2AED5;
	Mon, 23 Nov 2026 08:57:40 +0100 (CET)
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon, 23 Nov 2026 08:57:40 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Duoming Zhou <duoming@zju.edu.cn>,
	Lin Ma <linma@zju.edu.cn>,
	syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net/x25: don't call lock_sock() from softirq in
 x25_kill_by_neigh()
Organization: TDT AG
In-Reply-To: <20261001150118.128470-1-ngocthang2710.1999@gmail.com>
References: <20261001150118.128470-1-ngocthang2710.1999@gmail.com>
Message-ID: mid:11
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1795420665-60C18D96-C18A1F4A/0/0

Hi Thang,

On Thu, 01 Oct 2026 17:01:18 +0200, Nguyen Ngoc Thang wrote:
> Take the socket spinlock instead, the same way the x25 timers and 
> receive
> path already do. If the socket is not owned by user, disconnect it 
> right
> away. If it is, mark it with X25_KILL_FLAG and let a new release_cb do
> the disconnect when the owner releases the socket.

This is the approach I'd like to take, rather than deferring the whole
cleanup to a workqueue as proposed since. syzbot still hits the bug,
now also as https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6

The two new findings of the AI review hold up in practice. I tested
with two lapbether devices on a veth pair and a sender stalled in
x25_sendmsg() via userfaultfd, so that the socket is owned when the
link event arrives:

- after a RESTART, a CALL REQUEST on the old LCI is queued to the
   flagged socket's backlog and never reaches the listener;
- the flagged socket still transmits: a DATA packet on its old LCI
   after the restart, and after a LAPB disconnect it brings the link
   back up (SABM) before release_cb runs.

Skipping flagged sockets in __x25_find_socket() and returning early
from x25_kick() and x25_write_internal() for them fixes both. Those two
functions cover everything a socket transmits, and the deferred
x25_disconnect() only changes local state. Clearing the flag in
x25_make_new() takes care of the inheritance issue.

The x25_sendmsg()/x25_output() issue is pre-existing and independent;
I have a separate patch for it.

I have these changes on top of your patch, together with the separate
fix, and the series passes the tests above with lockdep and
DEBUG_ATOMIC_SLEEP. Unless you'd like to send the v2 yourself, I'll
post it in a few days, with you as the author of the main patch.

pw-bot: changes-requested
