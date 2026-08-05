Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1614A4F0;
	Wed,  5 Aug 2026 10:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785924788; cv=none; b=UDJebl59Mnb+PfdWSdN1wRF6EeRpVKXjkvVzp6HJijnu6kRhITnc05zrZktLoKtE/XsRAZlO8ImHaQsgCs2xG9hirexspNOOJyh/dFpR1vxVG7hfi9mRBLVrtIh7JR0i3XqtGqVMhn39obgC+hRbvCSjV1suz2KXvEV66VSEIpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785924788; c=relaxed/simple;
	bh=5XP335Kp0fAarB1qj4xYbDS9ngajhtz3287JUoL2jY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FD5qCkUQ14YVcJYCr2vlaXB6tOxOEFhkHEUSFBdCAiDgX8hvGORtSiWNKfELmIHSTHyi2kfL6HkZWP5Y/cL3RSU93sqmpa/SmZeU9ZoaKRvKPBqLBa1bkYdjzXmiDyaThz9W77rb6SW2CNx2egjql3Q/m2QugK7hV7HfWkKPrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlzwWnU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlzwWnU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2831E1F000E9;
	Wed,  5 Aug 2026 10:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785924787;
	bh=y98lk8nxN12M2eDqxPQhdvbQY5ROuC8ERV6faFQi+CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AlzwWnU+N8H8OcBXwbfs48dulGHLrUhYGBdMQjvBHZ+MVuM9e2wZNi15oYai/kTiV
	 LXV7KJo6LcUXubaXKGSmNiG+AuQ7ZrASQBSsTK2Cy0+D69BNVeDbMxqbta4M1CbGJw
	 in4jJYd3mhE8GT9jYEDGMSFtqceU+Rtrdchl56At95XvSrfU31unuZZoAUXZbrG/Fx
	 UawNqv4UqmcLdqEXCBmX8nEOCvQfj9L+hw5hTaAJdQ5Omqn2uFkSaqz0igLIIqp3M2
	 27MtHfOIoAlAprQcPOAtPDdo8OOHY7R1N1iP1CadRFLgs8KQP563lfGaZKDlzqpR1O
	 W7N8ejo9kPdMg==
From: Simon Horman <horms@kernel.org>
To: f3lix.dev@gmx.de
Cc: Simon Horman <horms@kernel.org>,
	linux-x25@vger.kernel.org,
	ms@dev.tdt.de,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: x25: shut down T20 timer before freeing neighbour
Date: Wed,  5 Aug 2026 11:12:44 +0100
Message-ID: <20260805101244.551614-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260731173955.1601698-1-f3lix.dev@gmx.de>
References: <20260731173955.1601698-1-f3lix.dev@gmx.de>
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260731173955.1601698-1-f3lix.dev@gmx.de?part=1
---
--- Patch [1]: [PATCH net] net: x25: shut down T20 timer before freeing neighbour ---
commit 918c9c3f4476f4a299dc5fd66bd610293c1355e6
Author: Felix Hoffmann <f3lix.dev@gmx.de>

net: x25: shut down T20 timer before freeing neighbour

This adds timer_shutdown_sync() on nb->t20timer and skb_queue_purge() on
nb->queue in __x25_remove_neigh(), before the list-owned reference is
dropped, to close a use-after-free where the T20 callback rearms the timer
after x25_link_terminated() cancelled it with timer_delete(). It also
restores the queue purge that commit 7eed751b3b2a removed.

A few questions about the placement of the new cleanup.

> diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
> index d1e8cd81c2143..876333cb16aee 100644
> --- a/net/x25/x25_link.c
> +++ b/net/x25/x25_link.c
> @@ -298,6 +298,9 @@ void x25_link_device_up(struct net_device *dev)
>   */
>  static void __x25_remove_neigh(struct x25_neigh *nb)
>  {
> +	timer_shutdown_sync(&nb->t20timer);
> +	skb_queue_purge(&nb->queue);
> +

[Severity: High]
[Finding: main-4-5]
[Sources: opus-5]
This isn't a bug introduced by this patch, but with the teardown now
looking complete in __x25_remove_neigh(), is nb->dev still left dangling
for neighbours that outlive their list membership?

x25_link_device_down() drops the device reference right after the removal
helper returns, while __x25_remove_neigh() only releases the list-owned
neighbour reference:

net/x25/x25_link.c:x25_link_device_down() {
	if (nb->dev == dev) {
		__x25_remove_neigh(nb);
		dev_put(dev);
	}
}

x25_link_device_down() does not call x25_kill_by_neigh(), so a socket that
already holds its own reference keeps nb alive:

net/x25/af_x25.c:x25_connect() {
	x25->neighbour = x25_get_neigh(rt->dev);
}

and the same in x25_rx_call_request() via x25_neigh_hold(nb). The
x25_kill_by_neigh() scan that runs on NETDEV_DOWN reads x25_sk(s)->neighbour
under x25_list_lock only, so a socket that assigns x25->neighbour after the
scan passed it is not evicted. NETDEV_UNREGISTER then removes the neighbour
and drops the device reference, leaving nb->dev unheld.

Once the netdev is freed, does the next transmit on that socket read freed
memory here?

net/x25/x25_dev.c:x25_establish_link() {
	switch (nb->dev->type) {
	...
	skb->dev      = nb->dev;

	dev_queue_xmit(skb);
}

x25_send_frame() dereferences nb->dev the same way, reached from
x25_transmit_link() for X25_LINK_STATE_3. Would it make more sense to
invalidate nb->dev (or evict socket references with x25_kill_by_neigh())
at removal time rather than only dropping the device reference?

[Severity: Medium]
[Finding: main-1-0]
[Sources: opus-5]
This is a pre-existing issue, but does the purge belong at list removal
rather than at the neighbour's release point?

x25_neigh_put() frees the object with a bare kfree() and never touches
nb->queue:

include/net/x25.h:x25_neigh_put() {
	if (refcount_dec_and_test(&nb->refcnt))
		kfree(nb);
}

A socket holding its own reference (x25->neighbour) can still reach
x25_transmit_link() through x25_kick()/x25_send_iframe()/x25_write_internal()
after the neighbour has been unlinked and purged:

net/x25/x25_link.c:x25_transmit_link() {
	case X25_LINK_STATE_0:
		skb_queue_tail(&nb->queue, skb);
		nb->state = X25_LINK_STATE_1;
		x25_establish_link(nb);
	case X25_LINK_STATE_1:
	case X25_LINK_STATE_2:
		skb_queue_tail(&nb->queue, skb);
}

No lock is held there, and the remaining drain/purge sites
(x25_link_control(), x25_link_established(), x25_link_terminated()) are only
reachable with a neighbour obtained from x25_get_neigh(), i.e. one that is
still on x25_neigh_list. With the T20 timer now permanently shut down, can
those frames ever be drained again, or do they leak together with the socket
references they carry from sock_alloc_send_skb() in x25_output() when
kfree(nb) runs?

Would moving the purge and the timer shutdown into a release helper called
when the refcount hits zero avoid this, and also avoid leaving a
backporter with the impression that nb->queue is empty at free time?

[Severity: Low]
[Finding: main-2-1]
[Sources: opus-5, opus-4-7]
This isn't a bug, but the kernel-doc immediately above the function now
describes less than the function does:

net/x25/x25_link.c
/**
 *	__x25_remove_neigh - remove neighbour from x25_neigh_list
 *	@nb: - neigh to remove
 *
 *	Remove neighbour from x25_neigh_list. If it was there.
 *	Caller must hold x25_neigh_list_lock.
 */

The function is no longer only a list operation. timer_shutdown_sync() is
irreversible per its own documentation in kernel/time/timer.c ("@timer
cannot be enqueued again. Any attempt to rearm @timer is silently
ignored"), which __mod_timer() implements with:

kernel/time/timer.c:__mod_timer() {
	if (!timer->function)
		goto out_unlock;
}

and skb_queue_purge() destroys frames that x25_transmit_link() queued for
later transmission. The helper also now spin-waits for a callback that may
be running on another CPU, while both callers hold the lock with BH
disabled:

net/x25/x25_link.c:x25_link_device_down() {
	write_lock_bh(&x25_neigh_list_lock);

	list_for_each_safe(entry, tmp, &x25_neigh_list) {
}

x25_link_free() does the same. Could the comment be updated to describe the
synchronous, irreversible teardown and the blocking behaviour under
write_lock_bh()?

>  	if (nb->node.next) {
>  		list_del(&nb->node);
>  		x25_neigh_put(nb);

Also, the two new operations sit before the if (nb->node.next) guard, so on
the "it was not there" path documented in the comment the function drops no
reference but still kills the T20 timer permanently and discards queued
frames. Both current callers iterate x25_neigh_list, so that branch is
always taken today; would moving the two steps inside the guard keep the
helper consistent with its documented contract for any future caller?
