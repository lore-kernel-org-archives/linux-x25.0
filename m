From: David Miller <davem@davemloft.net>
Subject: Re: x25: possible skb leak on bad facilities
Date: Sun, 06 Feb 2011 20:28:24 -0800 (PST)
Message-ID: <20110206.202824.260090071.davem@davemloft.net>
References: <20110131130826.GC16804@shadowen.org>
	<AANLkTik-ywwtNg2AxAXtsKYJviDp=1zCZ-43JXp9i3g6@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <AANLkTik-ywwtNg2AxAXtsKYJviDp=1zCZ-43JXp9i3g6@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: andrew.hendry@gmail.com
Cc: apw@canonical.com, john@calva.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, tim.gardner@canonical.com

From: Andrew Hendry <andrew.hendry@gmail.com>
Date: Tue, 1 Feb 2011 22:55:13 +1100

> There are two callers, when I was crashing it I don't remember it
> using the backlog path.
> x25_process_rx_frame is called from both x25_backlog_rcv and also
> x25_receive_data (via x25_lapb_receive_frame)
> 
> But reviewing that second path now it looks like it will also leak, -1
> would make it skip the kfree_skb there as well.
> So patch looks good to me, when I have some time I'll run it through
> the environment I had setup originally to confirm.

Andrew, have you had a chance to do this yet?
