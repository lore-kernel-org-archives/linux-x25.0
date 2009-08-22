From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] x25: bit and/or confusion?
Date: Sat, 22 Aug 2009 20:40:28 +0200
Message-ID: <4A903B9C.9010100@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=6Bj3+jnZWewm2MzRP6xypxJ2YIYEmk1ybsXL7pPKAdY=;
        b=rJ8R3Lhn34DlEPjjRkhotkVrtEvrVQjbnfb+Wk0OrWuLVSetHmtorcW5LaEs4h5wNS
         11jYeNahfH4NCxMNiZAw7dGxbiUdGahyxypj+xtLb2/OhGJfen0FckIu2wIyLc5nmGZo
         534xUn8SYkrzDjhx4qBCABK4EDFVpj2sVuGIA=
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Henner Eisen <eis@baty.hanse.de>, linux-x25@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

Could it be that something like this was intended?

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 5e6c072..bbfcdfa 100644
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
