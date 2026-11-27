Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760903;
	b=0Gc+c76epdtArzCLCuHuaO3C9msCUjbZnJx5r8eDnhs8Sns1IzSWjeJjk5YtoOeaMi05
	 rJq1cYIkeh4HB0JdITiFcWqEoc0sMRNWQhlh3siiDTlpzZvSlUrf0pbb8OUddX9YC73J+
	 XtE215g499eio7v5irNPggtOuH1Ih2l4CgzDV8TIpbu/8+iDq4IUxHVkqhc1Cg8vqe5ag
	 y+SgNNgILT/WEBCbXej+ijX7VfRyl3e8q0YHRWcj8B9a2DOsW1jtoSvnqRNj5WLlu8UOd
	 BTmGHolwOwJQGhL8TTQqYQtUhfmLXMCaFOM++dgV3CM4v2nFyv4k7wIEovutOpjsB2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760903;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Spam-Status:
	 X-Spam-Checker-Version:X-purgate-type:X-purgate-ID:X-purgate;
	bh=N3MMDPA3sEGyLVW0UrxIXlEJYxRkoAC/NRx5aD+1dXU=;
	b=vJc9gttR0sJAZS96/Y57ETDtW9IJ6s2eiSt3CjOtyNSDEdCsPZkt93TpglFfxsQstfzR
	 f4QkJrUyk6tgzHzoXtC+qvPeU8z8Z7gVhL1CLk9Cko7UO624klMlrV6dhz28d+BOiGSRG
	 9V9/14bQM8Ujq6mnK/BKuys94kovSJkDHqrNfgbLKPhtQAkNkwAniisxTG1i76xp9Tyx5
	 P7DonIRr0UaIq96TbS9/4asIovUlqguQPrEFT54avumzJvJ4oY6dOJ1c3s9V72mb0WwQT
	 ENdDvwhxMK/0I+nMuDvnMd2AkJc48UHXES0sTfpFkyrdIPRiE3SjktgEHw5Ysw7+eHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=GVVLrnaL;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45101606A321;
	Fri, 27 Nov 2026 06:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45101606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=GVVLrnaL
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68051b93b8=ms@dev.tdt.de>)
	id 1xWpRN-0017A4-DJ; Fri, 27 Nov 2026 07:28:13 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xWpRM-00EYlv-1q; Fri, 27 Nov 2026 07:28:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795760891;
	bh=N3MMDPA3sEGyLVW0UrxIXlEJYxRkoAC/NRx5aD+1dXU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GVVLrnaLrfkpYt0z8bTj/D3D630kyhqSGOQD5U0UEcpQTkW4cMrbVrPlVW5WQcsYi
	 XTzLWqNSkI04au9je+otOBJE+1s71KJAJwy4dsdISz4gNGKa0A8Hsnv4t12kJWGzBD
	 WslFm3sEuMPSR1TOgyM9P4y/BPM4zZXPK2ODcR+yEAWcQvIqdjbVfkYZSc9rQJM3p7
	 HjCzSrYi7dEGMafI7siQ11E4t36qCz98k5h6N0haAM86Lee8V1XY3PcJoI5UTw6fw7
	 VgXJHePBep6WJoSFk5Jp1OoQ7DQzLqnnq7nMMPkv5MOgAii71dXVjQvu5RgCkA0WXZ
	 wY2GuzKpB+mTg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 5A5B7240042;
	Fri, 27 Nov 2026 07:28:11 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4CA4E240036;
	Fri, 27 Nov 2026 07:28:11 +0100 (CET)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id D3C402B137;
	Fri, 27 Nov 2026 07:28:10 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
Date: Fri, 27 Nov 2026 07:28:05 +0100 (CET)
Subject: [PATCH net v2 1/2] net/x25: don't call lock_sock() from softirq in
 x25_kill_by_neigh()
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-x25-kill-by-neigh-v2-1-c7cdcc9f1320@dev.tdt.de>
References: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
In-Reply-To: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Shuai Liu <847807867@qq.com>,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795760890; l=8022;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=2+W7uLJL1NSBT4yj1AUVcavZUVv5YSQ1YDVZVs3CPjs=;
 b=VwojJRZWU4eE+LKlHtGmUjRb9OWuGZ91lHI0v3Nk5cY7l5ENEBThsPIVJ6srQIwB2R1mIqb0d
 64ly5smttMVD3mlTIEy2rHmv+gBpI8FZ8oJq8fyhsCalU66+MhEQGdn
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate-type: clean
X-purgate-ID: 151534::1795760892-59417D96-FE40B1FA/0/0
X-purgate: clean

From: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>

x25_kill_by_neigh() is reached from the receive path when the link layer
goes away or the peer restarts:

  net_rx_action()
    lapbeth_napi_poll()
      x25_lapb_receive_frame()
        x25_link_terminated() / x25_link_control()
          x25_kill_by_neigh()
            lock_sock()

lock_sock() may sleep, which is not allowed in softirq context:

  BUG: sleeping function called from invalid context at net/core/sock.c:3832
  in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 29, name: ktimers/1
  RCU nest depth: 2, expected: 0
  ...
   lock_sock_nested+0x56/0x130 net/core/sock.c:3832
   x25_kill_by_neigh+0x134/0x2a0 net/x25/af_x25.c:1778
   x25_lapb_receive_frame+0x1b0/0xfb0 net/x25/x25_dev.c:138

Take the socket spinlock instead, the same way the x25 timers and receive
path already do. If the socket is not owned by user, disconnect it right
away. If it is, mark it with X25_KILL_FLAG and let a new release_cb do
the disconnect when the owner releases the socket. This keeps the
serialization against x25_sendmsg()/x25_recvmsg()/x25_connect() that
commit 7781607938c8 ("net/x25: Fix null-ptr-deref caused by
x25_disconnect") added lock_sock() for. Sockets that already have the
flag set are skipped, so the rescan loop always terminates.

NETDEV_DOWN runs in process context and the device may be freed right
after, so keep waiting for socket owners there as before: a sleeping
sweep makes sure no socket still uses the neighbour on return.

Until its owner releases it, a flagged socket still holds the LCI of a
call that no longer exists, while x25_link_control() may already have
confirmed the restart and the peer may reuse that LCI. Skip flagged
sockets in __x25_find_socket(), so that frames for a reused LCI no
longer end up in the old socket's backlog, and keep flagged sockets from
transmitting in x25_kick() and x25_write_internal(). The deferred
x25_disconnect() only changes local state, so the old call is gone on
the wire before the restart is answered, as it was before.

x25_connect() accepts a listening socket, so a listener can carry the
flag. Clear it in x25_make_new(), which copies the listener's flags.

Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by x25_disconnect")
Reported-by: syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9faa82ae2e94c5c7d2ef
Reported-by: syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6
Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
[ms: hide flagged sockets from __x25_find_socket() and from
 transmission, clear the flag in x25_make_new(), add the current
 syzbot report]
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 include/net/x25.h  |  1 +
 net/x25/af_x25.c   | 66 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 net/x25/x25_out.c  |  3 ++-
 net/x25/x25_subr.c |  4 ++++
 4 files changed, 67 insertions(+), 7 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index 414f3fd99345455dd30f0cc827736fbce61fd99a..ed8ba01fa3cb396f80344a23f4de8d23d5e4a010 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -118,6 +118,7 @@ enum {
 #define X25_Q_BIT_FLAG		0
 #define X25_INTERRUPT_FLAG	1
 #define X25_ACCPT_APPRV_FLAG	2
+#define X25_KILL_FLAG		3
 
 /**
  *	struct x25_route - x25 routing entry
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index f45c9ec7d2c68354838b1bfa34ea4ca08120dc8d..a5d3a86918a0f4f337af4566dde4b43a907d1b49 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -200,6 +200,32 @@ static void x25_remove_socket(struct sock *sk)
 	write_unlock_bh(&x25_list_lock);
 }
 
+/*
+ * Process context only: wait for owners that x25_kill_by_neigh() deferred,
+ * so no socket still uses nb once the device goes away.
+ */
+static void x25_kill_by_neigh_sync(struct x25_neigh *nb)
+{
+	struct sock *s;
+
+again:
+	write_lock_bh(&x25_list_lock);
+
+	sk_for_each(s, &x25_list) {
+		if (x25_sk(s)->neighbour == nb) {
+			sock_hold(s);
+			write_unlock_bh(&x25_list_lock);
+			lock_sock(s);
+			if (x25_sk(s)->neighbour == nb)
+				x25_disconnect(s, ENETUNREACH, 0, 0);
+			release_sock(s);
+			sock_put(s);
+			goto again;
+		}
+	}
+	write_unlock_bh(&x25_list_lock);
+}
+
 /*
  *	Handle device status changes.
  */
@@ -222,6 +248,7 @@ static int x25_device_event(struct notifier_block *this, unsigned long event,
 			nb = x25_get_neigh(dev);
 			if (nb) {
 				x25_link_terminated(nb);
+				x25_kill_by_neigh_sync(nb);
 				x25_neigh_put(nb);
 			}
 			x25_route_device_down(dev);
@@ -311,7 +338,8 @@ static struct sock *__x25_find_socket(unsigned int lci, struct x25_neigh *nb)
 	struct sock *s;
 
 	sk_for_each(s, &x25_list)
-		if (x25_sk(s)->lci == lci && x25_sk(s)->neighbour == nb) {
+		if (x25_sk(s)->lci == lci && x25_sk(s)->neighbour == nb &&
+		    !test_bit(X25_KILL_FLAG, &x25_sk(s)->flags)) {
 			sock_hold(s);
 			goto found;
 		}
@@ -492,10 +520,20 @@ static int x25_listen(struct socket *sock, int backlog)
 	return rc;
 }
 
+/* Finish a link teardown that hit while the socket was owned by user. */
+static void x25_release_cb(struct sock *sk)
+{
+	struct x25_sock *x25 = x25_sk(sk);
+
+	if (test_and_clear_bit(X25_KILL_FLAG, &x25->flags) && x25->neighbour)
+		x25_disconnect(sk, ENETUNREACH, 0, 0);
+}
+
 static struct proto x25_proto = {
 	.name	  = "X25",
 	.owner	  = THIS_MODULE,
 	.obj_size = sizeof(struct x25_sock),
+	.release_cb = x25_release_cb,
 };
 
 static struct sock *x25_alloc_socket(struct net *net, int kern)
@@ -610,6 +648,7 @@ static struct sock *x25_make_new(struct sock *osk)
 	x25->cudmatchlength = ox25->cudmatchlength;
 
 	clear_bit(X25_INTERRUPT_FLAG, &x25->flags);
+	clear_bit(X25_KILL_FLAG, &x25->flags);
 	x25_init_timers(sk);
 out:
 	return sk;
@@ -1761,6 +1800,23 @@ static struct notifier_block x25_dev_notifier = {
 	.notifier_call = x25_device_event,
 };
 
+/* May run in softirq, so lock_sock() is not an option. */
+static void x25_kill_sock(struct sock *sk, struct x25_neigh *nb)
+{
+	struct x25_sock *x25 = x25_sk(sk);
+
+	local_bh_disable();
+	bh_lock_sock(sk);
+	if (x25->neighbour == nb) {
+		if (sock_owned_by_user(sk))
+			set_bit(X25_KILL_FLAG, &x25->flags);
+		else
+			x25_disconnect(sk, ENETUNREACH, 0, 0);
+	}
+	bh_unlock_sock(sk);
+	local_bh_enable();
+}
+
 void x25_kill_by_neigh(struct x25_neigh *nb)
 {
 	struct sock *s;
@@ -1769,13 +1825,11 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 	write_lock_bh(&x25_list_lock);
 
 	sk_for_each(s, &x25_list) {
-		if (x25_sk(s)->neighbour == nb) {
+		if (x25_sk(s)->neighbour == nb &&
+		    !test_bit(X25_KILL_FLAG, &x25_sk(s)->flags)) {
 			sock_hold(s);
 			write_unlock_bh(&x25_list_lock);
-			lock_sock(s);
-			if (x25_sk(s)->neighbour == nb)
-				x25_disconnect(s, ENETUNREACH, 0, 0);
-			release_sock(s);
+			x25_kill_sock(s, nb);
 			sock_put(s);
 			goto again;
 		}
diff --git a/net/x25/x25_out.c b/net/x25/x25_out.c
index f8922b0e23a4f17c1f5f74aa24806a35325e92dd..f710d015fcc2ffd6a6922a0c29876bb248125666 100644
--- a/net/x25/x25_out.c
+++ b/net/x25/x25_out.c
@@ -140,7 +140,8 @@ void x25_kick(struct sock *sk)
 	int modulus;
 	struct x25_sock *x25 = x25_sk(sk);
 
-	if (x25->state != X25_STATE_3)
+	if (x25->state != X25_STATE_3 ||
+	    test_bit(X25_KILL_FLAG, &x25->flags))
 		return;
 
 	/*
diff --git a/net/x25/x25_subr.c b/net/x25/x25_subr.c
index 159708d9ad20cb2e6db24ead67daf1e9d6258f64..dba3b8eb10b0f21402592fe5775e1670f68ed4ee 100644
--- a/net/x25/x25_subr.c
+++ b/net/x25/x25_subr.c
@@ -120,6 +120,10 @@ void x25_write_internal(struct sock *sk, int frametype)
 	 */
 	int len = X25_MAX_L2_LEN + X25_EXT_MIN_LEN;
 
+	/* The call has already been cleared by a link failure or restart */
+	if (test_bit(X25_KILL_FLAG, &x25->flags))
+		return;
+
 	/*
 	 *	Adjust frame size.
 	 */

-- 
2.47.3

