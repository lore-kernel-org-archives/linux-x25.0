From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] drivers/net/wan/hdlc_x25: Added needed_headroom
 and a skb->len check
Date: Fri, 14 Aug 2020 20:41:21 -0700 (PDT)
Message-ID: <20200814.204121.2301287009173291675.davem@davemloft.net>
References: <20200813181704.62694-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200813181704.62694-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, willemdebruijn.kernel@gmail.com, ms@dev.tdt.de, andrew.hendry@gmail.com

From: Xie He <xie.he.0141@gmail.com>
Date: Thu, 13 Aug 2020 11:17:04 -0700

> 1. Added a skb->len check
> 
> This driver expects upper layers to include a pseudo header of 1 byte
> when passing down a skb for transmission. This driver will read this
> 1-byte header. This patch added a skb->len check before reading the
> header to make sure the header exists.
> 
> 2. Added needed_headroom and set hard_header_len to 0
> 
> When this driver transmits data,
>   first this driver will remove a pseudo header of 1 byte,
>   then the lapb module will prepend the LAPB header of 2 or 3 bytes.
> So the value of needed_headroom in this driver should be 3 - 1.
> 
> Because this driver has no header_ops, according to the logic of
> af_packet.c, the value of hard_header_len should be 0.
> 
> Reason of setting needed_headroom and hard_header_len at this place:
> 
> This driver is written using the API of the hdlc module, the hdlc
> module enables this driver (the protocol driver) to run on any hardware
> that has a driver (the hardware driver) written using the API of the
> hdlc module.
> 
> Two other hdlc protocol drivers - hdlc_ppp and hdlc_raw_eth, also set
> things like hard_header_len at this place. In hdlc_ppp, it sets
> hard_header_len after attach_hdlc_protocol and before setting dev->type.
> In hdlc_raw_eth, it sets hard_header_len by calling ether_setup after
> attach_hdlc_protocol and after memcpy the settings.
> 
> 3. Reset needed_headroom when detaching protocols (in hdlc.c)
> 
> When detaching a protocol from a hardware device, the hdlc module will
> reset various parameters of the device (including hard_header_len) to
> the default values. We add needed_headroom here so that needed_headroom
> will also be reset.
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Cc: Andrew Hendry <andrew.hendry@gmail.com>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thanks.
