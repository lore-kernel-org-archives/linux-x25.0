From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v6 2/5] net/lapb: support netdev events
Date: Wed, 25 Nov 2020 16:08:14 -0800
Message-ID: <20201126000814.12108-1-xie.he.0141@gmail.com>
References: <20201124093938.22012-3-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=te9bOn9gF8hsomOWKkERjKoUWBxmwagdLDi3NRp+Pr4=;
        b=HSc37bPXvJYZJBprBaal6zeRX/BzSnNXJ/7gXDRWnZ6xpwqIMZCONrcoTClhw/2i5G
         Y9XnLuo/kxrbPAg3g98MkwPcuLkGbma1rRNKXCFTz1iS0RgeAcawQ+U/Mjbtzux7VcBi
         KjMh9kBCYYiac/snlWHzaORVZZ06wodx7XUJLrXQ4tsSCj6H0J0AGbbAjKfRarL3A/qB
         Bc8/LywkCJa9pbt3DRXI34q2aQUMqYPUqUC8C21djByYRMIwIGMVDpRzayXJJKz4rtaX
         CazK5q7LLdqL+KvtJPBNz9S6ZWo3jywweJLv65gAIiKmrzORbZy5fwf8UliOQanDD0UB
         ZlRg==
In-Reply-To: <20201124093938.22012-3-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Martin,

Since we are going to assume lapb->state would remain in LAPB_STATE_0 when
the carrier is down (as understood by me. Right?), could we add a check in
lapb_connect_request to reject the upper layer's "connect" instruction when
the carrier is down? Like this:

diff --git a/include/linux/lapb.h b/include/linux/lapb.h
index eb56472f23b2..7923b1c6fc6a 100644
--- a/include/linux/lapb.h
+++ b/include/linux/lapb.h
@@ -14,6 +14,7 @@
 #define	LAPB_REFUSED		5
 #define	LAPB_TIMEDOUT		6
 #define	LAPB_NOMEM		7
+#define	LAPB_NOCARRIER		8
 
 #define	LAPB_STANDARD		0x00
 #define	LAPB_EXTENDED		0x01
diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index 3c03f6512c5f..c909d8db1bef 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -270,6 +270,10 @@ int lapb_connect_request(struct net_device *dev)
 	if (!lapb)
 		goto out;
 
+	rc = LAPB_NOCARRIER;
+	if (!netif_carrier_ok(dev))
+		goto out_put;
+
 	rc = LAPB_OK;
 	if (lapb->state == LAPB_STATE_1)
 		goto out_put;

Also, since we are going to assume the lapb->state would remain in
LAPB_STATE_0 when the carrier is down, are the
"lapb->state == LAPB_STATE_0" checks in carrier-up/device-up event
handling necessary? If they are not necessary, it might be better to
remove them because it may confuse people reading the code.

