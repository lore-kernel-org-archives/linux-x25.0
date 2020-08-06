From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Added needed_headroom and a
 skb->len check
Date: Thu, 6 Aug 2020 09:46:52 +0200
Message-ID: <CA+FuTSeOhYOqKjHk5ZBFiY=_+pXgUKe4BKx1S+gu9T9X2c1+bQ@mail.gmail.com>
References: <20200806015040.98379-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b0t+oHy+3tXSv0Fyo8sj7nLYPLgMZk4rOQH5zJCrsUw=;
        b=mmO64tyBsv+JgYuCiVyrAC9dV/zesXAcDYptXbHbTy4W8WXtXbVWPIOs51jgsbEwN3
         HhXWe+f/qbuFvdAhQUwRBnYyDtQkKTwom+nj/bIY8e2tBjpbRMQwYA/mO3SqrIt98nwT
         ra9b6d/QmxEpGikM9bJy8QITxjvVXBLrvoxFkUVpYbmnHlJkpgXjxr1pM0NwEq35WKDI
         Yu7mXGNnpAeeKTujMpr7d82Epw3cGUSK/7QLXPNOuLPg9ur0TbkWJFeRaBIIhWndag9O
         MJ5eDNE6ElyNqBNB73YNa0pKfS56drZJ+EY+hNc2AdhgZGEE/49fUu+Uqq/POqk0UH9X
         arkA==
In-Reply-To: <20200806015040.98379-1-xie.he.0141@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin Schiller <ms@dev.tdt.de>, Brian Norris <briannorris@chromium.org>

On Thu, Aug 6, 2020 at 3:51 AM Xie He <xie.he.0141@gmail.com> wrote:
>
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
>
> [  168.399197] skbuff: skb_under_panic: text:ffffffff819d95fb len:20
> put:14 head:ffff8882704c0a00 data:ffff8882704c09fd tail:0x11 end:0xc0
> dev:veth0
> ...
> [  168.399255] Call Trace:
> [  168.399259]  skb_push.cold+0x14/0x24
> [  168.399262]  eth_header+0x2b/0xc0
> [  168.399267]  lapbeth_data_transmit+0x9a/0xb0 [lapbether]
> [  168.399275]  lapb_data_transmit+0x22/0x2c [lapb]
> [  168.399277]  lapb_transmit_buffer+0x71/0xb0 [lapb]
> [  168.399279]  lapb_kick+0xe3/0x1c0 [lapb]
> [  168.399281]  lapb_data_request+0x76/0xc0 [lapb]
> [  168.399283]  lapbeth_xmit+0x56/0x90 [lapbether]
> [  168.399286]  dev_hard_start_xmit+0x91/0x1f0
> [  168.399289]  ? irq_init_percpu_irqstack+0xc0/0x100
> [  168.399291]  __dev_queue_xmit+0x721/0x8e0
> [  168.399295]  ? packet_parse_headers.isra.0+0xd2/0x110
> [  168.399297]  dev_queue_xmit+0x10/0x20
> [  168.399298]  packet_sendmsg+0xbf0/0x19b0
> ......
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Cc: Brian Norris <briannorris@chromium.org>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Acked-by: Willem de Bruijn <willemb@google.com>

The in-band signal byte is required, but stripped by lapbeth_xmit.
Subsequent code will prefix additional headers, including an Ethernet
link layer. The extra space needs to be reserved, but not pulled in
packet_snd with skb_reserve, so has to use needed_headroom instead of
hard_header_len.
