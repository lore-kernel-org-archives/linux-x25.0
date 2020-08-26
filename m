From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Set network_header
 before transmitting
Date: Wed, 26 Aug 2020 15:51:16 -0700 (PDT)
Message-ID: <20200826.155116.1238002224655277772.davem@davemloft.net>
References: <20200826030353.75645-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200826030353.75645-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, ms@dev.tdt.de

From: Xie He <xie.he.0141@gmail.com>
Date: Tue, 25 Aug 2020 20:03:53 -0700

> Set the skb's network_header before it is passed to the underlying
> Ethernet device for transmission.
> 
> This patch fixes the following issue:
> 
> When we use this driver with AF_PACKET sockets, there would be error
> messages of:
>    protocol 0805 is buggy, dev (Ethernet interface name)
> printed in the system "dmesg" log.
> 
> This is because skbs passed down to the Ethernet device for transmission
> don't have their network_header properly set, and the dev_queue_xmit_nit
> function in net/core/dev.c complains about this.
> 
> Reason of setting the network_header to this place (at the end of the
> Ethernet header, and at the beginning of the Ethernet payload):
> 
> Because when this driver receives an skb from the Ethernet device, the
> network_header is also set at this place.
> 
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thank you.
