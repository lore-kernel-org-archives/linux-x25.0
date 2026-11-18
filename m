Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795026922;
	b=cqN7MPoyCYNy/pBOEELpTyQ3wcJBZjD4rtcBKEhpjKcV4wCao8q8ivSMvC/oVqDwSaAD
	 eT+ngMvWwXkekfdc6k0BqiXBNoKYqU3Y59H9mgR5FpdnB74CX2dL7EjDcvY6VtuS3d5HF
	 A4B2mugYFX9DKVB6nDwvNUHK3qrWTFklBiGVGuUu2L29YdIYnuohDH3jE6Vk0UNfFqVL+
	 Twe14KVNBMsXyNfKtWKCZKK1uJJRlnppZY8sxI+5+m17BvbnIOo/rG3eQjMfUSzhjSs+F
	 Ucz040ug/cW1FOUn4ZT9sjuDWldA0Olk7aeXG3ewTZALXE5oLoDaYkSme4wD+84Zq/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795026922;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=06qENrVHT40iOvMyTGhyjZi0wGDlQK1zjmO3TygZh8s=;
	b=KDlf8ahOnlvJvMeG4ENjgJU4CTCALC3YiX9BmysQH/CxYOMThjxWGD5h3LgfLxc/zvAa
	 sVliURJKqfr6ifXesOPCsBcRpRC0QO49iEM6ksK2Xk3ydN2GcGVAEJ8F0CDfI6xLG5TSM
	 KgbxWygOj4g5FDfK9y1JPMDQ0ZCgS9PzcyCXnWZEacQGagc+J36mfxYp2B7iO3fr6cMWO
	 pmCyAR/T8kmj09hI9DScNBsYl9PCvj/xC2eahJvU9xJuEu7f20pdHjOoUavqgPDFyCujb
	 zPj/7uxeNa5R2PMn1ADzO3jmr35BgiNv5+ckHqZtWRuB2SeZYoa6BSH7a3LH4+DJJdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8nFU6xm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CD1606A31C;
	Wed, 18 Nov 2026 18:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z8nFU6xm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27C41F000C5;
	Wed, 18 Nov 2026 18:35:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795026922;
	bh=06qENrVHT40iOvMyTGhyjZi0wGDlQK1zjmO3TygZh8s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Z8nFU6xmkjpCEk2I8NYD4QQ1GxgOHisH41qarcu0HMEarNTLhZ15TpvoQks7Dg5/U
	 kTDUrSEXL3dTdJTjLIduY816Ouogybiz0nAp07prJJVNhIE4rxvT+JpUsy/WnSt4iR
	 IeBl9XDTKDqWCpU5qLqA3KreCJ3VILamSifWdBBO93I4iBqMgv4s09CmnXpUHNasFM
	 7OceXlRBAVHVFo+ek/UbOyMBU6fqJOnFcerjgakbLA0wjVUkdxJIp3kXQn6eNCEZxP
	 Dm747/zfBo0GjZ3b8uxocCbEY85mroHdklDrcLYJKHLFgzGrwGE3+TAqm2zFL1Cys1
	 hArM16tZ5bU6Q==
Subject:
 Re: [PATCH] x25: defer socket cleanup on link termination to process context
From: netdev-bot+sashiko@kernel.org
To: 847807867@qq.com
Cc: ms@dev.tdt.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
Date: Wed, 18 Nov 2026 18:35:21 +0000
Message-ID: <179502692151.3136.18288735873132919768@kernel.org>
In-Reply-To: <tencent_F7C2DC0FA42B5866E5C39A9E70D3C52C2609@qq.com>
References: <tencent_F7C2DC0FA42B5866E5C39A9E70D3C52C2609@qq.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Each of the three new deferral sites calls x25_neigh_hold(nb)
  and then schedule_work(&nb->kill_work) without checking what…
- [High] The patch adds nb->kill_work.
- [High] Device deletion now leaves a window in which X.25 sockets can
  transmit on a freed net_device.
- [Medium] Moving x25_kill_by_neigh() into a worker changes the X.25
  restart and out-of-order handling.
- [Low] The commit fixes a real bug reported by syzbot (sleeping in
  atomic context and an inconsistent lockdep state in…

--

x25: defer socket cleanup on link termination to process context

This commit moves the x25_kill_by_neigh() calls in x25_link_control() and
x25_link_terminated() into a per-neighbour work item, so that lock_sock()
runs in process context. Each call site takes a reference on the
neighbour, and the work item drops it once it has run.

Closes: https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6

> Reported-by: syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6
> Signed-off-by: Shuai Liu <847807867@qq.com>

[Severity: Low]
This isn't a bug, but should this have a Fixes: tag and a Cc: stable?

The lock_sock()/release_sock() calls in x25_kill_by_neigh() were added by
commit 7781607938c8 ("net/x25: Fix null-ptr-deref caused by
x25_disconnect").

The later commit 5499e0602d2f ("net/x25: fix use-after-free in
x25_kill_by_neigh()") has Fixes: 7781607938c8 and Cc: stable, so the
stable trees contain the sleeping code too.

> diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
> index d1e8cd81c2143..150ccd78cba64 100644
> --- a/net/x25/x25_link.c
> +++ b/net/x25/x25_link.c

[ ... ]

> @@ -82,7 +90,8 @@ void x25_link_control(struct sk_buff *skb, struct x25_neigh *nb,
>  			break;
>  		case X25_LINK_STATE_3:
>  			/* clear existing virtual calls */
> -			x25_kill_by_neigh(nb);
> +			x25_neigh_hold(nb);
> +			schedule_work(&nb->kill_work);

[Severity: High]
What happens to the reference from x25_neigh_hold() when kill_work is
already pending? In that case schedule_work() returns false and does not
queue the item again. x25_kill_by_neigh_work() still drops only one
reference per run:

static void x25_kill_by_neigh_work(struct work_struct *work)
{
	...
	x25_kill_by_neigh(nb);
	x25_neigh_put(nb);
}

So each extra hold leaks a reference on nb. Once __x25_remove_neigh()
drops the list's reference, the refcount never reaches zero and nb is
never kfree()'d.

In X25_LINK_STATE_3, a RESTART_REQUEST leaves nb->state at STATE_3. A
remote peer that sends several restart requests before the worker runs
would therefore leak one reference per request.

Locally, the same happens when x25_link_terminated() runs twice before
the worker does. Examples are NETDEV_CHANGE with carrier off followed by
NETDEV_DOWN, or X25_IFACE_DISCONNECT followed by NETDEV_DOWN.

The commit message says "x25_kill_by_neigh() is idempotent, so repeated
scheduling is harmless". That holds for the cleanup itself, but does it
hold for the reference counting?

Would something like this work at all three call sites?

	x25_neigh_hold(nb);
	if (!schedule_work(&nb->kill_work))
		x25_neigh_put(nb);

Every caller still holds its own reference from x25_get_neigh(), so that
put cannot free nb.

The RESTART_CONFIRMATION case and x25_link_terminated() below have the
same pattern.

>  
>  			x25_transmit_restart_confirmation(nb);
>  			break;

[Severity: Medium]
Does deferring the clear change the restart semantics here? Before this
patch, the existing virtual calls were cleared before the restart
confirmation went out.

Now the confirmation goes out and nb->state stays at STATE_3. The stale
sockets are still in X25_STATE_3 with neighbour == nb.

x25_kill_by_neigh() matches only on the neighbour:

	sk_for_each(s, &x25_list) {
		if (x25_sk(s)->neighbour == nb) {

Calls set up after the restart, through x25_receive_data() ->
x25_rx_call_request() or a local x25_connect(), also have neighbour ==
nb. Would they get disconnected with ENETUNREACH when the worker finally
runs?

Until the worker runs, x25_find_socket(lci, nb) in x25_receive_data()
also keeps delivering post-restart frames to the stale sockets. That
includes a CALL_REQUEST that reuses a stale LCI, which would go to
x25_process_rx_frame() instead of x25_rx_call_request().

After x25_link_terminated() sets nb->state = X25_LINK_STATE_0, the stale
sockets can still transmit. This can happen through x25_sendmsg() ->
x25_kick(), or through the heartbeat and T2 timers via
x25_write_internal().

In STATE_0, x25_transmit_link() queues the skb on nb->queue and calls
x25_establish_link(). Could stale traffic bring a just-terminated link
back up? Those frames would then be flushed by the
nb->state == X25_LINK_STATE_3 loop at the end of x25_link_control().

The NETDEV_DOWN and NETDEV_CHANGE callers in x25_device_event() already
run in process context and didn't need deferral, but they lose their
synchronous cleanup too.

The "clear existing virtual calls" and "X.25 03/93 4.6.3" comments also
no longer match what the code does.

[ ... ]

> @@ -254,7 +264,8 @@ void x25_link_terminated(struct x25_neigh *nb)
>  	x25_stop_t20timer(nb);
>  
>  	/* Out of order: clear existing virtual calls (X.25 03/93 4.6.3) */
> -	x25_kill_by_neigh(nb);
> +	x25_neigh_hold(nb);
> +	schedule_work(&nb->kill_work);
>  }

[Severity: High]
Can this lead to a use-after-free of the net_device when the device is
unregistered? unregister_netdevice() -> dev_close() sends NETDEV_DOWN,
and NETDEV_UNREGISTER follows under RTNL:

x25_device_event()
  NETDEV_DOWN
    x25_link_terminated(nb)
      nb->state = X25_LINK_STATE_0
      schedule_work(&nb->kill_work)    <- sockets not cleared yet
  NETDEV_UNREGISTER
    x25_link_device_down(dev)
      __x25_remove_neigh(nb)
      dev_put(dev)

x25 sockets hold a reference on nb but not on nb->dev. Once the netdev
is freed, nb->dev dangles.

Before this patch, NETDEV_DOWN had already disconnected the sockets
(neighbour = NULL, state = X25_STATE_0). Now, until the worker runs, a
connected socket still has x25->state == X25_STATE_3 and
x25->neighbour == nb:

x25_sendmsg()
  x25_kick()
    x25_transmit_link(skb, nb)        <- nb->state == STATE_0
      x25_establish_link(nb)
        switch (nb->dev->type)
        ...
        skb->dev = nb->dev;
        dev_queue_xmit(skb);

The heartbeat (x25_check_rbuf()) and the T2 timer
(x25_enquiry_response()) reach the same path through
x25_write_internal().

The worker also passes the stale nb->dev to x25_clear_forward_by_dev().
That function compares raw pointers, so it could match a new device
allocated at the same address.

Would it be better to keep the NETDEV_DOWN teardown synchronous, since it
runs in process context? Or at least flush or cancel kill_work and keep
the device pinned until the work has run?

>  
>  /*
> @@ -269,6 +280,7 @@ void x25_link_device_up(struct net_device *dev)
>  
>  	skb_queue_head_init(&nb->queue);
>  	timer_setup(&nb->t20timer, x25_t20timer_expiry, 0);
> +	INIT_WORK(&nb->kill_work, x25_kill_by_neigh_work);

[Severity: High]
Does anything cancel or flush kill_work on teardown? x25_exit(),
x25_link_free() and x25_link_device_down() never call cancel_work_sync()
or flush_work(). A pending work item does not pin the module.

With no X.25 sockets open, "ip link set <x25dev> down" (NETDEV_DOWN ->
x25_link_terminated() -> schedule_work()) followed right away by
"rmmod x25" is allowed.

x25_exit() -> x25_link_free() then drops the list references. nb stays
allocated because the work holds a reference. However, the module text
and data are freed before system_percpu_wq runs the item. That covers
x25_kill_by_neigh_work(), x25_list_lock, x25_list and x25_forward_list.

There is also an ordering question in x25_exit():

	x25_proc_exit();
	x25_link_free();
	x25_route_free();
	...
	unregister_netdevice_notifier(&x25_dev_notifier);

	dev_remove_pack(&x25_packet_type);

A receive or notifier call that is already in progress, holding an nb
from x25_get_neigh(), could still queue kill_work after x25_link_free().

Would a dedicated workqueue cover this, destroyed at the end of
x25_exit() after packet reception and the notifier have been shut down?

>  
>  	dev_hold(dev);
>  	nb->dev      = dev;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/tencent_F7C2DC0FA42B5866E5C39A9E70D3C52C2609%40qq.com
