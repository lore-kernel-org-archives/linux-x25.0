From: andrew hendry <andrew.hendry@gmail.com>
Subject: [PATCH 3/3] X25: Fix oops and refcnt problems from x25_dev_get
Date: Wed, 25 Nov 2009 12:16:05 +1100
Message-ID: <d45a3acc0911241716i7bf218c4y71c75d9841695dfe@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934133AbZKYBQB@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=rLaCySPxkp8XxnTwF9HwGTcBTNKPEYIRxe7io5IupLA=;
        b=BN/M++mqrD/5PjnzBV2RV2yQxv35ZuoYXF6kzjziXzK13ngaBJhfZrff/NsIr4MxYz
         4xsSl5pb8QeaqwIb+EndVcA0J5VVt66oQQTQLj58B1GZN5niVlLrTW8Je2R5APP416+4
         yPTPQmMxlTVFVgW2DWlK6L/QW/LbU0dPuFu+w=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-x25@vger.kernel.org

Calls to x25_dev_get check for dev = NULL which was not set.
It allowed x25 to set routes and ioctls on down interfaces.
This caused oopses and refcnt problems on device_unregister.

Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

--- a/net/x25/x25_route.c	2009-11-25 09:30:52.003038597 +1100
+++ b/net/x25/x25_route.c	2009-11-25 09:33:37.627093701 +1100
@@ -136,8 +136,10 @@ struct net_device *x25_dev_get(char *dev
 #if defined(CONFIG_LLC) || defined(CONFIG_LLC_MODULE)
 					&& dev->type != ARPHRD_ETHER
 #endif
-					)))
+					))){
 		dev_put(dev);
+		dev = NULL;
+	}

 	return dev;
 }
