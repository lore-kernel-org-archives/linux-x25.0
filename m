Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795455890;
	b=kgDXpXAIWaorRolcYiWenNcup0Tp1gam0JGEaEGZQusKPZf+AjK7icubpqGhEW5+f/Vh
	 RriOP/MW60RZd4PAek50s7L6kd5/zR3ENajQbPWaXfVNjlJBO9IG8nSCL9n2BA3LbDhct
	 ZBAM3lnGidsvLTeR34+Y8AuyybaywfA+S+gZ6H0Csux/ggNDgzT2GVyiFDXbLzZUm/FVN
	 7hkmVj1uP7fG2NWAgf4RwSHfZcXN89Yjn7hEJAFhnMgOPLSYJlwXizeiwMPz+h4GiBLB2
	 QxzEwLUfDvcag5v2FjpzjPMFpwA+vUACOqTCwLvmz5Z+3/v8XMJijAialPXYbJ/Ke7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795455890;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:
	 X-purgate-type:X-purgate:X-purgate-ID;
	bh=Xem99+IMWHB2IdSRPHk081dyBcwHZcfFeuaBwZ4cstE=;
	b=LYKlaubKWAxK6eNA2maRJcRHODVA8ZoZ+pVt/y0p11ElXoHXC8UaXYjtGsDmsq5RWwuT
	 /9r6UVobjioTwZMJa7SQ2CYXr4dux5WIA8lf3xnRCrIUGae71Qt43nr1BNsgJWvCovwYh
	 2VBH3bP7UWp6Sc5Md1MAxaU0BC0sQsi1hPyXneDRouiHzJBET2vGgcSarBpWfF/quEPWp
	 d8PbIcVwFT4knQJqBNsPast4JTOSdNxuodkHoN7mc6QuF+qWtvS/Kl/pYASk7baiZv6Fo
	 6LVYysCexY5mPgxaeMFKJ3Dq4SfqdsR7/lVrUVZWFbllLavJIx1Nvp1KQD//I56pxXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=ruvBVrzi;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F08606A31E;
	Mon, 23 Nov 2026 17:44:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A4F08606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=ruvBVrzi
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68018334f9=ms@dev.tdt.de>)
	id 1xVY5l-00H8rQ-TC; Mon, 23 Nov 2026 18:44:37 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVY5j-008MmH-KQ; Mon, 23 Nov 2026 18:44:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795455874;
	bh=Xem99+IMWHB2IdSRPHk081dyBcwHZcfFeuaBwZ4cstE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ruvBVrzi6YBU7Ay5rAfCvg8gnuLfurJyKS0TgqmwlBd7uCD6C/SNJvF4zX/N4ZY0n
	 PJ7VnSch/E7Vb1oSg9ehsXmvYu5ddG+kikY5QwWaguXrhM9P1AhRJhhAn/afKfDl8X
	 N/OrgbI+zJNCUfuDiKf5T2bmmpo4v2mfK27t5z8Xc58jg1jayp3L/Ry4koMpIDfZbb
	 wDxY+n9+8qD4eLF+B+Mhu3P1i1/iSew9P3wr8+XtCLLDY5+H5o5CispSyCXWhJSGYb
	 wdswQx9dtGNUOgJyOmdwB3KrMyAO1wutlzOWvi6VlvxeLMwDBpi0FkSEY3QUQD6rhL
	 S1k6WTzvDkD9w==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id E079B240040;
	Mon, 23 Nov 2026 18:44:34 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id CE589240036;
	Mon, 23 Nov 2026 18:44:34 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 7B56029BAC;
	Mon, 23 Nov 2026 18:44:34 +0100 (CET)
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
Date: Mon, 23 Nov 2026 18:44:34 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-x25@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net/x25: release the route on a nonblocking connect
Organization: TDT AG
In-Reply-To: <179375957890.488859.954022080109103885@kernel.org>
References: <20261104022812.1484250-1-vulab@iscas.ac.cn>
 <179375957890.488859.954022080109103885@kernel.org>
Message-ID: <2b85d5c0abedae444d312de12a388ef4@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate: clean
X-purgate-ID: 151534::1795455876-ECF6CE18-0EA3A98F/0/0

On Wed, 04 Nov 2026 03:32:58 +0100, netdev-bot wrote:
> - Whether the issue was actually triggered, or is only theoretical
>   (e.g. found by code inspection). If it was triggered please include
>   the symptoms, like the stack trace or error messages.

It is real and easy to trigger: every nonblocking connect() leaks one
reference on the route. After a single nonblocking connect() and
deleting the route with SIOCDELRT, kmemleak reports the route:

  unreferenced object 0xffff8880008cf940 (size 64):
    comm "x25test", pid 26, jiffies 4294892916
    backtrace (crc 40ba0c57):
      __kmalloc_cache_noprof+0x3c/0x69
      x25_route_ioctl+0xe8/0x1bf
      sock_ioctl+0x2d4/0x35d
      __x64_sys_ioctl+0x56a/0x77c

With the patch applied, kmemleak stays quiet. Good catch, I missed
the route reference in e21dba7a4df4.

Wentao, as the patch is marked "Changes Requested", please send a v2
as a new thread with [PATCH net v2] in the subject:

- describe in the commit message, in plain words, how you found the
  issue, e.g. "discovered by an AI code review agent", and add the
  kmemleak report above as validation: a single nonblocking connect()
  followed by deleting the route with SIOCDELRT is enough;
- drop the Assisted-by: line, checkpatch rejects it; if you want to
  say which tools helped with the patch itself, do so below the "---"
  line;
- add a link to this v1 below the "---" line.

Feel free to add my

Acked-by: Martin Schiller <ms@dev.tdt.de>
