From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
Date: Sat,  8 Aug 2020 10:52:51 -0700
Message-ID: <20200808175251.582781-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0OxlVIsSWOu661PCHopxBsGPjLO2EKn1MEWmBcl2YxE=;
        b=HGmxCskZb14zf46Qx83DUIcy+ZyCnozH2SUkSKakWwtDY5XVn4+AReZcLfgmDfqbwt
         UNjNhtBTKNFtKvhZ1jlX8mxSxwMwyN00VKaJmPbgjJ5wIC7Hyq5E1faMrtGVXjCATUfo
         QslmjjazU2psIsfzuKxYsM9CbKRGA5CEgznYDOK57dS95sykvb+cRczeVhaiJDUS7wzr
         BUXWIhN4s0gLJYuU5KmGvJXL5o8K10bvPkl1IgK/j/Dy3hB8OXoWHvKDJ42gF8xowqNT
         4s/zkaNxSPSpEkKdQLVIzYph369FWKpegpDgwilaHsTZo8rSRWSWkbQgEWUAPFwsLhCo
         drSA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org
Cc: Xie He <xie.he.0141@gmail.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin Schiller <ms@dev.tdt.de>

The underlying Ethernet device may request necessary tailroom to be
allocated by setting needed_tailroom. This driver should also set
needed_tailroom to request the tailroom needed by the underlying
Ethernet device to be allocated.

Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/lapbether.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 1ea15f2123ed..cc297ea9c6ec 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -340,6 +340,7 @@ static int lapbeth_new_device(struct net_device *dev)
 	 */
 	ndev->needed_headroom = -1 + 3 + 2 + dev->hard_header_len
 					   + dev->needed_headroom;
+	ndev->needed_tailroom = dev->needed_tailroom;
 
 	lapbeth = netdev_priv(ndev);
 	lapbeth->axdev = ndev;
-- 
2.25.1

