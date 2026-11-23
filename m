Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421041;
	b=5DX/Xry3tmEhPDC+bKq6t5cosEGxqqIAzGaGdiDOQBU6xjsTWCncfOPru78GOcHeYjnf
	 rj8KCWKg2Z9oz1Eod4eNGwlIr+1DaqcZV6NcnZQ42tBJVo2BwKLTTYjAgWkSHiDkgQ9W0
	 MyK+FNLXXroJbnoRsz6zkXVmrinhj1DueRwMbB3Park3H1se2wpv+hLDr7il9tr9vH9YC
	 Q+wnYxhtN7HCKpDpS4C41vDWu96IQ7tk/+YyJ9fQWdZbLpQUU6DMge37j/ieO6BltD3JB
	 FbcYHcHzHH5zz/INI4ejjZoZ4MNRuMc2Vr8HolyiY7++Hm0J0F+qHzraCvkOJY16cMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421041;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate-ID:
	 X-purgate-type:X-purgate;
	bh=wq8s74QVlUlCAUYwxi1YGNXVTyJwh2qmcap9DQJ8qsw=;
	b=Es8WW9DWpUY6v7p1EOAtkl0n+rkUbJ5wQZZFxlJHDBHSUgR0L3eG/cFR23Qp2y+8pv/S
	 8k/nGyxPdxlupi7AoepGg87hbj/JnjqvB6v3wJthJDxKp+aDia11mKbV+m/cfjK/kx0Pt
	 NFGXtXWbSpz1s50I9XYH8gpC/omJjKOykmnMUO4KLRs3d+X0JlM7ypgzp+Zsk/HkFgxJF
	 o125gkWl1a/TdmRMstRKxcTkRVRNwHYvk1KiF5vZzKr6dDp8IozAUld88awG3ipZ0EGNG
	 bWzYxTo0V7OyfaMHxqVvLl75K/YDg99bRbYxgZElBQZo8qGrbrqstfpDvZNAnm4XEzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=nlBhaU0f;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44724606E602;
	Mon, 23 Nov 2026 08:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44724606E602
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=nlBhaU0f
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68018334f9=ms@dev.tdt.de>)
	id 1xVP1j-007Nlo-Cf; Mon, 23 Nov 2026 09:03:51 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVP1i-009wDJ-Ht; Mon, 23 Nov 2026 09:03:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795421029;
	bh=wq8s74QVlUlCAUYwxi1YGNXVTyJwh2qmcap9DQJ8qsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nlBhaU0fc8m/tEw7l/Hk3CVYXezPnR+M5gSVtj6o2mGKDqrylcMxjNZsXT/I5VnKh
	 ALrWFiNRODJXW+wTukKkJi80PAoFxocAFddss1K3p6b3nVPXEhFOowdt3JVAa4ijU5
	 zdHiPGaa4WLPhZsBwl14gzIVP2cLnj35mIPwmMUpphE+TRQKhwhn7aFS2iJy5NmLDL
	 +vILnAsKfuqgt0Bdk53SOgJr7LUvJ59GKcoGQ3NF2vI8bGUwh6semhjy21UtPrWHxw
	 6FRvYVnXpxjUQBjzAoXk5ph1UBgKWInWRjx6gOQVasPTsrNA1KfbWE8xGxVN3GRQNG
	 8DZXVoefQTGdg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id DCB71240040;
	Mon, 23 Nov 2026 09:03:49 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id D317B240036;
	Mon, 23 Nov 2026 09:03:49 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 91E142AED5;
	Mon, 23 Nov 2026 09:03:49 +0100 (CET)
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
Date: Mon, 23 Nov 2026 09:03:49 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Shuai Liu <847807867@qq.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com
Subject: Re: [PATCH] x25: defer socket cleanup on link termination to
 process context
Organization: TDT AG
In-Reply-To: <tencent_8BA4FF587EE5579AB67149C5062618DC7109@qq.com>
References: <179539800759.3135.17245752044060918891@kernel.org>
 <tencent_8BA4FF587EE5579AB67149C5062618DC7109@qq.com>
Message-ID: mid:11
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1795421031-FFCFF71F-D7A6C9B5/0/0
X-purgate-type: clean
X-purgate: clean
Message-ID: <20261123080349.ScmCLanF2bkBAAS6-tg5TvBoHycVT0Ql_ZS-45e_92s@z>

Hi Shuai,

On Mon, 23 Nov 2026 04:47:48 +0100, Shuai Liu wrote:
> Changes in v3:
>   - Flush kill_work in NETDEV_CHANGE as well, restoring synchronous
>     socket cleanup for both process-context notifier events (Sashiko)

The NETDEV_CHANGE flush is fine, but I don't agree that the medium
issue from the review is not actionable, and I don't want to take the
workqueue approach.

In your reply to the review you wrote:
> The deferred work runs within microseconds of the event, long before
> the peer can deliver any new frame.

That only holds while no socket on the link is owned by a task. The
worker sleeps in lock_sock() until the owner releases the socket, which
is exactly the case in which the current code sleeps in softirq, and an
owner holds the socket for as long as its send buffer takes to fault
in. Until then, every call on the link keeps its LCI binding.

I tested v3 with two lapbether devices on a veth pair and a sender
stalled in x25_sendmsg() via userfaultfd, so that its socket is owned
when the link event arrives:

- after a LAPB disconnect, the stalled call itself brings the link back
   up (SABM) before it is cleared, so the peer can reach us again while
   the old calls are still bound;
- after a RESTART, a CALL REQUEST on the old LCI, sent two seconds after
   the restart was confirmed, never reaches the listener, and the old
   call sends a DATA packet on that LCI.

Neither involves frames that were in flight before the restart.

> Detaching the sockets synchronously in softirq would require writing
> x25->neighbour / lci / state from BH without lock_sock()

It doesn't. Thang's patch from October [1] uses the pattern that
x25_receive_data() and the x25 timers already use: under
bh_lock_sock(), a socket that is not owned is cleared right away, and an
owned one only gets an atomic flag and is cleared by its owner from
release_cb. Its v2 also skips flagged sockets in __x25_find_socket() and
keeps them from transmitting, which fixes both cases above in the same
test. I'll post it in the next days.

Also, please post new versions as a new thread, with the version in the
subject of the patch itself, not as a reply to the previous posting.

[1] 
https://lore.kernel.org/all/20261001150118.128470-1-ngocthang2710.1999@gmail.com/

pw-bot: changes-requested
