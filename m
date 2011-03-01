From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 5/7] x25: remove the BKL
Date: Tue, 01 Mar 2011 15:16:22 -0800 (PST)
Message-ID: <20110301.151622.200374696.davem@davemloft.net>
References: <1299021191-17961-1-git-send-email-arnd@arndb.de>
	<1299021191-17961-6-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1299021191-17961-6-git-send-email-arnd@arndb.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: arnd@arndb.de
Cc: linux-kernel@vger.kernel.org, andrew.hendry@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed,  2 Mar 2011 00:13:09 +0100

> This replaces all instances of lock_kernel in x25
> with lock_sock, taking care to release the socket
> lock around sleeping functions (sock_alloc_send_skb
> and skb_recv_datagram). It is not clear whether
> this is a correct solution, but it seem to be what
> other protocols do in the same situation.
> 
> Includes a fix suggested by Eric Dumazet.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: David S. Miller <davem@davemloft.net>
