Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76182397933;
	Sun, 20 Sep 2026 22:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789943687; cv=none; b=WBBNUol30/NhhD6dBqux45QqeahfFYeKSuRm8nzBJzU50addeq+AYhLxfFXXZEp5qcMR5q5VpVsdoUB2uJF8FGs9/gPr8fod2wh6aUr6pCRAKvY91L3P7eTl86dT7Cst7KLwGuUzNWBuOIiZGEuSKH0FcTfNWeIIyxtAFTYRDjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789943687; c=relaxed/simple;
	bh=WUTRE50fkf8Opj56sziBPC3Z3IFWM+d+KCp0wCOjgzs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GwL6ddotCRYSZMtxppuEQ/U92DD2CkWGrOBnyG4gb6QRlT5lcS3RVGkxbaD9pktSX7NVY5apGKq20lQxtfkimA+Gc2nxA36+I7P0Yuo+MXYrELLXeqZbZDLALqk2egZStyPExU9ior5PrBbb7bZfUj1rW+qeGSscTl96cAX5re0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5QgXFLB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5QgXFLB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B861F000FF;
	Sun, 20 Sep 2026 22:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789943686;
	bh=U87R++EK1y6Sz1Xb4HBxCZ8MA5p8L+mLjarW01EQyYg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B5QgXFLBT6KK20Ob1YhtIbJ+Delv2d7VX58j0dpyaTK+JWw2CrccVUD9MydRE/GbR
	 kv9eGc97VxfoplkXsilme78IXdb7FGJhbh/ofbaGAULivLvX2mY/KNptYKK+wl2MFZ
	 8n3xCunpOu0UJm3H+CowV8bv5N1QAEfXT9RXGA+pRyi8kwVKIZImRIWsyT9DTk1Lle
	 uZezVdPl4HooVtlqjBpsNYN2Vmw38xY08BexOPsrz6m9NajwMTtI6LQoymbu2Lnwb1
	 BIuhXmirh/KoqkCOQYQvVnfN/3iM83Kz2QcpWHvJEZ3rIWNtFRkqZnSULFcNmvcWik
	 6prjF7MVTL4pw==
Subject: Re: [PATCH] net: wan: lapbether: validate frame length and headroom
 in lapbeth_rcv() and xmit
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: ms@dev.tdt.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sun, 20 Sep 2026 22:34:45 +0000
Message-ID: <178994368506.2160803.16241878291781749602@kernel.org>
In-Reply-To: <20260919223433.3882618-1-benquike@gmail.com>
References: <20260919223433.3882618-1-benquike@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message describes two changes that are not present in
  the diff.
- [High] In lapbeth_rcv() (drivers/net/wan/lapbether.c:135-142) the wire-
  supplied 2-byte length `len = skb->data[0] + skb->data[1] * 256;` is…

Pre-existing issues:
- [Medium] lapbeth_rcv() increments `dev->stats.rx_packets/rx_bytes`
  (drivers/net/wan/lapbether.c:141-142), where `dev` is the *Ethernet*…

--

net: wan: lapbether: validate frame length and headroom in lapbeth_rcv() and xmit

This changes lapbeth_rcv() to use pskb_trim_rcsum() instead of skb_trim()
when trimming the received frame to the length carried in the 2-byte
prefix, drops the frame if the trim fails, and moves the rx_packets and
rx_bytes accounting to after the trim.

A few questions below about the commit message and about the length
handling.

[Severity: High]
The commit message describes two changes that do not appear in the diff:

  "call pskb_may_pull() before reading the 2-byte length prefix in
   lapbeth_rcv() and ensure sufficient headroom in
   lapbeth_data_transmit()"

The pskb_may_pull() call is already there before this patch, in
lapbeth_rcv():

	if (!pskb_may_pull(skb, 2))
		goto drop;

git blame attributes that to 1da177e4c3f4 ("Linux-2.6.12-rc2"), and the
diff adds no pskb_may_pull() call at all.

lapbeth_data_transmit() is not touched by the diff either, and the 2 bytes
it pushes are already accounted for in lapbeth_new_device():

	/* When transmitting data:
	 * first this driver removes a pseudo header of 1 byte,
	 * then the lapb module prepends an LAPB header of at most 3 bytes,
	 * then this driver prepends a length field of 2 bytes,
	 * then the underlying Ethernet device prepends its own header.
	 */
	ndev->needed_headroom = -1 + 3 + 2 + dev->hard_header_len
					   + dev->needed_headroom;

Could the changelog be rewritten to describe what the patch actually does,
namely the skb_trim() to pskb_trim_rcsum() conversion, the new drop path
and the relocated receive counters?

Relatedly, is the Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") tag correct
here? As written it points at an unchecked length-prefix read that the
patch does not change, which may lead to this being picked up for stable
as a memory-safety fix.

> diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> index c3630a82913b..3838910ea7bd 100644
> --- a/drivers/net/wan/lapbether.c
> +++ b/drivers/net/wan/lapbether.c
> @@ -133,11 +133,13 @@ static int lapbeth_rcv(struct sk_buff *skb, struct net_device *dev,
>  		goto drop_unlock;
>  
>  	len = skb->data[0] + skb->data[1] * 256;
> -	dev->stats.rx_packets++;
> -	dev->stats.rx_bytes += len;
>  
>  	skb_pull(skb, 2);	/* Remove the length bytes */
> -	skb_trim(skb, len);	/* Set the length of the data */
> +	if (pskb_trim_rcsum(skb, len))
> +		goto drop_unlock;

[Severity: High]
Does this actually validate len against what was received?

len comes straight off the wire, and pskb_trim_rcsum() returns success
without looking at the skb whenever the requested length is not smaller
than the current one:

include/linux/skbuff.h:pskb_trim_rcsum() {
	skb_might_realloc(skb);
	if (likely(len >= skb->len))
		return 0;
	return pskb_trim_rcsum_slow(skb, len);
}

So for a frame whose prefix declares more bytes than were actually
received, the new check returns 0, no trim happens, and the untrimmed skb
(including any Ethernet minimum-frame padding) is handed to
lapb_data_received(). Only the shrink path can fail, via
pskb_trim_rcsum_slow() returning -EINVAL for CHECKSUM_PARTIAL or -ENOMEM
from __pskb_trim.

The transmit side in the same file defines the prefix as the real payload
length:

	int size = skb->len;

	ptr = skb_push(skb, 2);

	*ptr++ = size % 256;
	*ptr++ = size / 256;

Would an explicit check be closer to what the subject line promises?

	if (len > skb->len)
		goto drop_unlock;

> +
> +	dev->stats.rx_packets++;
> +	dev->stats.rx_bytes += len;

[Severity: High]
Can a sender on the same Ethernet segment inflate rx_bytes here? len is
the declared length, not the number of bytes received, and per the above
it is never rejected when it is too large.

A ~60-byte frame declaring 65535 adds 65535 to dev->stats.rx_bytes, which
does not match the rtnl_link_stats64 definition of rx_bytes as good
received bytes corresponding to rx_packets. Would counting skb->len after
the trim be more accurate?

[Severity: Medium]
This isn't a bug introduced by this patch (the device selection dates back
to ea2ebaf822ad7), but since these two lines are being moved anyway: is dev
the intended netdev here? dev is the Ethernet device the packet_type
handler was called on, while the transmit counterpart charges the LAPB
device:

lapbeth_data_transmit() {
	ndev->stats.tx_packets++;
	ndev->stats.tx_bytes += size;
}

The result is that ip -s link show lapb0 reports transmit counters but
never any rx_packets/rx_bytes, since the receive path reaches the axdev
only through lapb_data_received() -> lapbeth_data_indication() ->
netif_receive_skb_core(), which does not touch dev->stats.

There is also the question of who owns that counter block. dev->stats is a
plain non-atomic struct net_device_stats belonging to the Ethernet driver,
and this read-modify-write is serialized only by lapbeth->up_lock, which
that driver does not take:

	spin_lock_bh(&lapbeth->up_lock);
	...
	dev->stats.rx_packets++;
	dev->stats.rx_bytes += len;

Can this lose increments against the Ethernet driver's own dev->stats
updates, or produce torn rx_bytes on 32-bit? Would lapbeth->axdev->stats be
the right target?

>  
>  	err = lapb_data_received(lapbeth->axdev, skb);
>  	if (err != LAPB_OK) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919223433.3882618-1-benquike%40gmail.com
