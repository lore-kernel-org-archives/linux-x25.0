From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] net: lapbether: Remove netif_start_queue / netif_stop_queue
Date: Sun,  7 Mar 2021 03:33:07 -0800
Message-ID: <20210307113309.443631-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QE9e3qNn83WSUIE3jJrl7w+oJ+JiRqDPe+H/RVHlaiQ=;
        b=jAqGFUpvVIshblWcz1U92JGc/yzMRSJnQ4RRDb9E+TnPJHyE4UOL9UoKFi75TxovVB
         BIk2hgvalBp3AZZdnAhoV5pLUklMWp0Zv75MJN/3FxoSrdksVVm9ekwCfGby/38kK9gU
         xHDuASCH7ESLCeiiZJ2I67O3ABlNd0ECKi7jaQvv8WpzfIWEjsWkMQhfw9yQTEaHc69t
         P2M8ao0YjlE6w8ibGYsBk2g5IeRgd9uYGqX+DRULmictZtgj7zhPwVsaM0VqH+/LNW9U
         e+cG7skQI5UOcDqc0E7Ej0hyPZaj+igV9qICRgsIOF20HXFh+ZN09JiR9X0wai147vT/
         SmXg==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xie He <xie.he.0141@gmail.com>

For the devices in this driver, the default qdisc is "noqueue",
because their "tx_queue_len" is 0.

In function "__dev_queue_xmit" in "net/core/dev.c", devices with the
"noqueue" qdisc are specially handled. Packets are transmitted without
being queued after a "dev->flags & IFF_UP" check. However, it's possible
that even if this check succeeds, "ops->ndo_stop" may still have already
been called. This is because in "__dev_close_many", "ops->ndo_stop" is
called before clearing the "IFF_UP" flag.

If we call "netif_stop_queue" in "ops->ndo_stop", then it's possible in
"__dev_queue_xmit", it sees the "IFF_UP" flag is present, and then it
checks "netif_xmit_stopped" and finds that the queue is already stopped.
In this case, it will complain that:
"Virtual device ... asks to queue packet!"

To prevent "__dev_queue_xmit" from generating this complaint, we should
not call "netif_stop_queue" in "ops->ndo_stop".

We also don't need to call "netif_start_queue" in "ops->ndo_open",
because after a netdev is allocated and registered, the
"__QUEUE_STATE_DRV_XOFF" flag is initially not set, so there is no need
to call "netif_start_queue" to clear it.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/lapbether.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 605fe555e157..c3372498f4f1 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -292,7 +292,6 @@ static int lapbeth_open(struct net_device *dev)
 		return -ENODEV;
 	}
 
-	netif_start_queue(dev);
 	return 0;
 }
 
@@ -300,8 +299,6 @@ static int lapbeth_close(struct net_device *dev)
 {
 	int err;
 
-	netif_stop_queue(dev);
-
 	if ((err = lapb_unregister(dev)) != LAPB_OK)
 		pr_err("lapb_unregister error: %d\n", err);
 
-- 
2.27.0

