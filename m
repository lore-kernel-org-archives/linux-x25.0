Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795601208;
	b=KHZvz6VqEyPtA0L+LnUntftRmBMRKtyxw3sddui91t/5+7Ayw7giU8Gzxxx/e1XTBqzp
	 XlRDS7UQTzRsYQXpTuh+sDO5SOqEQqlZzgBvaryWXo4dnmcOC0hpUOgGuIM5i7F+jfPaP
	 Y9fBL1URxPgy9t1/whAr+0wl+x3jjP68aC3SDL+JKHGRRXQVuCi01sfWOftjrOICSKmNb
	 JTFJpLRxRc9/tPa1GmdrK5x7xTRyVmOCkses9Qr8TairjSw5ErDzIspzuW8GkNjKdkoyq
	 8bQUCgqFVqRFa2VWt/kwVnDEHPKK/KSoW+QufagVLkoIalS9QxHvwQ+yiDTx0y1xc0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601208;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate-ID:
	 X-purgate-type:X-purgate;
	bh=Nb9j7n4VMoBo0nPcTqnB3tMTmYPQkVLcITR8atKeMWY=;
	b=DzehCU6oRm+EzqV8NP4G6IQjrBoL+BSj/1cQfnJ1qfqVSCh1Xnem/ROuKbhJRWEFGbPg
	 6gyv1jVw1rK6MX5rVxhjnlmRP5FiORSXDN1YqoEhSm1RQcWfkLEgPynSR1C3sP9tLC/oq
	 A7H6yepJbAZpgox/2WkQ1lWx08pup1Qo9e/jk3TdEVzukC6cdDKOb37cfSxuROTi75I8t
	 wkEbCoeHV1lNZ1/DUISrvZpgfwJ7/fc3OIhHXQl3/Tx8jlLGi1IosSKNMoKJODlof4ct5
	 xwEZnzfQy2XTnrlwvrIUDPi9CqdFI0oR18lKPaBPfNyZQYu9hRePhIw02ni5CP1FZMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=HYuSPXnR;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4B6606A31E;
	Wed, 25 Nov 2026 10:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD4B6606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=HYuSPXnR
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6803393a3a=ms@dev.tdt.de>)
	id 1xW9th-008TMU-TY; Wed, 25 Nov 2026 11:06:41 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xW9tg-0051nP-S0; Wed, 25 Nov 2026 11:06:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795601200;
	bh=Nb9j7n4VMoBo0nPcTqnB3tMTmYPQkVLcITR8atKeMWY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HYuSPXnRM2CBM1IbXAuD4yqDicVHktqHnTxWIqONZujCvug2JTbudY/7FCGhYoaxf
	 8AHixpF80OjtZEaiNB67/NDtbsSSVW0vxg3+srEWvZxvobVc8T/tBBcgmlvMwf1Tax
	 v3EpCJeK6gHvYH2s+NYZIxtRj9WIEVavRLlDMGUw1E2K5WcJkC/JCRvPQ3Ymk/KuMg
	 CeOX6z7FD/DuB1fzrveDdd/phhl4immNgF/mhT7QY7sEp+Py+5ek9e1MC5oWz+DMho
	 WswOmAOirkKDYMBpVJNgGrKr5yetSYfpWuVcP7teMP12+q1i6rDc6UINTbO0v4OAfX
	 NI52QcRmQqWDQ==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 26CF0240041;
	Wed, 25 Nov 2026 11:06:40 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 0E24A240036;
	Wed, 25 Nov 2026 11:06:40 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id DA2E929D20;
	Wed, 25 Nov 2026 11:06:39 +0100 (CET)
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
Date: Wed, 25 Nov 2026 11:06:39 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: f3lix.dev@gmx.de
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-kernel@vger.kernel.org, willemb@google.com,
	netdev-bot+sashiko@kernel.org
Subject: Re: [PATCH net v2] net: x25: shut down T20 timer before freeing
 neighbour
Organization: TDT AG
In-Reply-To: <179559958721.3135.5593816176235018299@kernel.org>
References: <20261124093922.39573-1-f3lix.dev@gmx.de>
 <179559958721.3135.5593816176235018299@kernel.org>
Message-ID: <e9d12b5647f149f2133068c2b254afdd@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1795601201-18C34C46-2EC5333E/0/0
X-purgate-type: clean
X-purgate: clean

On Wed, 25 Nov 2026 10:39:47 +0100, netdev-bot wrote:
> Would it be more robust to purge nb->queue in x25_neigh_put() before
> kfree()? At that point nobody else can add to the queue, and
> skb_queue_purge() is safe in atomic context.

I agree. A socket that takes the neighbour in the window before
x25_route_device_down() can still queue frames after the list
reference is gone, so the purge belongs where the neighbour is freed.
The timer shutdown is fine where it is, as nothing can rearm a timer
after timer_shutdown_sync().

Felix, could you send a v3 that moves the purge into x25_neigh_put()
and documents the timer shutdown in the comment above
__x25_remove_neigh()? As the netdev bot asked, please also say in the
commit message how you found the issue and how you reproduced it.
Please drop my Acked-by for it, I'll look at the v3 again.

pw-bot: changes-requested
