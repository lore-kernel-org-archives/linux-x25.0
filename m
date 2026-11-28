Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795850532;
	b=ONk3dt93sTMl5jUNbbwlcDynQRrd1NYGkAz2KMRHJ/10RGkpwwxfTfo9Exi8L1OfXRlT
	 xWgoZ2OLhUCGV0u375+sD3X745zk6voe9vjGByQESYCx54aoLOatp9vZrwUcVDTlcWvwP
	 d7tkGufKmG9s+Xkpjpyoy8kXhHufalWmH1XHj153GLQHax7mqnSzhrxZX6NALtHPWt3c6
	 tFRaol8JnjeLHYTmT2YysPXOB3Ybt7ACXTQ8tEfJvuK3DXb0grmWqDFcoLpqH8kUFcJYC
	 QiRPb3sK+GOIFJ3V1ZejD+Z15Eq9s8Zkoh6kI6s6jNIaSc4g8AdQV26uWoJZ2HLe0mQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795850532;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=d71u1roGNrY5JRc0YE5Qm7fQmnT5P6fD9DXzBTVvZAQ=;
	b=R+js7CJUI4PsHz8iRtJM0b44tyonAP+rYZ7Dgf6xc6rAyDrkp+GeslPXLvtzT7s9ZnZe
	 GgJkhkJLNOQL6ugqSCCTjvydHTu/OiBTBBizFGLXw1J4KPYBfHsNhDcLGcos9Jtb6S8Yh
	 lNvCaaVZ1ksqalSev5d0gF5B8lRIfak/QGRX0IMBV9NtWIzQ5RnKOyjmyvasglqdD3Wy9
	 bOBI27dqjuXqOJ2wQ5dSnp9naURaCjPNi8gYXFdBTI5IRQplpNd5+8iKJK+vIiVPh409T
	 GV/KK5lxZQDJnoxE7adghsivgs4Mw3CA2k6XGKjy928HUVTl8OkP1rwPkksd/9ZV6gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KINfl53a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C375F606A31C;
	Sat, 28 Nov 2026 07:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KINfl53a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5011F00893;
	Sat, 28 Nov 2026 07:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795850532;
	bh=d71u1roGNrY5JRc0YE5Qm7fQmnT5P6fD9DXzBTVvZAQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KINfl53aPvQoTcoexNTZYWkAwXZufPXqkiIYW1X/ySYWEgVVsBfuqkF5XEVIuMKD4
	 SI5ZbnCZVxgF58AFmgOk/zFGy5DYa/67JP58TX38ADAYiYqkzWfuhr0jnVp+Opp6d7
	 1BIh1LmHFHrzD6dn0VQJoQBcPNd7ynJe0BTNM/EzLMl4XiEFhOV4QgHhSAFxn1zbrK
	 pOBuelbi42B4yt/yNSE2nxMQf/HgdKM5CksTx07szASivIvb/yQKHpTZGz10/J/6ZV
	 DvReb5gn+ApwexelMcaTlCl1WS3bCoDD/sGI0xsAdyouJT7rqL4HTm0gE0iN1uoKsk
	 F0KQLeG25iwhA==
Subject: Re: [PATCH net v2 1/2] net/x25: don't call lock_sock() from softirq
 in x25_kill_by_neigh()
From: netdev-bot+sashiko@kernel.org
To: ms@dev.tdt.de
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, horms@kernel.org, linma@zju.edu.cn,
 duoming@zju.edu.cn, xiyuyang19@fudan.edu.cn, tanxin.ctf@gmail.com,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 ngocthang2710.1999@gmail.com, 847807867@qq.com, krystianmkaniewski@gmail.com,
 syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
 syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
Date: Sat, 28 Nov 2026 07:22:11 +0000
Message-ID: <179585053119.3135.1065383095936227619@kernel.org>
In-Reply-To: <20261127-x25-kill-by-neigh-v2-1-c7cdcc9f1320@dev.tdt.de>
References: <20261127-x25-kill-by-neigh-v2-1-c7cdcc9f1320@dev.tdt.de>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] net/x25/af_x25.c: the patch adds `!test_bit(X25_KILL_FLAG,
  ...)` to __x25_find_socket().
- [Medium] The X25_KILL_FLAG checks that the patch adds in x25_kick()
  (net/x25/x25_out.c) and x25_write_internal() (net/x25/x25_subr.c) are…

--

net/x25: don't call lock_sock() from softirq in x25_kill_by_neigh()

This patch stops x25_kill_by_neigh() from calling lock_sock() in softirq.
It now takes the socket spinlock. A socket that is not owned by user is
disconnected immediately. An owned socket is marked with X25_KILL_FLAG,
and a new release_cb disconnects it later. Flagged sockets are also
hidden from __x25_find_socket() and kept from transmitting in x25_kick()
and x25_write_internal().

> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index f45c9ec7d2c68..a5d3a86918a0f 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c

[ ... ]

> @@ -311,7 +338,8 @@ static struct sock *__x25_find_socket(unsigned int lci, struct x25_neigh *nb)
>  	struct sock *s;
>  
>  	sk_for_each(s, &x25_list)
> -		if (x25_sk(s)->lci == lci && x25_sk(s)->neighbour == nb) {
> +		if (x25_sk(s)->lci == lci && x25_sk(s)->neighbour == nb &&
> +		    !test_bit(X25_KILL_FLAG, &x25_sk(s)->flags)) {
>  			sock_hold(s);
>  			goto found;
>  		}

[Severity: Medium]
Does this change also affect x25_new_lci()? It uses the same lookup to
pick a free LCI:

net/x25/af_x25.c:x25_new_lci() {
    ...
	while ((sk = x25_find_socket(lci, nb)) != NULL) {
		sock_put(sk);
    ...
}

Since flagged sockets are now skipped, x25_connect() can give a new
socket B an LCI L that a flagged socket A on the same neighbour still
holds. Socket A is owned by user and is waiting for x25_release_cb().

The comments above __x25_find_socket() ("Find a connected X.25 socket
given my LCI and neighbour") and x25_new_lci() ("Find a unique LCI for a
given device") also no longer describe what the code does.

Most of the time A stays hidden. However, x25_release_cb() clears the
flag before x25_disconnect() gets to x25->lci = 0:

	if (test_and_clear_bit(X25_KILL_FLAG, &x25->flags) && x25->neighbour)
		x25_disconnect(sk, ENETUNREACH, 0, 0);

x25_disconnect() first runs x25_clear_queues() and x25_stop_timer(), and
only then sets lci to 0. During that window, lockless lookups for (L, nb)
can match A again.

Could a concurrent x25_receive_data() in softirq pick A instead of B?

x25_receive_data()
  x25_find_socket(L, nb)   <- returns A if A is ahead of B in x25_list
  bh_lock_sock(A)          <- spins until release_sock() finishes
  x25_process_rx_frame(A)  <- A is in X25_STATE_0, returns 0, frame freed

x25_insert_socket() adds at the head of x25_list, so A comes first if it
was bound after B. If the owner locks A again first, the frame goes into
A's backlog. The commit message says that should no longer happen.

Either way, it looks like a frame for B's new call (for example CALL
ACCEPTED or DATA) is lost.

The commit message only covers LCI reuse by the peer. Peer-initiated
calls are inserted at the head in x25_rx_call_request(), so they are
found first. Local allocation through x25_new_lci() is not covered by
that reasoning.

[ ... ]

> diff --git a/net/x25/x25_out.c b/net/x25/x25_out.c
> index f8922b0e23a4f..f710d015fcc2f 100644
> --- a/net/x25/x25_out.c
> +++ b/net/x25/x25_out.c
> @@ -140,7 +140,8 @@ void x25_kick(struct sock *sk)
>  	int modulus;
>  	struct x25_sock *x25 = x25_sk(sk);
>  
> -	if (x25->state != X25_STATE_3)
> +	if (x25->state != X25_STATE_3 ||
> +	    test_bit(X25_KILL_FLAG, &x25->flags))
>  		return;
>  
>  	/*

[Severity: Medium]
Is this check enough to keep a flagged socket from transmitting?

x25_kick() runs in owner context, for example from x25_sendmsg() under
lock_sock(). That caller holds ownership but not sk_lock.slock.
x25_kill_sock() sets the bit under bh_lock_sock() only and returns right
away, so nothing orders the two.

Consider a peer RESTART REQUEST arriving in X25_LINK_STATE_3:

CPU0 (owner, x25_sendmsg())     CPU1 (softirq)
x25_kick()
  test_bit() == 0
  enters transmit loop
                                x25_link_control()
                                  x25_kill_by_neigh()
                                    x25_kill_sock()
                                      sock_owned_by_user() -> true
                                      set_bit(X25_KILL_FLAG)
                                  x25_transmit_restart_confirmation()
  x25_send_iframe()
    x25_transmit_link()

nb->state is still X25_LINK_STATE_3, so the I-frames for the old LCI go
straight to the device. The bit is tested only once, before a loop that
can send up to winsize_out frames.

x25_write_internal() has the same check-once-then-send pattern. Its
owner-context callers include x25_release() (X25_CLEAR_REQUEST),
x25_ioctl(SIOCX25SENDCALLACCPT) (X25_CALL_ACCEPTED) and x25_connect().

Can frames for the restarted call still go out after RESTART
CONFIRMATION? That would contradict this part of the commit message:

    The deferred
    x25_disconnect() only changes local state, so the old call is gone on
    the wire before the restart is answered, as it was before.

If the LCI has already been reused, either by the peer or locally through
x25_new_lci(), could those stale frames land on an unrelated call?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320%40dev.tdt.de
