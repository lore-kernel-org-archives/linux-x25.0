From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
Date: Sun, 26 Jul 2020 04:05:24 -0700
Message-ID: <20200726110524.151957-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HiCRrQCxdIa5HIW679AjRc9wXiJ6/iMtc+VYMoge+3c=;
        b=WYkENyzYNLhggQIvWLddjbWxCjYrMSbzqNPQL1fj6YeDJ/9qPZxc5cQQwyNHLyZIM/
         FGCZ9jLTyq9WFfYDRg0E8vaLl0le0BdIJ14LYb2+DbnaHJV1UoWAXTcURJqo7n8C837A
         UlP3Rcv2MkXCbkjYNkwvi0vKnYAorDTChREz40/kYkvpaF8rvEEABaWVdEhpYCzMCFCy
         Qml69TMC14lB3pyB9RatZMP5mMEyL+JY+t9GodCEblfEf8rNTk4bFCFJv0LFLnUHQuAO
         pxjVfCsKTX2lM8rooNJj53HGkb1EaDKuaM5ardkNToiC64I5vBjEzx8nWDftzGytEXfC
         vPbQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org
Cc: Xie He <xie.he.0141@gmail.com>

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

Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/lapbether.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index b2868433718f..34cf6db89912 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -305,6 +305,7 @@ static void lapbeth_setup(struct net_device *dev)
 	dev->netdev_ops	     = &lapbeth_netdev_ops;
 	dev->needs_free_netdev = true;
 	dev->type            = ARPHRD_X25;
+	dev->hard_header_len = 0;
 	dev->mtu             = 1000;
 	dev->addr_len        = 0;
 }
@@ -331,7 +332,8 @@ static int lapbeth_new_device(struct net_device *dev)
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

