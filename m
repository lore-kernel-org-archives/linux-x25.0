From: joe@perches.com
Subject: [PATCH] [544/2many] MAINTAINERS - X.25 NETWORK LAYER
Date: Sun, 12 Aug 2007 23:39:47 -0700
Message-ID: <46bffcb3.0Xk9br6H8RHWXTjQ%joe@perches.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: torvalds@linux-foundation.org, linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, eis@baty.hanse.de, akpm@linux-foundation.org

Add file pattern to MAINTAINER entry

Signed-off-by: Joe Perches <joe@perches.com>

diff --git a/MAINTAINERS b/MAINTAINERS
index 454494e..e4e1cc3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5141,6 +5141,9 @@ P:	Henner Eisen
 M:	eis@baty.hanse.de
 L:	linux-x25@vger.kernel.org
 S:	Maintained
+F:	Documentation/networking/x25*
+F:	include/net/x25*
+F:	net/x25/
 
 XEN HYPERVISOR INTERFACE
 P:	Jeremy Fitzhardinge
