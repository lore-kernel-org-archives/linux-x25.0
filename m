From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 05/37] docs: networking: convert x25-iface.txt to ReST
Date: Fri,  1 May 2020 16:44:27 +0200
Message-ID: <747ea578cab7a4329ad7eca89581ade529d445c0.1588344146.git.mchehab+huawei@kernel.org>
References: <cover.1588344146.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588344305;
        bh=qnf8XB2sEvNbUjilUQrtdoc9qtKZcKErFRomPjC8WmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XS/5CnfNpKA3CcZvL9fHS7jl56bXpsuK5ZmPcFI79Cvhyh0XsfkprkBD7DQyOIXJi
         6TWwHNH3pZ+dMZ6kc+yTYEO0KYySfMN39aUEnqzs38y9oK02PVdb9iyM67Aqousl3t
         tJPcMS55MA789/A1mlJ9aF/2Y1/uCfMIZVsIf0y8=
In-Reply-To: <cover.1588344146.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Andrew Hendry <andrew.hendry@gmail.com>, netdev@vger.kernel.org, linux-x25@vger.kernel.org

Not much to be done here:

- add SPDX header;
- adjust title markup;
- remove a tail whitespace;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/index.rst                     |  1 +
 .../networking/{x25-iface.txt => x25-iface.rst}        | 10 ++++++++--
 include/uapi/linux/if_x25.h                            |  2 +-
 net/x25/Kconfig                                        |  2 +-
 4 files changed, 11 insertions(+), 4 deletions(-)
 rename Documentation/networking/{x25-iface.txt => x25-iface.rst} (96%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index a72fdfb391b6..7a4bdbc111b0 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -115,6 +115,7 @@ Contents:
    udplite
    vrf
    vxlan
+   x25-iface
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/x25-iface.txt b/Documentation/networking/x25-iface.rst
similarity index 96%
rename from Documentation/networking/x25-iface.txt
rename to Documentation/networking/x25-iface.rst
index 7f213b556e85..df401891dce6 100644
--- a/Documentation/networking/x25-iface.txt
+++ b/Documentation/networking/x25-iface.rst
@@ -1,4 +1,10 @@
-			X.25 Device Driver Interface 1.1
+.. SPDX-License-Identifier: GPL-2.0
+
+============================-
+X.25 Device Driver Interface
+============================-
+
+Version 1.1
 
 			   Jonathan Naylor 26.12.96
 
@@ -99,7 +105,7 @@ reduced by the following measures or a combination thereof:
 (1) Drivers for kernel versions 2.4.x and above should always check the
     return value of netif_rx(). If it returns NET_RX_DROP, the
     driver's LAPB protocol must not confirm reception of the frame
-    to the peer. 
+    to the peer.
     This will reliably suppress packet loss. The LAPB protocol will
     automatically cause the peer to re-transmit the dropped packet
     later.
diff --git a/include/uapi/linux/if_x25.h b/include/uapi/linux/if_x25.h
index 5d962448345f..3a5938e38370 100644
--- a/include/uapi/linux/if_x25.h
+++ b/include/uapi/linux/if_x25.h
@@ -18,7 +18,7 @@
 
 #include <linux/types.h>
 
-/* Documentation/networking/x25-iface.txt */
+/* Documentation/networking/x25-iface.rst */
 #define X25_IFACE_DATA		0x00
 #define X25_IFACE_CONNECT	0x01
 #define X25_IFACE_DISCONNECT	0x02
diff --git a/net/x25/Kconfig b/net/x25/Kconfig
index 2ecb2e5e241e..a328f79885d1 100644
--- a/net/x25/Kconfig
+++ b/net/x25/Kconfig
@@ -21,7 +21,7 @@ config X25
 	  <http://docwiki.cisco.com/wiki/X.25>.
 	  Information about X.25 for Linux is contained in the files
 	  <file:Documentation/networking/x25.txt> and
-	  <file:Documentation/networking/x25-iface.txt>.
+	  <file:Documentation/networking/x25-iface.rst>.
 
 	  One connects to an X.25 network either with a dedicated network card
 	  using the X.21 protocol (not yet supported by Linux) or one can do
-- 
2.25.4

