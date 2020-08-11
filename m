From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and
 a skb->len check
Date: Tue, 11 Aug 2020 10:32:25 -0700 (PDT)
Message-ID: <20200811.103225.204767763010456044.davem@davemloft.net>
References: <20200809023548.684217-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200809023548.684217-1-xie.he.0141@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, willemdebruijn.kernel@gmail.com, ms@dev.tdt.de

From: Xie He <xie.he.0141@gmail.com>
Date: Sat,  8 Aug 2020 19:35:48 -0700

> 1. Added a skb->len check
> 
> This driver expects upper layers to include a pseudo header of 1 byte
> when passing down a skb for transmission. This driver will read this
> 1-byte header. This patch added a skb->len check before reading the
> header to make sure the header exists.
> 
> 2. Added needed_headroom
> 
> When this driver transmits data,
>   first this driver will remove a pseudo header of 1 byte,
>   then the lapb module will prepend the LAPB header of 2 or 3 bytes.
> So the value of needed_headroom in this driver should be 3 - 1.
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thank you.
