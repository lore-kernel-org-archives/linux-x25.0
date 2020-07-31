From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Thu, 30 Jul 2020 18:36:25 -0700
Message-ID: <CAJht_ENjHRExBEHx--xmqnOy1MXY_6F5XZ_exinSfa6xU_XDJg@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=unNkakX66uz1a8NwuDIWTVZkGEyN5ilSTI7FY3j0SNA=;
        b=L1u1vSnIvxCrTsbprGLnPNvMYpTghiUZV9ALHMPH/7GGcpcXgAkqsU/NHJ1vvMrck5
         eAdHIPnKemAt37IRtdNBI6CN4RpCUiLxt/TRxso0w4MoHB4ojXMBdC1v1ebqYyKxe53y
         HNOHUXc9YjZffpb2dYNdlywhJg3y3CHsX2YmrGYzTsRazISvKoCWMMgBZOxL3QHcMeEL
         iFTKkkOpibBFDnNqOwZlPNPuoOzcXXZmvikjntTvHVA+ajhwh3wxmBWSy7Dnm9Fw/JNX
         Lde2+mZcbbo9Mg8FR0UVbg5G+sZdcITWW1fs1AlQOjQm4O4rBA1ZCn9Tf3PJhFxvWIty
         7IDA==
In-Reply-To: <20200730073702.16887-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

I'm really sorry to have re-sent the patch when the patch is still in
review. I don't intend to be disrespectful to anyone. And I apologize
for any disrespectfulness this might appear. Sorry.

I'm also sorry for not having sent the patch with the proper subject
prefixed with "net" or "net-next". If anyone requests I can re-send
this patch with the proper subject "PATCH net".

This patch actually fixes a kernel panic when this driver is used with
a AF_PACKET/RAW socket. This driver runs on top of Ethernet
interfaces. So I created a pair of virtual Ethernet (veth) interfaces,
loaded this driver to create a pair of X.25 interfaces on top of them,
and wrote C programs to use AF_PACKET sockets to send/receive data
through them.

At first I used AF_PACKET/DGRAM sockets. I prepared packet data
according to the requirements of X.25 drivers. I first sent an
one-byte packet ("\x01") to instruct the driver to connect, then I
sent data prefixed with an one-byte pseudo header ("\x00") to instruct
the driver to send the data, and then I sent another one-byte packet
("\x02") to instruct the driver to disconnect.

This works fine with AF_PACKET/DGRAM sockets. However, when I change
it to AF_PACKET/RAW sockets, kernel panic occurs. The stack trace is
as follows. We can see the kernel panicked because of insufficient
header space when pushing the Ethernet header.

[  168.399197] skbuff: skb_under_panic: text:ffffffff819d95fb len:20
put:14 head:ffff8882704c0a00 data:ffff8882704c09fd tail:0x11 end:0xc0
dev:veth0
...
[  168.399255] Call Trace:
[  168.399259]  skb_push.cold+0x14/0x24
[  168.399262]  eth_header+0x2b/0xc0
[  168.399267]  lapbeth_data_transmit+0x9a/0xb0 [lapbether]
[  168.399275]  lapb_data_transmit+0x22/0x2c [lapb]
[  168.399277]  lapb_transmit_buffer+0x71/0xb0 [lapb]
[  168.399279]  lapb_kick+0xe3/0x1c0 [lapb]
[  168.399281]  lapb_data_request+0x76/0xc0 [lapb]
[  168.399283]  lapbeth_xmit+0x56/0x90 [lapbether]
[  168.399286]  dev_hard_start_xmit+0x91/0x1f0
[  168.399289]  ? irq_init_percpu_irqstack+0xc0/0x100
[  168.399291]  __dev_queue_xmit+0x721/0x8e0
[  168.399295]  ? packet_parse_headers.isra.0+0xd2/0x110
[  168.399297]  dev_queue_xmit+0x10/0x20
[  168.399298]  packet_sendmsg+0xbf0/0x19b0
......

After applying this patch, the kernel panic no longer appears, and
AF_PACKET/RAW sockets would then behave the same as AF_PACKET/DGRAM
sockets.
