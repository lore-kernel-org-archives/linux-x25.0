From: Andrew Hendry <ahendry@tusc.com.au>
Subject: [PATCH TRIVIAL 2.6] X.25 : Dont log "unknown frame type" when
	receiving clear confirm
Date: Tue, 26 Oct 2004 10:13:39 +1000
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <1098749619.3099.194.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org

No need to log this for clear confirm.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>

diff -up linux-2.6.8.1/net/x25/x25_dev.c.orig linux-2.6.8.1/net/x25/x25_dev.c
--- linux-2.6.8.1/net/x25/x25_dev.c.orig        2004-10-26 09:58:36.158922080 +1000
+++ linux-2.6.8.1/net/x25/x25_dev.c     2004-10-26 10:03:01.134639648 +1000
@@ -92,7 +92,12 @@ static int x25_receive_data(struct sk_bu
 /*
        x25_transmit_clear_request(nb, lci, 0x0D);
 */
-       printk(KERN_DEBUG "x25_receive_data(): unknown frame type %2x\n",frametype);
+
+       /*
+        *      Dont spam the logs for clear confirms.
+        */
+       if (frametype != X25_CLEAR_CONFIRMATION)
+               printk(KERN_DEBUG "x25_receive_data(): unknown frame type %2x\n",frametype);
  
        return 0;
 }


