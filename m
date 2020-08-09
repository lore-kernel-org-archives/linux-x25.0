From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a skb->len check
Date: Sat,  8 Aug 2020 19:35:48 -0700
Message-ID: <20200809023548.684217-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kub7wUC7iBpeOQedwXMHPG2fSSd6JGXHHrf1fpHFbPE=;
        b=t7tPPT0uU7FlYa5L++Ikfzy6rXwiljuECk4lu27SHPAazvDNgSpuEhfFcZmx93l1AH
         4FXV9lW+dfDAsIT2irs4JEaXxK5+3SEpW94sI3r5vATWanaXb+QxPhujqw21y2fOjc8A
         rcF4sU0WgHaJeTdFZr3QnBI0Ib/YIiwWPQmwVUpHpBGOnupStR9XSZUz8KuKSWb7QBj1
         ySmX1yVqxYQpcpdm4w676QrfjnI4WURyuCRNcPjyRzuYZoUsIFrg8BJvnG/Wp4hFUbX3
         d+87ReIhWqwn2GaEwpDHlszH3AcIy1PcTIa9PJsrm9XNE0bi2rQSI4/JxSfGF9fGEMnn
         4Krw==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org
Cc: Xie He <xie.he.0141@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin Schiller <ms@dev.tdt.de>

1. Added a skb->len check

This driver expects upper layers to include a pseudo header of 1 byte
when passing down a skb for transmission. This driver will read this
1-byte header. This patch added a skb->len check before reading the
header to make sure the header exists.

2. Added needed_headroom

When this driver transmits data,
  first this driver will remove a pseudo header of 1 byte,
  then the lapb module will prepend the LAPB header of 2 or 3 bytes.
So the value of needed_headroom in this driver should be 3 - 1.

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/x25_asy.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/wan/x25_asy.c b/drivers/net/wan/x25_asy.c
index 84640a0c13f3..de7984463595 100644
--- a/drivers/net/wan/x25_asy.c
+++ b/drivers/net/wan/x25_asy.c
@@ -307,6 +307,14 @@ static netdev_tx_t x25_asy_xmit(struct sk_buff *skb,
 		return NETDEV_TX_OK;
 	}
 
+	/* There should be a pseudo header of 1 byte added by upper layers.
+	 * Check to make sure it is there before reading it.
+	 */
+	if (skb->len < 1) {
+		kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
 	switch (skb->data[0]) {
 	case X25_IFACE_DATA:
 		break;
@@ -752,6 +760,12 @@ static void x25_asy_setup(struct net_device *dev)
 	dev->type		= ARPHRD_X25;
 	dev->tx_queue_len	= 10;
 
+	/* When transmitting data:
+	 * first this driver removes a pseudo header of 1 byte,
+	 * then the lapb module prepends an LAPB header of at most 3 bytes.
+	 */
+	dev->needed_headroom	= 3 - 1;
+
 	/* New-style flags. */
 	dev->flags		= IFF_NOARP;
 }
-- 
2.25.1

