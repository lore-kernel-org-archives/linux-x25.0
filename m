From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH] drivers/net/wan/lapbether: Fixed the value of hard_header_len
Date: Fri,  3 Jul 2020 22:12:46 -0700
Message-ID: <20200704051246.203413-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ma2Ml363EHulT5h5Rsiz3nA4SNmBIS3npTE4f6WSazQ=;
        b=IlJwAbWSaj97IjOeI49oGlMOb3AJFimGQy7xG8Gnoy6Txh4qaAalBv7G3jOcH42HAg
         4OMJVs0orHOy/aIic4ndhGHozWP8uYj7AqKsKLgLWziwABDqyz0cha7HzHrqbCRhMYwy
         QRXMBTzzH4OEfTfgs1fW37w3++563Cq5dM8MRzXC9NmuzkVid4oa5nw5ZVIHmSP2QVRp
         orCY4l8wX6seQhCoaiNqairmmlplus89MZwZfj00g9WNVM2+k//Tj8t3EiyavGfFSXbR
         ouMhrN9BxChldZ+uH/VEy1trk8XuY3eYWtZtuf/dxtCg5nOdzjSZqNXF34BQ+A1Djqn7
         9Q5w==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Madhuparna Bhowmik <madhuparnabhowmik04@gmail.com>, Xie He <xie.he.0141@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

When transmitting data from upper layers or from AF_PACKET sockets,
  this driver will first remove a pseudo header of 1 byte,
  then the lapb module will prepend the LAPB header of 2 or 3 bytes,
  then this driver will prepend a length field of 2 bytes,
  then the underlying Ethernet device will prepend its own header.

So, the header length required should be:
  -1 + 3 + 2 + "the header length needed by the underlying device".

This patch fixes kernel panic when this driver is used with AF_PACKET
SOCK_DGRAM sockets.

Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/lapbether.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index e30d91a38cfb..3b5ed0928a4c 100644
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
@@ -324,6 +323,8 @@ static int lapbeth_new_device(struct net_device *dev)
 	if (!ndev)
 		goto out;
 
+	ndev->hard_header_len = -1 + 3 + 2 + dev->hard_header_len;
+
 	lapbeth = netdev_priv(ndev);
 	lapbeth->axdev = ndev;
 
-- 
2.25.1

