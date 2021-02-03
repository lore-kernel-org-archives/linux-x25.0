From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] net: hdlc_x25: Return meaningful error code in x25_open
Date: Tue,  2 Feb 2021 23:15:41 -0800
Message-ID: <20210203071541.86138-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vCplaxx+G/WjU4K1QFLVkvqSzFQBK1Dh3zZTYlV1r9g=;
        b=H7MtAneniyH/4SWxkj4bIPDg7tNEFkIJmh/URu3iGiyAFYphZBpJdujnazu09VQck3
         6u0lD0VnvKZoXmgSzyJzLvqHluXddaEYyZAfF0MX2qNpGe09ihytlVR0eDbuLPdHh6iZ
         ZSzh0CQ+Y1tKictzkI2yF1z9Y1VyiRMSpGFpKSgvfwu+APdWIVhy0pfkJ2O5BQ7P5n1D
         haYaPd6W6xc3Kl7B91dBYReDPKHfMwzUn0UrcajujUffzjTk4tp8SKDKMj9Vx9ceITlg
         OGiCea81wNVbm1Z3T2H6eizyc47z9id8x/EuOELUuD9QPU/fbWhhgr3yKxqIMkoHIS9C
         j97w==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>
Cc: Xie He <xie.he.0141@gmail.com>

It's not meaningful to pass on LAPB error codes to HDLC code or other
parts of the system, because they will not understand the error codes.

Instead, use system-wide recognizable error codes.

Fixes: f362e5fe0f1f ("wan/hdlc_x25: make lapb params configurable")
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 drivers/net/wan/hdlc_x25.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wan/hdlc_x25.c b/drivers/net/wan/hdlc_x25.c
index bb164805804e..4aaa6388b9ee 100644
--- a/drivers/net/wan/hdlc_x25.c
+++ b/drivers/net/wan/hdlc_x25.c
@@ -169,11 +169,11 @@ static int x25_open(struct net_device *dev)
 
 	result = lapb_register(dev, &cb);
 	if (result != LAPB_OK)
-		return result;
+		return -ENOMEM;
 
 	result = lapb_getparms(dev, &params);
 	if (result != LAPB_OK)
-		return result;
+		return -EINVAL;
 
 	if (state(hdlc)->settings.dce)
 		params.mode = params.mode | LAPB_DCE;
@@ -188,7 +188,7 @@ static int x25_open(struct net_device *dev)
 
 	result = lapb_setparms(dev, &params);
 	if (result != LAPB_OK)
-		return result;
+		return -EINVAL;
 
 	return 0;
 }
-- 
2.27.0

