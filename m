From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
Date: Thu, 30 Jul 2020 00:37:02 -0700
Message-ID: <20200730073702.16887-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K+Oo0bHEpODF7XLQBQ6GDyIq38DUDAb0nnpXubPm0uI=;
        b=gcQTdkUwMvU1FPhnUFLPP+UPLAy2jxmTogTN2emcrLTfrpzcy5xxre8T4B4/PeTPEJ
         /Mz40YKCWv+F52Z6VI00Fcf+4FmiJBl4341OILo+enlqoGli0586/XSBRTjL6//WiKwP
         vKPo3NFq1H1Or6BHlxSLKDq/odvYSy39q+pTv6ZY/3p1D/RnFpPm0exZGMgVTUO3AWmm
         IpYo5g1xmDgnp4nPd+y0n7W/3HY7rCx8MW5Ac65Xl3gUOsq/mD2nLfPhJfxahNzeBgFS
         lZ5uTeDWusdNq07HOOiqipYsL1aL/A6NsaThNpZkivIqJfZp/sCT7q1zWe0NQ6CTry2K
         8kjA==
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

Patch v2 has no difference from v1.
I re-submitted it because I want to find new reviewers,
and I want to free new reviewers from the burden of reading the
lengthy discussion and explanations in the v1 email threads.

Summary of v1 discussion:
Cong Wang referred me to Brian Norris, who did a similar change before.
Brian Norris agreed with me on "hard_header_len vs needed_headroom",
but was unfamiliar with X.25 drivers.

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

