From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next v2] net: hdlc_x25: Remove unnecessary
 skb_reset_network_header calls
Date: Wed, 09 Dec 2020 19:23:51 -0800 (PST)
Message-ID: <20201209.192351.1592604556832105313.davem@davemloft.net>
References: <20201209014013.4996-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201209014013.4996-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de

From: Xie He <xie.he.0141@gmail.com>
Date: Tue,  8 Dec 2020 17:40:13 -0800

> 1. In x25_xmit, skb_reset_network_header is not necessary before we call
> lapb_data_request. The lapb module doesn't need skb->network_header.
> So there is no need to set skb->network_header before calling
> lapb_data_request.
> 
> 2. In x25_data_indication (called by the lapb module after some data
> have been received), skb_reset_network_header is not necessary before we
> call netif_rx. After we call netif_rx, the code in net/core/dev.c will
> call skb_reset_network_header before handing the skb to upper layers
> (in __netif_receive_skb_core, called by __netif_receive_skb_one_core,
> called by __netif_receive_skb, called by process_backlog). So we don't
> need to call skb_reset_network_header by ourselves.
> 
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thanks.
