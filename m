Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795599588;
	b=LfO2U433Vb4smCtaHuuuXy8fTOr+XeZkEDmgDjKWLhhn1MD4mR3RYjv0JuzoYLTRVIbK
	 0DVfzbBgfQiZm0JdPEliEAJZmoSvKI6yvpXW6o3M24YLlXy1rQ/HYvb0az6i16cKktiX8
	 5kc8y9M8BzjWBmn2WYdNu5dcoVt1YwGyucPo9bsnifkmFcUnd9aX7O8kCp7peH3uJW4CC
	 CdN+kvkxzAMm3PtdCRtMN+BgkyXTH9NCEIh5R3Px1JesdwLf/gNtuV6Zs2R+nEDl5SoPe
	 rxImwW6iTyCuNGwBvpLymbrqenUxeR2ai+EmYh95LPdEGTuyCXrrtCc266xwRpEzttg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795599588;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=rrie8qOVDRuHFMz/FkqXnHLhbfl/qqS8bONc++uaYkE=;
	b=oPOzVuOnJROQ2jKHzvaUoH/apC5lU56yB78taUhb7INSzVH48M1aoWKOBKjbr7hV6Nz2
	 h3pgysbAip/AAvFAMUgf0888RN5M7pSdwcm1uh8jyH9YvDLX12Qf93zNPnzYPAwbPWIEX
	 XnzmPAqbxA+IvLOBVs7SWdCGy3RH+rddtjet5Ea/QjwNyiTMra5G3eKovHszqsE9X6zRa
	 ByTgYbb9TP1HisHbnJiGPmGdIi7uu1+yjoaqby9UcTnkte5jaPMM5s9+AchDzVFOyp1pu
	 08dB3wf81T/vQG2/NBiGVO7ZPcWXfF5oNsf52gwKV8yh8yJgIHPFzQy7wv3x0o8o6CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxZvidaM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99C606A32D;
	Wed, 25 Nov 2026 09:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GxZvidaM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1B01F000C6;
	Wed, 25 Nov 2026 09:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795599588;
	bh=rrie8qOVDRuHFMz/FkqXnHLhbfl/qqS8bONc++uaYkE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GxZvidaMVBBGAA+Te4M76X9GcvWrPzmPS5nLZHscpiHx+gyp6MjHqwhrphG2M4UdT
	 4QhRJbleegOL74Il9iULWiYeutOrh79islSbB70xkWqwICatzbAO0ZscOBgrHLj/l6
	 6hXQ9EOOhHjSU+UYijB1C+ibpf8DXDYl9G67DUR++ev6KzxwzBkgGz8BL4RCfalfrW
	 WlSWTsKGbseDxAEpli9cveEsfybSpQaY+4csuZikVHAL+6Dy6dzHI+VX7kZX3zGi4K
	 cKH1qibwDGGkjPKwaQENgq6UZ2mcmMvOb79s51JDqTMamSeZshhKNzibNHAWTO1J/p
	 lGP/yGYay3ONA==
Subject:
 Re: [PATCH net v2] net: x25: shut down T20 timer before freeing neighbour
From: netdev-bot+sashiko@kernel.org
To: f3lix.dev@gmx.de
Cc: linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, willemb@google.com
Date: Wed, 25 Nov 2026 09:39:47 +0000
Message-ID: <179559958721.3135.5593816176235018299@kernel.org>
In-Reply-To: <20261124093922.39573-1-f3lix.dev@gmx.de>
References: <20261124093922.39573-1-f3lix.dev@gmx.de>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new skb_queue_purge(&nb->queue) runs in
  __x25_remove_neigh() (net/x25/x25_link.c:303).
- [Low] The kernel-doc for __x25_remove_neigh()
  (net/x25/x25_link.c:292-298) still describes only list removal:…

--

net: x25: shut down T20 timer before freeing neighbour

This commit makes __x25_remove_neigh() call timer_shutdown_sync() on the
T20 timer, so a callback that is already running can't rearm the timer
after the neighbour is freed. It also purges nb->queue before the
list-owned reference is dropped. That restores the cleanup removed by
commit 7eed751b3b2a.

> diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
> index d1e8cd81c2143..b9f290616e3a8 100644
> --- a/net/x25/x25_link.c
> +++ b/net/x25/x25_link.c
> @@ -299,6 +299,8 @@ void x25_link_device_up(struct net_device *dev)
>  static void __x25_remove_neigh(struct x25_neigh *nb)
>  {
>  	if (nb->node.next) {
> +		timer_shutdown_sync(&nb->t20timer);
> +		skb_queue_purge(&nb->queue);

[Severity: Medium]
Is this the right place for the purge? __x25_remove_neigh() only drops the
reference that x25_neigh_list owns. The neighbour is actually freed by
whoever calls x25_neigh_put() last, and that function only calls kfree():

include/net/x25.h:x25_neigh_put() {
	if (refcount_dec_and_test(&nb->refcnt))
		kfree(nb);
}

Anyone still holding a reference after list removal can add frames to
nb->queue through x25_transmit_link() while nb->state is 0, 1 or 2:

net/x25/x25_link.c:x25_transmit_link() {
	case X25_LINK_STATE_0:
		skb_queue_tail(&nb->queue, skb);
	...
	case X25_LINK_STATE_1:
	case X25_LINK_STATE_2:
		skb_queue_tail(&nb->queue, skb);
}

A socket is one way to get there. On NETDEV_DOWN, x25_device_event() calls
x25_link_terminated()->x25_kill_by_neigh() before x25_route_device_down().
A non-blocking x25_connect() running at the same time can find the route
and take the reference after x25_kill_by_neigh() has already walked the
socket list:

	x25->neighbour = x25_get_neigh(rt->dev);

That socket is never disconnected. It sends CALL_REQUEST, which moves nb
to X25_LINK_STATE_1, then returns -EINPROGRESS and keeps the reference.

NETDEV_UNREGISTER then runs x25_link_device_down()->__x25_remove_neigh().
That purges nb->queue and drops the list reference, but the socket still
holds nb. Later, either T21 expiry in X25_STATE_1 or close() queues
another frame:

x25_do_timer_expiry()
    x25_write_internal(sk, X25_CLEAR_REQUEST)
        x25_transmit_link()
            skb_queue_tail(&nb->queue, skb)

When x25_disconnect()->x25_neigh_put() later drops the last reference,
won't nb be freed with that skb still on nb->queue? x25_forward_data() and
x25_forward_call() follow the same pattern: take a reference, transmit,
then drop it.

The commit message says:

    Also purge queued frames before releasing the neighbour

As written, this only covers frames queued before the list reference is
dropped. Would it be more robust to purge nb->queue in x25_neigh_put()
before kfree()? At that point nobody else can add to the queue, and
skb_queue_purge() is safe in atomic context.

>  		list_del(&nb->node);
>  		x25_neigh_put(nb);
>  	}

[Severity: Low]
This isn't a bug, but the kernel-doc above __x25_remove_neigh() still
describes only the list removal:

 *	__x25_remove_neigh - remove neighbour from x25_neigh_list
 *	@nb: - neigh to remove
 *
 *	Remove neighbour from x25_neigh_list. If it was there.
 *	Caller must hold x25_neigh_list_lock.

Could it say that the function now shuts down T20 for good and purges
nb->queue? It could also note that timer_shutdown_sync() may wait for a
running callback while the caller holds x25_neigh_list_lock.

The rule that x25_t20timer_expiry() must never take x25_neigh_list_lock
is currently written down only in the commit message. If the callback
ever took that lock, x25_link_device_down() and x25_link_free() would
deadlock.

Separately, this one is pre-existing: the if (nb->node.next) guard can't
detect an entry already removed with list_del(), because LIST_POISON1 is
non-NULL. Today the function is only called while iterating the list.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124093922.39573-1-f3lix.dev%40gmx.de
