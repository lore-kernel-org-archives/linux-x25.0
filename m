Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827253DEFF3;
	Tue, 14 Jul 2026 06:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.37.255.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011359; cv=none; b=IhiO+VRN3PYDp+RzchbxJkbTEQWf8ogF8F7Gy9ZkZBttHlk/IkSb5yor9OV4XN/p7LOkVfX39+W64YL5+GzWDDu8/dr2CuiiGZncDOcsRkN6L75Nh5CCxBI9YK+Nfh6dHJWgXHccxJjBiwKsR4ud+BZri+6hIX8UPhPlxqurl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011359; c=relaxed/simple;
	bh=zVnAuZM1PRfdy0pGXtTvFM4MDopGC1hC9yIlERUSSng=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=LYX08JWsg5P3TAO855uPeXBGbbuqtDxdsryNv1tTfPb6aJyJwteuN4oO48LD9WP2/TGBwN6T5OuVfUDzZ804qI68rOXgx57xH6sn7f/xTwuoj2Wrt2pv4/tKXK6tqFrS65UkM3h7YeXG1Rs4GLlvHFtwJe1ONT/QFDISzPpBDMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de; spf=pass smtp.mailfrom=dev.tdt.de; dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b=Jn0pA1Tj; arc=none smtp.client-ip=194.37.255.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=dev.tdt.de header.i=@dev.tdt.de header.b="Jn0pA1Tj"
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=066936b52f=ms@dev.tdt.de>)
	id 1wjWqT-004xfl-Rn; Tue, 14 Jul 2026 08:42:21 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1wjWqS-003VpS-NU; Tue, 14 Jul 2026 08:42:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1784011340;
	bh=Xhw+E4apzU4E80VvO8VsFNLqRNDi7Wh1FuGkAZEljOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jn0pA1Tjq+zoMDUnnBwc42OXx+70oXQpL2IY5/60+3kl2l7ew1krJx30pwl0Vf7VH
	 SJ+kjxN6yNj9G+r92BsnZFkmtaSEsqDzcMc8X5vWBo5X+pO0WXWSLb+n6me8aImDIq
	 KbOgOgaEdCom8zPLIw96vAiXhnWHdgnFNQ/xf76Ihz5lsAULpl0423wCav03dkwemg
	 yqaUg8bA68ZAz2pJh7allekSPQ41uC8YUidaSC0qkfef2sM7KRWPqFU0mj8gLhf7TR
	 Z5EDLyOOE7nr9Z1FzAXhga2G0DqjE/4rUWlMXSGZSdkIdfDpuM4+JHUxrefIl4rCn/
	 3M0HsRoMKrlvg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 2D760240040;
	Tue, 14 Jul 2026 08:42:20 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 22065240036;
	Tue, 14 Jul 2026 08:42:20 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id C06D026B94;
	Tue, 14 Jul 2026 08:42:19 +0200 (CEST)
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 14 Jul 2026 08:42:19 +0200 (CEST)
From: Martin Schiller <ms@dev.tdt.de>
To: David Lee <david.lee@trailofbits.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
Organization: TDT AG
In-Reply-To: <20260713104752.241175-1-david.lee@trailofbits.com>
References: <20260713104752.241175-1-david.lee@trailofbits.com>
Message-ID: <aa5405c3a539422e79ae24bc2e41e6f1@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1784011341-009CFA6E-9F9CBE81/0/0
X-purgate-type: clean
X-purgate: clean

On 2026-07-13 12:47, David Lee wrote:
> x25_kill_by_neigh() walks the global X.25 socket list looking for 
> sockets
> attached to a terminating neighbour. x25_list_lock protects list 
> membership
> while the lookup is in progress, but it does not pin a socket's 
> lifetime
> after the lock is dropped.
> 
> The function currently drops x25_list_lock before calling lock_sock(s). 
> A
> concurrent close can run x25_release(), remove the same socket from
> x25_list, and drop the last socket reference in that window. The 
> neighbour
> teardown path can then lock or inspect a freed struct sock/struct 
> x25_sock.
> 
> Take sock_hold(s) while x25_list_lock still proves that the list entry 
> is
> live, then drop the temporary reference after the socket has been 
> locked,
> rechecked, and released. Recheck x25_sk(s)->neighbour after 
> lock_sock(),
> because another path may have disconnected the socket before this path
> acquired the socket lock. Restart the list walk after each disconnect
> because the list lock was dropped and the previous iterator state may 
> no
> longer be valid.
> 
> A QEMU/KASAN run against origin/master reproduced a slab-use-after-free 
> in
> x25_kill_by_neigh().
> 
> Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by 
> x25_disconnect")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Lee <david.lee@trailofbits.com>
> Assisted-by: Codex:gpt-5.5
> ---
> Trail of Bits has a reproducer that triggers kernel panic
> demonstrating the bug, and can share it if needed.
> 
> net/x25/af_x25.c |    8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index c31d2af5dd22..8aae9273b7c1 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -1768,15 +1768,19 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
>  {
>  	struct sock *s;
> 
> +again:
>  	write_lock_bh(&x25_list_lock);
> 
>  	sk_for_each(s, &x25_list) {
>  		if (x25_sk(s)->neighbour == nb) {
> +			sock_hold(s);
>  			write_unlock_bh(&x25_list_lock);
>  			lock_sock(s);
> -			x25_disconnect(s, ENETUNREACH, 0, 0);
> +			if (x25_sk(s)->neighbour == nb)
> +				x25_disconnect(s, ENETUNREACH, 0, 0);
>  			release_sock(s);
> -			write_lock_bh(&x25_list_lock);
> +			sock_put(s);
> +			goto again;
>  		}
>  	}
>  	write_unlock_bh(&x25_list_lock);

LGTM, Thanks.

Acked-by: Martin Schiller <ms@dev.tdt.de>
