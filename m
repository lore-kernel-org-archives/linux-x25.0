From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net-next v2] net: hdlc_x25: Remove unnecessary skb_reset_network_header calls
Date: Tue,  8 Dec 2020 17:40:13 -0800
Message-ID: <20201209014013.4996-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LXmuShLe8MmRBicIw3DWKa+ptVtXWGYLDOodgjPJwzE=;
        b=tV2+OgBDZIQ5kf4Ksxt47bhj2n7BdftPuND9hM5dqdrItCusKags+oVSyuROLWnUHk
         fPdHnvbMFiyHW8vQWQKQRgztMpOhnjVqHxRXS2GrOKmnDdgUzoRaBExHmCtq0avJpqLN
         JtVMY74l1AlYuIDaQgah0x0oAcs6H6vHQ3lOW4Zn0SFbYw1oOcw1LgDiUIrHngwbgxJQ
         UT2czX53cvQSr47meqrXYkfwKznzY/Phmz+2a63XZ5gBT7L8HFbxAiTpo6a3ofObwd1H
         M8PXsmxwcHuqi6fbpXvgBweA44QrrwfEYTW4aKyiHfVtFdp4qbycOVutNZkjJJk8LjPQ
         0Xlg==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>
Cc: Xie He <xie.he.0141@gmail.com>

1. In x25_xmit, skb_reset_network_header is not necessary before we call
lapb_data_request. The lapb module doesn't need skb->network_header.
So there is no need to set skb->network_header before calling
lapb_data_request.

2. In x25_data_indication (called by the lapb module after some data
have been received), skb_reset_network_header is not necessary before we
call netif_rx. After we call netif_rx, the code in net/core/dev.c will
call skb_reset_network_header before handing the skb to upper layers
(in __netif_receive_skb_core, called by __netif_receive_skb_one_core,
called by __netif_receive_skb, called by process_backlog). So we don't
need to call skb_reset_network_header by ourselves.

Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/hdlc_x25.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wan/hdlc_x25.c b/drivers/net/wan/hdlc_x25.c
index f52b9fed0593..bb164805804e 100644
--- a/drivers/net/wan/hdlc_x25.c
+++ b/drivers/net/wan/hdlc_x25.c
@@ -77,7 +77,6 @@ static int x25_data_indication(struct net_device *dev, struct sk_buff *skb)
 	}
 
 	skb_push(skb, 1);
-	skb_reset_network_header(skb);
 
 	ptr  = skb->data;
 	*ptr = X25_IFACE_DATA;
@@ -118,7 +117,6 @@ static netdev_tx_t x25_xmit(struct sk_buff *skb, struct net_device *dev)
 	switch (skb->data[0]) {
 	case X25_IFACE_DATA:	/* Data to be transmitted */
 		skb_pull(skb, 1);
-		skb_reset_network_header(skb);
 		if ((result = lapb_data_request(dev, skb)) != LAPB_OK)
 			dev_kfree_skb(skb);
 		return NETDEV_TX_OK;
-- 
2.27.0

