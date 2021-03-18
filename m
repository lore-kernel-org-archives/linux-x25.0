From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net-next] net: lapbether: Close the LAPB device before its underlying Ethernet device closes
Date: Thu, 18 Mar 2021 12:07:47 -0700
Message-ID: <20210318190747.25705-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4Fu6JikyYlZ618SKkUnTqBGhiDDGhC+oWvRchCQbz94=;
        b=vSmbs0l/jA/7uHxiCBD22P3prOaRzXFgXVLwiU3p0c7miN+j9ZY38Vxa4rkZfrGiEq
         MYG6EhPnqzwNbrpxsDxtKX5VisjuX2yYGHaoMIbQzM+hga1Zgl9cLcvVuea33N6LCQ9Q
         WOGiX2Z+cl9kYMCEd15zHozb91qVO2ijNlNq6qlcYaccBonMzwSX8VYeW+NbZCHalmOg
         f9vqvEQO0Ky1MKJvW3p/puyBWft4+xLA1bamYkOwPZiivfsAfJNh1JDiA9oWW0wKC1Hq
         G8yER7KWg97YJ7EIvySyip/PIlT3TqS4mtjZ6YlE6SGOh4x7NbBQFL6G8QSmSNuk/5BK
         4pyQ==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xie He <xie.he.0141@gmail.com>

When a virtual LAPB device's underlying Ethernet device closes, the LAPB
device is also closed.

However, currently the LAPB device is closed after the Ethernet device
closes. It would be better to close it before the Ethernet device closes.
This would allow the LAPB device to transmit a last frame to notify the
other side that it is disconnecting.

Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/lapbether.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 8fda0446ff71..45d74285265a 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -421,8 +421,8 @@ static int lapbeth_device_event(struct notifier_block *this,
 		if (lapbeth_get_x25_dev(dev) == NULL)
 			lapbeth_new_device(dev);
 		break;
-	case NETDEV_DOWN:	
-		/* ethernet device closed -> close LAPB interface */
+	case NETDEV_GOING_DOWN:
+		/* ethernet device closes -> close LAPB interface */
 		lapbeth = lapbeth_get_x25_dev(dev);
 		if (lapbeth) 
 			dev_close(lapbeth->axdev);
-- 
2.27.0

