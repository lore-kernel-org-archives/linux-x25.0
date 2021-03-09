From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next RFC] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Tue, 09 Mar 2021 14:23:41 +0100
Message-ID: <4b30ca506b0d79ef5ba1a5e9ce9cf2cd@dev.tdt.de>
References: <20210305054312.254922-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <20210305054312.254922-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Halasa <khc@pm.waw.pl>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

On 2021-03-05 06:43, Xie He wrote:
> X.25 Layer 3 (the Packet Layer) expects layer 2 to provide a reliable
> datalink service such that no packets are reordered or dropped. And
> X.25 Layer 2 (the LAPB layer) is indeed designed to provide such 
> service.
> 
> However, this reliability is not preserved when a driver calls 
> "netif_rx"
> to deliver the received packets to layer 3, because "netif_rx" will put
> the packets into per-CPU queues before they are delivered to layer 3.
> If there are multiple CPUs, the order of the packets may not be 
> preserved.
> The per-CPU queues may also drop packets if there are too many.
> 
> Therefore, we should not call "netif_rx" to let it queue the packets.
> Instead, we should use our own queue that won't reorder or drop 
> packets.
> 
> This patch changes all X.25 drivers to use their own queues instead of
> calling "netif_rx". The patch also documents this requirement in the
> "x25-iface" documentation.

I've tested the hdlc_x25 driver.
Looks good to me.

Acked-by: Martin Schiller <ms@dev.tdt.de>
