From: Stephen Hemminger <shemminger@osdl.org>
Subject: [BUG] use after free in x25_destroy_socket
Date: Mon, 4 Aug 2003 16:37:54 -0700
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <20030804163754.21bc4f70.shemminger@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Henner Eisen <eis@baty.hanse.de>, linux-x25@vger.kernel.org

Got BUG in spinlock unlock from x25_destroy_socket using 2.6.0-test2.
All I did was load X.25 module, then do an ifconfig.

The following looks very suspicious.

void x25_destroy_socket(struct sock *sk)
{
	struct sk_buff *skb;

	sock_hold(sk);
	lock_sock(sk);
	x25_stop_heartbeat(sk);
	x25_stop_timer(sk);

...

	if (atomic_read(&sk->sk_wmem_alloc) ||
	    atomic_read(&sk->sk_rmem_alloc)) {
		/* Defer: outstanding buffers */
		init_timer(&sk->sk_timer);
		sk->sk_timer.expires  = jiffies + 10 * HZ;
		sk->sk_timer.function = x25_destroy_timer;
		sk->sk_timer.data     = (unsigned long)sk;
		add_timer(&sk->sk_timer);
	} else
		sk_free(sk);
	release_sock(sk);		<-- hey, sk was freed in previous line.
	sock_put(sk);			<-- this will BUG because sk has been poisened
}
