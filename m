From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net-next RFC v2] MAINTAINERS: Add Martin Schiller as a maintainer for the X.25 stack
Date: Thu, 12 Nov 2020 23:17:11 -0800
Message-ID: <20201113071711.29707-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XpJielsbomltdVuB/z23PcsD4Eziba/o/K52gFXVFZk=;
        b=uNV/kWP+dsjXI+cZgNVlaqPRfkKeRVskzhe/QoisWIqygNxK9KSdrzf/UQMbDbWOXj
         cDNOcRcKmnSwx2oB6HwROjnUGKm25rgB5AZRO9RJ5ITG96oQVPh0O4OPvyDGFKIUTB85
         wFEvZT8XRzqWJMG1HJzK0I+bm7FYZvVBMsN9ZPssZgODgL8lunYKldNmpNI0gVv/4QIn
         CXixMIJLPclON2bXBXeDu8+66whQRFpUjFRsX+VvBkpJ3Zme0JkScUPpcvNX1Je75+bs
         lGrsL+OgXSDw39H4BEMPz3x5tM15CVAbYIt76ZohQKWudg+pdwN4gbzwoI5dmwqGof3r
         L7mA==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>, Arnd Bergmann <arnd@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Xie He <xie.he.0141@gmail.com>, Andrew Hendry <andrew.hendry@gmail.com>

Martin Schiller is an active developer and reviewer for the X.25 code.
His company is providing products based on the Linux X.25 stack.
So he is a good candidate for maintainers of the X.25 code.

The original maintainer of the X.25 network layer (Andrew Hendry) has
not sent any email to the netdev mail list since 2013. So he is probably
inactive now.

Cc: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 MAINTAINERS | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2a0fde12b650..5adb78cb0d92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9832,13 +9832,6 @@ S:	Maintained
 F:	arch/mips/lantiq
 F:	drivers/soc/lantiq
 
-LAPB module
-L:	linux-x25@vger.kernel.org
-S:	Orphan
-F:	Documentation/networking/lapb-module.rst
-F:	include/*/lapb.h
-F:	net/lapb/
-
 LASI 53c700 driver for PARISC
 M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
 L:	linux-scsi@vger.kernel.org
@@ -18979,12 +18972,18 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 N:	axp[128]
 
-X.25 NETWORK LAYER
-M:	Andrew Hendry <andrew.hendry@gmail.com>
+X.25 STACK
+M:	Martin Schiller <ms@dev.tdt.de>
 L:	linux-x25@vger.kernel.org
-S:	Odd Fixes
+S:	Maintained
+F:	Documentation/networking/lapb-module.rst
 F:	Documentation/networking/x25*
+F:	drivers/net/wan/hdlc_x25.c
+F:	drivers/net/wan/lapbether.c
+F:	include/*/lapb.h
 F:	include/net/x25*
+F:	include/uapi/linux/x25.h
+F:	net/lapb/
 F:	net/x25/
 
 X86 ARCHITECTURE (32-BIT AND 64-BIT)
-- 
2.27.0

