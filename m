From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 2/2] wan/hdlc_x25: fix skb handling
Date: Tue, 21 Jan 2020 11:41:59 +0100 (CET)
Message-ID: <20200121.114159.2274824592420675035.davem@davemloft.net>
References: <20200121060034.30554-1-ms@dev.tdt.de>
        <20200121060034.30554-2-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200121060034.30554-2-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: kubakici@wp.pl, khc@pm.waw.pl, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 21 Jan 2020 07:00:34 +0100

>  o call skb_reset_network_header() before hdlc->xmit()
>  o change skb proto to HDLC (0x0019) before hdlc->xmit()
>  o call dev_queue_xmit_nit() before hdlc->xmit()
> 
> This changes make it possible to trace (tcpdump) outgoing layer2
> (ETH_P_HDLC) packets
> 
> Additionally call skb_reset_network_header() after each skb_push() /
> skb_pull().
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied to net-next
