From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Added needed_headroom and a
 skb->len check
Date: Thu, 06 Aug 2020 17:02:05 -0700 (PDT)
Message-ID: <20200806.170205.1316893051509388641.davem@davemloft.net>
References: <20200806015040.98379-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200806015040.98379-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, willemdebruijn.kernel@gmail.com, ms@dev.tdt.de, briannorris@chromium.org

From: Xie He <xie.he.0141@gmail.com>
Date: Wed,  5 Aug 2020 18:50:40 -0700

> 1. Added a skb->len check
> 
> This driver expects upper layers to include a pseudo header of 1 byte
> when passing down a skb for transmission. This driver will read this
> 1-byte header. This patch added a skb->len check before reading the
> header to make sure the header exists.
> 
> 2. Changed to use needed_headroom instead of hard_header_len to request
> necessary headroom to be allocated
> 
> In net/packet/af_packet.c, the function packet_snd first reserves a
> headroom of length (dev->hard_header_len + dev->needed_headroom).
> Then if the socket is a SOCK_DGRAM socket, it calls dev_hard_header,
> which calls dev->header_ops->create, to create the link layer header.
> If the socket is a SOCK_RAW socket, it "un-reserves" a headroom of
> length (dev->hard_header_len), and assumes the user to provide the
> appropriate link layer header.
> 
> So according to the logic of af_packet.c, dev->hard_header_len should
> be the length of the header that would be created by
> dev->header_ops->create.
> 
> However, this driver doesn't provide dev->header_ops, so logically
> dev->hard_header_len should be 0.
> 
> So we should use dev->needed_headroom instead of dev->hard_header_len
> to request necessary headroom to be allocated.
> 
> This change fixes kernel panic when this driver is used with AF_PACKET
> SOCK_RAW sockets.
> 
> Call stack when panic:
 ...
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied and queued up for -stable, thanks.
