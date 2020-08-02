From: Xie He <xie.he.0141@gmail.com>
Subject: [net v3] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
Date: Sun,  2 Aug 2020 12:50:46 -0700
Message-ID: <20200802195046.402539-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=B9BYrY99T620aK2jc5HkCpNbc33t/1UkwxGWa0hFtbs=;
        b=ODggDmsS4CbzPlYSm6/dZcfz6K+93ERd+GcOsML7aNME26dExFXZziMERjT2KwMU+d
         99jbl6tYo88EkBQV5YqzWL6QJKSjK7hMGenklAnk30W1yLci29kGEMhqfybzTL8cr6Vc
         ZoRAm7PCva0v0Q26qsIQBjYjoNhCI/ekKOoutnScumQnMwVKwz1hGJkO+M/PMvOoFg3h
         HLxwSShsOwQAYd55FOG93JUv3MRckVtXMlDw3e5rLCvCPKwlhe6CwlmOl2Bo0l6dDjBE
         QGH8eO2+FExYSRjf3mOhizKN2kRnRCzHhp8hRgyPSBH0Hxeoan4PsnnzIER9f3kCSS7X
         IiPg==
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org
Cc: Xie He <xie.he.0141@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Brian Norris <briannorris@chromium.org>

In net/packet/af_packet.c, the function packet_snd first reserves a
headroom of length (dev->hard_header_len + dev->needed_headroom).
Then if the socket is a SOCK_DGRAM socket, it calls dev_hard_header,
which calls dev->header_ops->create, to create the link layer header.
If the socket is a SOCK_RAW socket, it "un-reserves" a headroom of
length (dev->hard_header_len), and assumes the user to provide the
appropriate link layer header.

So according to the logic of af_packet.c, dev->hard_header_len should
be the length of the header that would be created by
dev->header_ops->create.

However, this driver doesn't provide dev->header_ops, so logically
dev->hard_header_len should be 0.

So we should use dev->needed_headroom instead of dev->hard_header_len
to request necessary headroom to be allocated.

This change fixes kernel panic when this driver is used with AF_PACKET
SOCK_RAW sockets. Call stack when panic:

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

Additional change:
When sending, check skb->len to ensure the 1-byte pseudo header is
present before reading it.

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---

Change from v2:
Added skb->len check when sending.

Change from v1:
None

---
 drivers/net/wan/lapbether.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index b2868433718f..8a3f7ba36f7e 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -157,6 +157,9 @@ static netdev_tx_t lapbeth_xmit(struct sk_buff *skb,
 	if (!netif_running(dev))
 		goto drop;
 
+	if (skb->len < 1)
+		goto drop;
+
 	switch (skb->data[0]) {
 	case X25_IFACE_DATA:
 		break;
@@ -305,6 +308,7 @@ static void lapbeth_setup(struct net_device *dev)
 	dev->netdev_ops	     = &lapbeth_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->type            = ARPHRD_X25;
+	dev->hard_header_len = 0;
 	dev->mtu             = 1000;
 	dev->addr_len        = 0;
 }
@@ -331,7 +335,8 @@ static int lapbeth_new_device(struct net_device *dev)
 	 * then this driver prepends a length field of 2 bytes,
 	 * then the underlying Ethernet device prepends its own header.
 	 */
-	ndev->hard_header_len = -1 + 3 + 2 + dev->hard_header_len;
+	ndev->needed_headroom = -1 + 3 + 2 + dev->hard_header_len
+					   + dev->needed_headroom;
 
 	lapbeth = netdev_priv(ndev);
 	lapbeth->axdev = ndev;
-- 
2.25.1

