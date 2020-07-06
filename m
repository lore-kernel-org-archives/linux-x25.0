From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH v2] drivers/net/wan/lapbether: Fixed the value of hard_header_len
Date: Sun,  5 Jul 2020 17:45:21 -0700
Message-ID: <20200706004521.78091-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4OaY8bZwpJuqmoIiivxLlaUVMaXxlk23RnTZnLFJFaY=;
        b=kd2w6hJIZW9PFP0lMor0Df7aUbziEFd/nGD0zMJOBuuWd21lAfqEipSBJb29CnzV6O
         0IrRM13BFz+vsC6/9Zykj4l47i8zCsw6O9fnI24mxY9GAQKldLqnA/sqOBX9zfVTTLoX
         +1s//whclybYcTOEZL22qwzGJNLYXnxCXcO7MSRysvfNpZj8/sMQRnMVXynCW99vpeo4
         rid4eAngZ438yS4XzZlqtwOg24OmCqeVkg4rbOuqt8LUpDUEEetfvGlzCocBqDBGzkVH
         kqSW5OdhEIKTLzddRU25moBgkZwDhh0PSHDyKHRAI9ih5RnuJbWyc2bQ0IC9nQk197dW
         zqIA==
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>, Xie He <xie.he.0141@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

When this driver transmits data,
  first this driver will remove a pseudo header of 1 byte,
  then the lapb module will prepend the LAPB header of 2 or 3 bytes,
  then this driver will prepend a length field of 2 bytes,
  then the underlying Ethernet device will prepend its own header.

So, the header length required should be:
  -1 + 3 + 2 + "the header length needed by the underlying device".

This patch fixes kernel panic when this driver is used with AF_PACKET
SOCK_DGRAM sockets.

Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
Change in v2: added a comment in the code

 drivers/net/wan/lapbether.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index e30d91a38cfb..284832314f31 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -303,7 +303,6 @@ static void lapbeth_setup(struct net_device *dev)
 	dev->netdev_ops	     = &lapbeth_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->type            = ARPHRD_X25;
-	dev->hard_header_len = 3;
 	dev->mtu             = 1000;
 	dev->addr_len        = 0;
 }
@@ -324,6 +323,14 @@ static int lapbeth_new_device(struct net_device *dev)
 	if (!ndev)
 		goto out;
 
+	/* When transmitting data:
+	 * first this driver removes a pseudo header of 1 byte,
+	 * then the lapb module prepends an LAPB header of at most 3 bytes,
+	 * then this driver prepends a length field of 2 bytes,
+	 * then the underlying Ethernet device prepends its own header.
+	 */
+	ndev->hard_header_len = -1 + 3 + 2 + dev->hard_header_len;
+
 	lapbeth = netdev_priv(ndev);
 	lapbeth->axdev = ndev;
 
-- 
2.25.1

