From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] drivers/net/wan/lapbether: Set network_header before transmitting
Date: Tue, 25 Aug 2020 20:03:53 -0700
Message-ID: <20200826030353.75645-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tWZBSAFPB25Ix8dxJn0Apg8q5RD1rLXKwul0a9thtfs=;
        b=qeU+YGnR6JDsoGqwquHCY9zcM2jhoA3P3cgTEY8sz4dSdMJld9Q/4yAcx1Slz95rA6
         lVl34RkyDejG9atiuiQZ7BJZb96z1kCMNKamgcBMeCp0xT9rrasgdlgaYbXgpGhBwsgY
         d1F/ZSgVN/Xzy0vxJyDp521+HpbqwK/9loN8pHXCV3YklhjCLGonakXYtdcaeAh65myp
         8prbYv7Z23r1JJrcZfW5YaEoobBP60lVxM/R0C1eTHR/DUffJLfLTxju5kpSmc+JJlLv
         6VsWAssMTaVUa4lEJQkCVHbgwxdGsVqoatb5GxQcyVmDAvnrdO1pAAxLybnCwXmzHszI
         7GzQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org
Cc: Xie He <xie.he.0141@gmail.com>, Martin Schiller <ms@dev.tdt.de>

Set the skb's network_header before it is passed to the underlying
Ethernet device for transmission.

This patch fixes the following issue:

When we use this driver with AF_PACKET sockets, there would be error
messages of:
   protocol 0805 is buggy, dev (Ethernet interface name)
printed in the system "dmesg" log.

This is because skbs passed down to the Ethernet device for transmission
don't have their network_header properly set, and the dev_queue_xmit_nit
function in net/core/dev.c complains about this.

Reason of setting the network_header to this place (at the end of the
Ethernet header, and at the beginning of the Ethernet payload):

Because when this driver receives an skb from the Ethernet device, the
network_header is also set at this place.

Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/lapbether.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index cc297ea9c6ec..e61616b0b91c 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -210,6 +210,8 @@ static void lapbeth_data_transmit(struct net_device *ndev, struct sk_buff *skb)
 
 	skb->dev = dev = lapbeth->ethdev;
 
+	skb_reset_network_header(skb);
+
 	dev_hard_header(skb, dev, ETH_P_DEC, bcast_addr, NULL, 0);
 
 	dev_queue_xmit(skb);
-- 
2.25.1

