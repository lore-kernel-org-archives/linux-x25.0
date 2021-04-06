From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v5] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Tue, 06 Apr 2021 16:14:31 -0700 (PDT)
Message-ID: <20210406.161431.1568805748449868568.davem@davemloft.net>
References: <20210402093000.72965-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20210402093000.72965-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: ms@dev.tdt.de, kuba@kernel.org, corbet@lwn.net, khc@pm.waw.pl, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

From: Xie He <xie.he.0141@gmail.com>
Date: Fri,  2 Apr 2021 02:30:00 -0700

> X.25 Layer 3 (the Packet Layer) expects layer 2 to provide a reliable
> datalink service such that no packets are reordered or dropped. And
> X.25 Layer 2 (the LAPB layer) is indeed designed to provide such service.
> 
> However, this reliability is not preserved when a driver calls "netif_rx"
> to deliver the received packets to layer 3, because "netif_rx" will put
> the packets into per-CPU queues before they are delivered to layer 3.
> If there are multiple CPUs, the order of the packets may not be preserved.
> The per-CPU queues may also drop packets if there are too many.
> 
> Therefore, we should not call "netif_rx" to let it queue the packets.
> Instead, we should use our own queue that won't reorder or drop packets.
> 
> This patch changes all X.25 drivers to use their own queues instead of
> calling "netif_rx". The patch also documents this requirement in the
> "x25-iface" documentation.
> 
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>


This no longe applies to net-next, please respin.

Thank you.
