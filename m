Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.37.255.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761224;
	b=5sOEjpo/K4MPJWZmY56nvCsuBBtlPrHK2ygeNh4vPQxGkuW8IFx5RXYj30VFqmz82WVC
	 DLHn57TmgbnBh6Eg1fvLrC8cX8t/3F7ZDO/u05CkMLrJYbaEvpIKTg2s6nIXtOuymU612
	 isMQewXJKC9BXI3TbY6HHuun1ZMECAHrl23zcER+dRg/Im9VnmyRPR3Sa49DwWjgoM69J
	 UgpLhxiSe8URD+JENEQ+f+dPX5hW1/GnR3qcFL2atO64X9tGpYsVhW4x673GaMJnqCXxQ
	 vcX87gLzznLukHRLfiU4D6nt9sVNYYjCMGeZ8IXakFyzpSBH0mVcm4/Zs0xNXcVb9CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761224;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:
	 X-purgate-type:X-purgate-ID:X-purgate;
	bh=9ynB3kGZB0AvNuWCZZgmdlEBFs2oh7w13vtkznQ9vGI=;
	b=x0kX9+1vwG002x+3vkkdhLrwtcCUvbUfmN7vMXfnQsHdfM6C/ppSs+lN6C2GcksViZnW
	 /ip6bS3FRP+KDg44FQvrdAOLd6sK8QTGtdmtoYGQmT+q0ZxKtEntmkcD+a8zrs1ocMsCE
	 AmyTsccl5mHvTPc/7quzS8Y1Mxads5fM/AQY5NQRZje7edHVp0VG3rmdV9ygua7sQfAxb
	 9sNvC6iPuFayWsutXc3UIwJ0xA5SK1nGlRh524neHBMF5ezz/HtY9BU90mj0wdVI+YdBf
	 f5WrTQGcvSIHeBvT3WIsHhkzsdbZrJBHwCsgeTny/99eizVyCoTA0gDEeNsPvVhHtQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=InK+lgxV;
	arc=none smtp.remote-ip=194.37.255.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C57606A31C;
	Fri, 27 Nov 2026 06:33:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94C57606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=InK+lgxV
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68051b93b8=ms@dev.tdt.de>)
	id 1xWpWS-007kz4-Fi; Fri, 27 Nov 2026 07:33:28 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xWpWR-00CtHy-MM; Fri, 27 Nov 2026 07:33:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795761206;
	bh=9ynB3kGZB0AvNuWCZZgmdlEBFs2oh7w13vtkznQ9vGI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=InK+lgxVu5DimB1VjEKfyi+FONNl+hYGZN+cmGOdqbOU7MDzjGGNEzxjEMfFL3dHZ
	 +lfwC0m85R2DPdql6FmZgLhjd0Yb37wxmoazljtrSk2IuvIruqDO2bTFoiNf6Dz8Q1
	 RGOTeGILEwVCBLplUkhi6hIIT2bFIMaTPcK8Wh8+eDmyPrFv6ZMUQpH32pY35RGynR
	 7+PAtVSfj2e52C3hrAEHyuO/6nME41ZZp0zZZcQcSmxUYCKl+nRqGqYmuijfNfSzx8
	 /CCcalsg4sqAEx9EPJfsJxn9mOBURt1vsgFkP2XhMxWFvXxUzu77fFoDAaNRHGCXRS
	 uRKNu/S5tUrsw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 75647240040;
	Fri, 27 Nov 2026 07:33:26 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 639C4240036;
	Fri, 27 Nov 2026 07:33:26 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id BCF1A2B005;
	Fri, 27 Nov 2026 07:33:25 +0100 (CET)
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
Date: Fri, 27 Nov 2026 07:33:25 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Felix Hoffmann <f3lix.dev@gmx.de>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org, Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH net v3] net: x25: shut down T20 timer before freeing
 neighbour
Organization: TDT AG
In-Reply-To: <20261125103153.53012-1-f3lix.dev@gmx.de>
References: <20261125103153.53012-1-f3lix.dev@gmx.de>
Message-ID: <680c69bd08e0481f7ddb16b64501ed24@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1795761208-A2E87872-2EB326DE/0/0
X-purgate: clean

On Wed, 25 Nov 2026 11:31:53 +0100, Felix Hoffmann wrote:
> Purge queued frames when the last neighbour reference is dropped.

Thanks, that addresses the review.

The AI review of v3 [1] adds that the use-after-free does not even
need a race: x25_exit() frees the neighbours before the netdev notifier
is unregistered, so unloading the module while a link is in state 2
always frees a neighbour with an armed T20 timer, and
NETDEV_PRE_TYPE_CHANGE also skips x25_link_terminated(). The patch
covers both, and as it is already Cc'd to stable, I don't think the
commit message needs a respin for this.

The dangling nb->dev the review also mentions is a separate,
pre-existing issue, which I'll look into separately.

Acked-by: Martin Schiller <ms@dev.tdt.de>

[1] https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261125103153.53012-1-f3lix.dev%40gmx.de
