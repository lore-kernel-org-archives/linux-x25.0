Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761833;
	b=vYLY87WHD7IGvf9hx6f+RMYctt4dK5ijGMPbNKUxnH50qb4exfiVSfmLLYAIW1s34E8k
	 YpDHQ9RHc2xN8uWaAHoFBHNJH3RCedkTIOJN8+c8h8ZBSGGmOxqrQ1jcaqtK0dHhheULT
	 B/cbuMf/7RnZJQxcPqZ54VGnjRKckIletbcjG6LjT/65M2FvSzDwYHeLNFrLFUNsu+B1R
	 UyRFd8awWHPjoSfzoIVke7kJOS+ZyGWV4C4l8RWytn8VNk88M7V9tg4di5s4xLmdRRyZi
	 DREehEe9WFmf6Aqh6vKM/pXuZT8qfdMhNZcl/9niQlEnKDerfc04ehb2xAyAdMFcgOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761833;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate-ID:
	 X-purgate-type:X-purgate;
	bh=Qmr8CnMea5BRjNQuvuiVBUyRp0f079wxoF6k2Pj+JXM=;
	b=l1imyRpX38krddh8FsNFjqhRZo7qBqGAvdU32mb9x7I8wfKffYPnumk/U+E9Wdcrs6ws
	 eZYVIN3H4GogYtnpEGIosOjsKRtkDs6TRKyNVePU3VmwINxuY2Qk2OUpqdHbe+TBxDjGD
	 SnBBkQEWUHNdqL75yqEdDagSkwtnaZl8IQxCKYJy22wZcfdF1UYiI/HdX5dVHGNjOewnN
	 ny/iEfcvcu4T7F/ApfUwoxlim+SmJmd/ZEPholqrS830YVsYBzU53/2t3os5Gy3tZWifQ
	 DXWPK9iToOQVnpj1Tq+GwbRDpBaT7rvmaIAUD7K70zgEjKalBpNvWh+bv0FcvbuRE9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=ApEXhZO6;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35500606A31E;
	Fri, 27 Nov 2026 06:43:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35500606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=ApEXhZO6
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68051b93b8=ms@dev.tdt.de>)
	id 1xWpgQ-001KgP-R3; Fri, 27 Nov 2026 07:43:46 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xWpgP-001BEM-SA; Fri, 27 Nov 2026 07:43:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795761825;
	bh=Qmr8CnMea5BRjNQuvuiVBUyRp0f079wxoF6k2Pj+JXM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ApEXhZO6OZJSKMtiljyK8rHIIC3nEeO+0PaM7ljQCF561QKjL9AVs1T2C0RSUYqvP
	 syDWtUY9xj6y4ScuVBe6OTmIIt8phWEgj4plewFAUhcIlcqjfKXprUONruIAlsmGXz
	 z/r3XV1DEjOEwUspRq6AtqzQZ0wwTqa0Photx+wjc+76iTngyoQTViY2zBI0bsh2g3
	 s/izRkefOWxPFotu2G9Cd54qGhjW80L/EJuNcXR9ynYeo1ES348Is4RFV8a+ScEL5b
	 6mDypNUx65ei827NY1Mk0FHzEW5uGCtRz8cgiIdJ3zfRQCDPlxY+hvXreDvzXH6yas
	 8nNS3DsmGKU3g==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 2D505240041;
	Fri, 27 Nov 2026 07:43:45 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 098C5240036;
	Fri, 27 Nov 2026 07:43:45 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 838522AFCA;
	Fri, 27 Nov 2026 07:43:44 +0100 (CET)
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
Date: Fri, 27 Nov 2026 07:43:44 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: netdev-bot+sinfo@kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>,
	linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Shuai Liu <847807867@qq.com>,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net/x25: don't call lock_sock() from softirq
 in x25_kill_by_neigh()
Organization: TDT AG
In-Reply-To: <179576123458.3294.15178511049839805716@kernel.org>
References: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
 <179576123458.3294.15178511049839805716@kernel.org>
Message-ID: <027c20e8213255a86f182d089390b091@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1795761826-3B6D6C46-77C7B7B9/0/0
X-purgate-type: clean
X-purgate: clean

On Fri, 27 Nov 2026 07:33:54 +0100, netdev-bot wrote:
> - Whether the issue was actually triggered, or is only theoretical
>   (e.g. found by LLM and not proven at runtime). If it was triggered
>   please include the symptoms, like the stack trace or kernel messages.

Patch 1 fixes a triggered issue. syzbot hits it with its reproducers,
see the two reports in the Closes: tags. It also reproduces in QEMU
with two lapbether devices on a veth pair: when the link goes down
with a call up, an unpatched kernel with lockdep and
DEBUG_ATOMIC_SLEEP reports (trimmed):

  WARNING: inconsistent lock state
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
  x25test/26 [HC0[0]:SC1[1]:HE1:SE0] takes:
  ffff888000a81218 (sk_lock-AF_X25){+.?.}-{0:0}, at: x25_kill_by_neigh+0x50/0x99
  ...
  BUG: sleeping function called from invalid context at net/core/sock.c:3908
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 26, name: x25test
  Call Trace:
   <IRQ>
   ? lock_sock_nested+0x3e/0x6c
   ? x25_kill_by_neigh+0x50/0x99
   ? x25_lapb_receive_frame+0x2d9/0x2f7
   ...
   ? lapbeth_napi_poll+0x30/0x47
   ? __napi_poll.constprop.0+0x1f/0x107
   ? net_rx_action+0x134/0x26c
   ? handle_softirqs+0x14c/0x2e5

With the series applied, these splats are gone; the tests are
described in the cover letter.

Patch 2 is theoretical. The x25_sendmsg() and x25_output() cases were
found by the netdev AI review of v1, the x25_recvmsg() case by Krystian
by code inspection. The window, a CLEAR or a link failure handled in
softirq while the socket lock is dropped, is narrow, and I have not
reproduced it at runtime.
