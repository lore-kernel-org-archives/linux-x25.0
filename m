Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F4027472;
	Sat, 28 Mar 2026 00:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774658015; cv=none; b=vAeGF9g+AoqMxa/DKdaf0B2vq3YVt0I8K78kaszHufD3o/6HjHqd+1l1+jjd+7PqQA9MBwnwS8FvYmmV5zwmfit5acqfbZxeIaHXvnfzjfhWnGvzylG68ilSOt66sWV+yN5aQAVIbHYPH+T3OpmRLzxcwZ8SQFnvtNAF8slzROA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774658015; c=relaxed/simple;
	bh=ek6qtnjmWH1Vxb53j8u1fMJG2PqErRkSwBDjxGRCEic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kYeSPpNX65L4gB53fF1jN+Nwqe4OP1p6E89UpppBfhG6CewOlYAbehTAdmkxCCiOPiEbFYf5aElT+7jI0M6cz0+VZWTo8AaSlCDKUAmWS2oBEeLI/FOM7dSqtSZVm4ekqOYbhO5DmejK8Swg4ChgLyKeLxkuVMAllm3st3UzBGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LePBlutr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LePBlutr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 520B4C19423;
	Sat, 28 Mar 2026 00:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774658014;
	bh=ek6qtnjmWH1Vxb53j8u1fMJG2PqErRkSwBDjxGRCEic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LePBlutrzAIavrVidgMT1Hn05mD15a+OP+bNz9tqg3koccogw6bncnoUMbNZe5XYQ
	 HDRiz5nBjVxqm+dwDyM6SzFbFT9oZz2+CmQwErpAJlyZh7CxOLTSGSviK4vX+bQw9J
	 WV0AaAPeh1uFGK+Oke9YozJnSGbUYEzhYNhfaN60Ij8yMF+O2BUfaOfVwjqfAfd2l/
	 jZijf6X6rUrBbAO5rzyfIV5bTBe910U0pi3gUegOjby5uvHku7cJzX/qoAL5CEG1OW
	 /EozEk0PMjeBrFyViGLNabEef/az6yuAH3Q4T3TuhMsSBgvExqY386dTCL+9DOmCv+
	 MU8yvy/Ur8yAg==
Date: Fri, 27 Mar 2026 17:33:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Yiming Qian
 <yimingqian591@gmail.com>, linux-x25@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [PATCH net] net/x25: Fix overflow when accumulating packets
Message-ID: <20260327173323.4f4783df@kernel.org>
In-Reply-To: <b2099069e5dce49a0bc068a8d318f3a2@dev.tdt.de>
References: <20260327-x25_fraglen-v1-1-9fc751d4f754@dev.tdt.de>
	<b2099069e5dce49a0bc068a8d318f3a2@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Mar 2026 09:36:00 +0100 Martin Schiller wrote:
> > +	/* make sure we don't overflow */
> > +	if (x25->fraglen + skb->len > sizeof(x25->fraglen)) {  
> 
> Please ignore this patch. I'll send a V2 without that
> "sizeof()" nonsense in a moment.

We ask that submitters wait 24h before reposting:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#tl-dr
-- 
pv-bot: 24h
