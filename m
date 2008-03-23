From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: [PATCH] LAPB:  Use the shorter LIST_HEAD form for brevity.
Date: Sun, 23 Mar 2008 09:43:09 -0400 (EDT)
Message-ID: <alpine.LFD.1.00.0803230942030.10807@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-x25@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>


Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  whoops, earlier one went to the wrong list address, so this is a
resend.

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index fb37b80..824df3b 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -58,7 +58,7 @@ struct lapbethdev {
 	struct net_device_stats stats;		/* some statistics */
 };

-static struct list_head lapbeth_devices = LIST_HEAD_INIT(lapbeth_devices);
+static LIST_HEAD(lapbeth_devices);

 /* ------------------------------------------------------------------------ */

========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry:
    Have classroom, will lecture.

http://crashcourse.ca                          Waterloo, Ontario, CANADA
========================================================================
