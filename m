From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 073/199] Documentation/networking/lapb-module.txt: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:28 +0200
Message-ID: <1274644605-25181-32-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=yh3OcUx6jDFunx95m7FtuYLZKNyadgdehPwl0TUXX4w=;
        b=QOMc6NN/3ESw7B6sC6s5w1vyUW1ttk1cAcgxFuTfgRptwy/NwmlhPYszliFv0D2Ck8
         L4diXHzR+kKzLaMbHAxTqpfu+BtpdARWy+o+iEdeALwD6bBzrRlVm9RVs/2snhYzPyap
         OcgECNqDV4VPH62CHXu91YDrQAUaWDKMi6nz0=
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrea.gelmini@gelma.net
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-x25@vger.kernel.org, linux-doc@vger.kernel.org

Documentation/networking/lapb-module.txt:5: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/networking/lapb-module.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/networking/lapb-module.txt b/Documentation/networking/lapb-module.txt
index d4fc8f2..fe93d29 100644
--- a/Documentation/networking/lapb-module.txt
+++ b/Documentation/networking/lapb-module.txt
@@ -2,7 +2,7 @@
 
 		      Jonathan Naylor 29.12.96
 
-Changed (Henner Eisen, 2000-10-29): int return value for data_indication() 
+Changed (Henner Eisen, 2000-10-29): int return value for data_indication()
 
 The LAPB module will be a separately compiled module for use by any parts of
 the Linux operating system that require a LAPB service. This document
-- 
1.7.1.251.gf80a2

