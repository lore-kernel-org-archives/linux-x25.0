From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net v2] drivers/net/wan/lapbether: Added needed_tailroom
Date: Fri, 21 Aug 2020 14:26:59 -0700
Message-ID: <20200821212659.14551-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QWnVqkXsQ2VHac6sNBlwzOFyH2VOJDY/ZCWON4QvS5I=;
        b=O5ysZ7BX+yeoWYpqn0zquTNx0iwRRKm2Bzx3i0KWfMjzIB59kkB+pfCQadtv+THzVF
         LjYONAb2xWOCOooyA/gOSaHcBtzivEBljT9wbum2c3BIahbl+nDRM4pZ1/MVlz7HS077
         M3cGX7Z8/QRJ5bRx86su5ApaXmUtndHcN3vWWao5asovSjC0tGD+HB7jNgwgsc6kusuT
         6iqbs9NPOuGfI1bNWxIfHB14J2N1BLeFzSRL5qOwzsDWsvMwEJWM3oEKjyq3ghqUeUWD
         HJRy7cN/FLGd4JvsDQvbkSgbMHJPs9pNxeC8jpha8jvKpoEteXjMOamRYaG91cpi0dSR
         Jfow==
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
Change from v1:
None
I'm re-sending this patch unchanged because the previous reviewer has
stopped responding for 11 days and he didn't indicate what change I
should do to this patch.

It's hard to find reviewers for this code. I tried to send emails, but
people don't respond. If you can review it, I'd really appreciate it.
I'm not in a hurry so please take your time. Thanks!
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

