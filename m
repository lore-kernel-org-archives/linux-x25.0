From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH 06/37] docs: networking: convert x25.txt to ReST
Date: Fri,  1 May 2020 16:44:28 +0200
Message-ID: <577bc9abec90b75e85e2df602ee5d918345183eb.1588344146.git.mchehab+huawei@kernel.org>
References: <cover.1588344146.git.mchehab+huawei@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588344305;
        bh=IOVRqp8dN/LRKfokaK8zYd4K1YaI4tINbkY6jxbkZ/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJuoGW1bEJYpq0KlcwjYh4gCtqZfktqTkNFCzjvgy140WddSeVbzKmL1HrgMhCtgz
         6DyH0yZEyaqy8nRwfeg5OAZxj/rZbXr8uNUnVeXR9N4ems2epvPx7dALCxLQbi3DiU
         G45fMhdA4MPq7sggHTq1PplWOH8uqGDQsTqtJil0=
In-Reply-To: <cover.1588344146.git.mchehab+huawei@kernel.org>
Sender: linux-doc-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Andrew Hendry <andrew.hendry@gmail.com>, netdev@vger.kernel.org, linux-x25@vger.kernel.org

Not much to be done here:
- add SPDX header;
- add a document title;
- add to networking/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/networking/index.rst            | 1 +
 Documentation/networking/{x25.txt => x25.rst} | 4 ++++
 net/x25/Kconfig                               | 2 +-
 3 files changed, 6 insertions(+), 1 deletion(-)
 rename Documentation/networking/{x25.txt => x25.rst} (96%)

diff --git a/Documentation/networking/index.rst b/Documentation/networking/index.rst
index 7a4bdbc111b0..75521e6c473b 100644
--- a/Documentation/networking/index.rst
+++ b/Documentation/networking/index.rst
@@ -116,6 +116,7 @@ Contents:
    vrf
    vxlan
    x25-iface
+   x25
 
 .. only::  subproject and html
 
diff --git a/Documentation/networking/x25.txt b/Documentation/networking/x25.rst
similarity index 96%
rename from Documentation/networking/x25.txt
rename to Documentation/networking/x25.rst
index c91c6d7159ff..00e45d384ba0 100644
--- a/Documentation/networking/x25.txt
+++ b/Documentation/networking/x25.rst
@@ -1,4 +1,8 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==================
 Linux X.25 Project
+==================
 
 As my third year dissertation at University I have taken it upon myself to
 write an X.25 implementation for Linux. My aim is to provide a complete X.25
diff --git a/net/x25/Kconfig b/net/x25/Kconfig
index a328f79885d1..9f0d58b0b90b 100644
--- a/net/x25/Kconfig
+++ b/net/x25/Kconfig
@@ -20,7 +20,7 @@ config X25
 	  You can read more about X.25 at <http://www.sangoma.com/tutorials/x25/> and
 	  <http://docwiki.cisco.com/wiki/X.25>.
 	  Information about X.25 for Linux is contained in the files
-	  <file:Documentation/networking/x25.txt> and
+	  <file:Documentation/networking/x25.rst> and
 	  <file:Documentation/networking/x25-iface.rst>.
 
 	  One connects to an X.25 network either with a dedicated network card
-- 
2.25.4

