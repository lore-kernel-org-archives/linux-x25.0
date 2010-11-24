From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 2/2] NET: wan/x25, fix ldisc->open retval
Date: Thu, 25 Nov 2010 00:27:55 +0100
Message-ID: <1290641275-21726-2-git-send-email-jslaby@suse.cz>
References: <4CED9498.9080900@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4CED9498.9080900@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@suse.de
Cc: slapin@ossfans.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Alan Cox <alan@linux.intel.com>, Andrew Hendry <andrew.hendry@gmail.com>, linux-x25@vger.kernel.org

We should never return positive values from ldisc->open, tty layer
doesn't (and never did) expect that.

If we do that, weird things like warnings in tty_ldisc_close happen.

Not sure if dev->base_addr is used somehow now.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>
Cc: linux-x25@vger.kernel.org
---
 drivers/net/wan/x25_asy.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/wan/x25_asy.c b/drivers/net/wan/x25_asy.c
index d81ad83..66cda25 100644
--- a/drivers/net/wan/x25_asy.c
+++ b/drivers/net/wan/x25_asy.c
@@ -582,7 +582,7 @@ static int x25_asy_open_tty(struct tty_struct *tty)
 	if (err)
 		return err;
 	/* Done.  We have linked the TTY line to a channel. */
-	return sl->dev->base_addr;
+	return 0;
 }
 
 
-- 
1.7.3.1

