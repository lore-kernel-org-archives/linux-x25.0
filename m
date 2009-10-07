From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] x25: bit and/or confusion in x25_ioctl()?
Date: Wed, 07 Oct 2009 12:59:42 +0200
Message-ID: <4ACC749E.4060806@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=i2qOD+yna6sh3eQxBck9cDLkjpDGcmw5mgeU+g9SuiI=;
        b=fTpx0hrZ+1buyvJpLudd/8h8FfxV375nCJKbzzaU1cp8WZJ+7wzAr98w38dzPU8Bt8
         7T6woFUyktbUcsfvzgGTIUJ1Lwug+hBHqsHH+t8n8U9DvHwNrOsfT/n2n5zsFp6V3VkD
         F8egchFV8EXqpHLZYx5wWQ06F/mq9ghjml97k=
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Andrew Morton <akpm@linux-foundation.org>

Looking at commit ebc3f64b864f it appears that this was intended
and not the original, equivalent to `if (facilities.reverse & ~0x81)'.

In x25_parse_facilities() that patch changed how facilities->reverse
was set. No other bits were set than 0x80 and/or 0x01.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
This is correct isn't it?

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 7fa9c7a..ca4dc28 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1363,7 +1363,7 @@ static int x25_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			    facilities.throughput > 0xDD)
 				break;
 			if (facilities.reverse &&
-				(facilities.reverse | 0x81)!= 0x81)
+				(facilities.reverse & 0x81) != 0x81)
 				break;
 			x25->facilities = facilities;
 			rc = 0;
