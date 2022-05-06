From: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 6/6] net: wan: switch to netif_napi_add_weight()
Date: Fri,  6 May 2022 10:07:51 -0700
Message-ID: <20220506170751.822862-7-kuba@kernel.org>
References: <20220506170751.822862-1-kuba@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651856881;
        bh=S2T+9Y6sl30nIpo8x3GVqzVKOXcUQSwRlOt6wQSeijw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GCHLpI/HNWsKKkKAkHDcq/gsdg8FVt13ED0xc2YEjMbBmqbLlaOTGp3H7mXAyYXZM
         wce0IxFX6wB5+PmqSphf7WNGNAUFz6m1dmbhdCJv4EX34Yr8rzaBslFUl3mPGqGUvU
         NOlyIlRfpnl87BSV2ERv0dGqz0EIgoO/iuAASl0oPMark/dY7pxNSvvNgur7nyM/FC
         QkIyktDpQvXj7iyHlp2+/Bq9I7wxWxG/WirBeSC3peCgyltveo2UBrmQtEQQP+XcVk
         DivkCltAealVLCW5lCFVg3CwgrBDUfaBgly4Bd8fKUMctN16HA7DEswnEaMs5hsovu
         HOVpdY/mKwqgA==
In-Reply-To: <20220506170751.822862-1-kuba@kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com, Jakub Kicinski <kuba@kernel.org>, qiang.zhao@nxp.com, khc@pm.waw.pl, ms@dev.tdt.de, linuxppc-dev@lists.ozlabs.org, linux-x25@vger.kernel.org

A handful of WAN drivers use custom napi weights,
switch them to the new API.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: qiang.zhao@nxp.com
CC: khc@pm.waw.pl
CC: ms@dev.tdt.de
CC: linuxppc-dev@lists.ozlabs.org
CC: linux-x25@vger.kernel.org
---
 drivers/net/wan/fsl_ucc_hdlc.c | 2 +-
 drivers/net/wan/hd64572.c      | 3 ++-
 drivers/net/wan/ixp4xx_hss.c   | 2 +-
 drivers/net/wan/lapbether.c    | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
index 5ae2d27b5da9..22edea6ca4b8 100644
--- a/drivers/net/wan/fsl_ucc_hdlc.c
+++ b/drivers/net/wan/fsl_ucc_hdlc.c
@@ -1231,7 +1231,7 @@ static int ucc_hdlc_probe(struct platform_device *pdev)
 	dev->watchdog_timeo = 2 * HZ;
 	hdlc->attach = ucc_hdlc_attach;
 	hdlc->xmit = ucc_hdlc_tx;
-	netif_napi_add(dev, &uhdlc_priv->napi, ucc_hdlc_poll, 32);
+	netif_napi_add_weight(dev, &uhdlc_priv->napi, ucc_hdlc_poll, 32);
 	if (register_hdlc_device(dev)) {
 		ret = -ENOBUFS;
 		pr_err("ucc_hdlc: unable to register hdlc device\n");
diff --git a/drivers/net/wan/hd64572.c b/drivers/net/wan/hd64572.c
index b89b03a6aba7..534369ffe5de 100644
--- a/drivers/net/wan/hd64572.c
+++ b/drivers/net/wan/hd64572.c
@@ -173,7 +173,8 @@ static void sca_init_port(port_t *port)
 	sca_out(DIR_EOME, DIR_TX(port->chan), card); /* enable interrupts */
 
 	sca_set_carrier(port);
-	netif_napi_add(port->netdev, &port->napi, sca_poll, NAPI_WEIGHT);
+	netif_napi_add_weight(port->netdev, &port->napi, sca_poll,
+			      NAPI_WEIGHT);
 }
 
 /* MSCI interrupt service */
diff --git a/drivers/net/wan/ixp4xx_hss.c b/drivers/net/wan/ixp4xx_hss.c
index 863c3e34e136..e46b7f5ee49e 100644
--- a/drivers/net/wan/ixp4xx_hss.c
+++ b/drivers/net/wan/ixp4xx_hss.c
@@ -1504,7 +1504,7 @@ static int ixp4xx_hss_probe(struct platform_device *pdev)
 	port->clock_reg = CLK42X_SPEED_2048KHZ;
 	port->id = pdev->id;
 	port->dev = &pdev->dev;
-	netif_napi_add(ndev, &port->napi, hss_hdlc_poll, NAPI_WEIGHT);
+	netif_napi_add_weight(ndev, &port->napi, hss_hdlc_poll, NAPI_WEIGHT);
 
 	err = register_hdlc_device(ndev);
 	if (err)
diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 282192b82404..960f1393595c 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -408,7 +408,7 @@ static int lapbeth_new_device(struct net_device *dev)
 	spin_lock_init(&lapbeth->up_lock);
 
 	skb_queue_head_init(&lapbeth->rx_queue);
-	netif_napi_add(ndev, &lapbeth->napi, lapbeth_napi_poll, 16);
+	netif_napi_add_weight(ndev, &lapbeth->napi, lapbeth_napi_poll, 16);
 
 	rc = -EIO;
 	if (register_netdevice(ndev))
-- 
2.34.1

