Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801184C224C;
	Mon,  5 Oct 2026 15:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213644; cv=none; b=n2r413PdWhSNY+7CA++sbcsTYpljWMcOR2lzOzMBZbpXBr3/jPKPaWRuPivC2zoxNeivm7b1IBBgxjHBvx7Yn8neAAk8oJg8wSH2TI0wIptpBY2k/f514Epp7Yj+MVykLClL4hNs/03sNBQvUpq4kYgeaFdfJAc/RnlrOqc+D2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213644; c=relaxed/simple;
	bh=m+geoa7sqgjtiAAaIl12GrIqmVWw2b/2v7tYNtQ1+yg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EGfgWzwUrTm16c03SjOHwXmwMTVRLPZnlmL3XcEYjjbXFD7pYlz7+x1OotyZa7/sEkJmlTL5RhOzTS3X1zlyiaSrJhLl91s6NYX6RCikC74JtS5IwGM5U7PVM8PqlXcBx+Vdtr0vMSVadILTansRJFVfybSKO8MJ74a5mZdqyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7b3NiFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7b3NiFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8091F000FF;
	Mon,  5 Oct 2026 15:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791213643;
	bh=D23wEKcHFE8exia2wYG9a025ElQqIYJw5G+VPC0O2qk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m7b3NiFmQ40VKu+ArUfJhVj5YEtUU3sPDNL3Ij+3Aa6+yxeLB8YcUhvPFiAxTNt4+
	 zNtSlz9uzTFSQYSjXLOYEfRJHq2pPn4u0xYe8iThLn7Qq2CF6A+ZvDAl3DwnAfeoU1
	 d1dYUHfJq0CuzVOjuaW3aJgNmSTr/X06RvBpMokDXUFSKrgZUxCyXoj0UHGN1/Eh6Y
	 Hc2063eNDIwv+OkXJ+NR8x3aPekYnzfMrHu0rtoLkaUgZDbevko52ORR/KddJL5eSF
	 kCneIa5Az2cSXZAtkvuctPYJaZWNJ0Y9lb16gDWp+Jgrxs3SJlAAen0tfZ5On2rwLw
	 w7z7dI7gXvaYA==
Subject: Re: [PATCH net] net/x25: don't call lock_sock() from softirq in
 x25_kill_by_neigh()
From: netdev-bot+sashiko@kernel.org
To: ngocthang2710.1999@gmail.com
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, duoming@zju.edu.cn, linma@zju.edu.cn,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com
Date: Mon, 05 Oct 2026 15:20:42 +0000
Message-ID: <179121364205.434549.10310203820251738113@kernel.org>
In-Reply-To: <20261001150118.128470-1-ngocthang2710.1999@gmail.com>
References: <20261001150118.128470-1-ngocthang2710.1999@gmail.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (1) · Medium: 1 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds a deferred-kill state.
- [Low] x25_make_new() copies the parent's whole flags word into the
  child (`x25->flags = ox25->flags;`) and clears only X25_INTERRUPT_FLAG.

Pre-existing issues:
- [High] x25_sendmsg() checks `if (!x25->neighbour)` under lock_sock().
- [Medium] On NETDEV_DOWN, x25_device_event() runs under RTNL and calls
  the new x25_kill_by_neigh_sync().

--

net/x25: don't call lock_sock() from softirq in x25_kill_by_neigh()

x25_kill_by_neigh() can be reached from softirq. This patch replaces its
lock_sock() with bh_lock_sock(). Sockets not owned by user are
disconnected right away. Owned sockets are marked with X25_KILL_FLAG, and
a new x25_release_cb() disconnects them on release_sock(). NETDEV_DOWN
also runs a sleeping x25_kill_by_neigh_sync() sweep.

> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index 033e7d059f58c..4f9ca22231ac7 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -200,6 +200,32 @@ static void x25_remove_socket(struct sock *sk)
>  	write_unlock_bh(&x25_list_lock);
>  }
>  
> +/*
> + * Process context only: wait for owners that x25_kill_by_neigh() deferred,
> + * so no socket still uses nb once the device goes away.
> + */
> +static void x25_kill_by_neigh_sync(struct x25_neigh *nb)
> +{
> +	struct sock *s;
> +
> +again:
> +	write_lock_bh(&x25_list_lock);
> +
> +	sk_for_each(s, &x25_list) {
> +		if (x25_sk(s)->neighbour == nb) {
> +			sock_hold(s);
> +			write_unlock_bh(&x25_list_lock);
> +			lock_sock(s);

[Severity: Medium]
This isn't a bug introduced by this patch, but can this sweep hold RTNL
indefinitely?

x25_device_event() handles NETDEV_DOWN with RTNL held and calls
x25_kill_by_neigh_sync(). That function sleeps in lock_sock() for each
socket on nb. Meanwhile, x25_sendmsg() holds the socket lock across the
user copy:

net/x25/af_x25.c:x25_sendmsg() {
    ...
	rc = memcpy_from_msg(skb_transport_header(skb), msg, len);
    ...
}

If the user buffer is backed by userfaultfd or FUSE, the user can stall
that copy for as long as they like. A later "ip link set <dev> down"
would then block here with RTNL held.

The old x25_kill_by_neigh() made the same lock_sock() call from the same
notifier. The commit message keeps this on purpose ("keep waiting for
socket owners there as before"), so the new helper carries it forward.

> +			if (x25_sk(s)->neighbour == nb)
> +				x25_disconnect(s, ENETUNREACH, 0, 0);

[ ... ]

> @@ -495,10 +522,20 @@ static int x25_listen(struct socket *sock, int backlog)
>  	return rc;
>  }
>  
> +/* Finish a link teardown that hit while the socket was owned by user. */
> +static void x25_release_cb(struct sock *sk)
> +{
> +	struct x25_sock *x25 = x25_sk(sk);
> +
> +	if (test_and_clear_bit(X25_KILL_FLAG, &x25->flags) && x25->neighbour)
> +		x25_disconnect(sk, ENETUNREACH, 0, 0);

[Severity: Low]
Can X25_KILL_FLAG be inherited by a child socket?

x25_make_new() copies the whole flags word from the listener and clears
only X25_INTERRUPT_FLAG:

net/x25/af_x25.c:x25_make_new() {
    ...
	x25->flags	= ox25->flags;
    ...
	clear_bit(X25_INTERRUPT_FLAG, &x25->flags);
    ...
}

x25_connect() does not reject TCP_LISTEN sockets, and it assigns
x25->neighbour while it owns the socket. A link kill during connect()
can therefore set X25_KILL_FLAG on a socket that was listening.

x25_rx_call_request() clones the listener without taking its socket
lock. A child created in that window would inherit the bit, even though
its own neighbour is healthy.

x25_release_cb() does not check which neighbour caused the kill. The
child's first release_sock() after accept() would then disconnect its
call with ENETUNREACH, and no CLEAR is sent to the peer.

The sequence is contrived. Should x25_make_new() also clear
X25_KILL_FLAG?

> +}
> +

[ ... ]

> @@ -1764,6 +1801,23 @@ static struct notifier_block x25_dev_notifier = {
>  	.notifier_call = x25_device_event,
>  };
>  
> +/* May run in softirq, so lock_sock() is not an option. */
> +static void x25_kill_sock(struct sock *sk, struct x25_neigh *nb)
> +{
> +	struct x25_sock *x25 = x25_sk(sk);
> +
> +	local_bh_disable();
> +	bh_lock_sock(sk);
> +	if (x25->neighbour == nb) {
> +		if (sock_owned_by_user(sk))
> +			set_bit(X25_KILL_FLAG, &x25->flags);

[Severity: Medium]
While the flag is set, x25->lci and x25->neighbour stay unchanged until
x25_release_cb() runs. __x25_find_socket() matches on only those two
fields:

	if (x25_sk(s)->lci == lci && x25_sk(s)->neighbour == nb) {

Could a new incoming call on the same LCI end up on the stale socket's
backlog?

In X25_LINK_STATE_3, x25_link_control() acknowledges a restart as soon
as x25_kill_by_neigh() returns:

		case X25_LINK_STATE_3:
			/* clear existing virtual calls */
			x25_kill_by_neigh(nb);

			x25_transmit_restart_confirmation(nb);

>From then on the peer treats every LCI as free. Suppose it sends a
CALL_REQUEST on an LCI still held by a flagged, user-owned socket.
x25_receive_data() finds that socket before it checks the frame type:

	if ((sk = x25_find_socket(lci, nb)) != NULL) {
		...
			queued = !sk_add_backlog(sk, skb, READ_ONCE(sk->sk_rcvbuf));
	...
	if (frametype == X25_CALL_REQUEST)
		return x25_rx_call_request(skb, nb, lci);

The call therefore never reaches x25_rx_call_request().

release_sock() replays the backlog before it calls release_cb, so the
old connection's state machine handles the CALL_REQUEST. In
X25_STATE_1, x25_state1_machine() treats it as a call collision and
clears the peer's new call:

	case X25_CALL_REQUEST:
		/* call collision */
		...
		x25_write_internal(sk, X25_CLEAR_REQUEST);
		x25_disconnect(sk, EISCONN, 0x01, 0x48);

In X25_STATE_3 the frame is dropped as unknown, and x25_release_cb()
then disconnects the socket.

Before 7781607938c8 the disconnect was immediate. The lock_sock()
version waited for the owner. Either way, the old (lci, nb) binding was
gone before the restart was answered.

This window also seems to contradict the note after the commit message
that a link that comes back quickly cannot have stale state kill
freshly connected calls.

Should the lookup skip sockets with X25_KILL_FLAG set? Alternatively,
the lci/neighbour binding could be dropped at kill time.

> +		else
> +			x25_disconnect(sk, ENETUNREACH, 0, 0);

[Severity: High]
This is a pre-existing issue, but the immediate disconnect here still
seems to race with x25_sendmsg().

x25_sendmsg() checks x25->neighbour under lock_sock(). It then drops
the lock around the skb allocation, and afterwards checks only skb:

	release_sock(sk);
	skb = sock_alloc_send_skb(sk, size, noblock, &rc);
	lock_sock(sk);
	if (!skb)
		goto out;

While the lock is dropped the socket is not owned. Two paths can then
run x25_disconnect() and set x25->neighbour to NULL:

  - this branch of x25_kill_sock(), reached from a RESTART or LAPB
    disconnect via x25_kill_by_neigh()
  - a remote CLEAR_REQUEST through x25_state3_machine()

sock_alloc_send_pskb() checks sk_err and SEND_SHUTDOWN only before it
allocates. A disconnect during the allocation or the relock goes
unnoticed, and the sender then reaches this before any TCP_ESTABLISHED
recheck:

	if (msg->msg_flags & MSG_OOB) {
		if (x25->neighbour->extended) {

The non-OOB branch has the same dereference. Can a remote peer trigger
a NULL pointer dereference this way?

The fragmentation loop in x25_output() has the same pattern. Each
fragment does release_sock() / sock_alloc_send_skb() / lock_sock(),
followed by an unchecked x25->neighbour->extended.

The old lock_sock() in x25_kill_by_neigh() could take the lock in the
same window, so this predates the patch. Still, the claim about keeping
the 7781607938c8 serialization holds only as far as that earlier fix
went.

> +	}
> +	bh_unlock_sock(sk);
> +	local_bh_enable();
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001150118.128470-1-ngocthang2710.1999%40gmail.com
