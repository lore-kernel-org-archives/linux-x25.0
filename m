From: Andrew Hendry <ahendry@tusc.com.au>
Subject: [PATCH TRIVIAL 2.6.8.1] X.25 : Stop /proc/net/x25/route infinitely
	reading
Date: Mon, 25 Oct 2004 10:10:48 +1000
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <1098663048.3099.166.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org


The problem:
route add --x25 0/0 eth0
cat /proc/net/x25/route
reads the single routing entry forever.

This patch makes x25_get_route_idx behave the same as x25_get_socket_idx
which works correctly.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>

Andrew.

diff -up linux-2.6.8.1/net/x25/x25_proc.c.orig
linux-2.6.8.1/net/x25/x25_proc.c
--- linux-2.6.8.1/net/x25/x25_proc.c.orig       2004-10-25
09:27:58.600069976 +1000
+++ linux-2.6.8.1/net/x25/x25_proc.c    2004-10-25 09:29:30.079163040
+1000
@@ -32,10 +32,11 @@ static __inline__ struct x25_route *x25_
  
        list_for_each(route_entry, &x25_route_list) {
                rt = list_entry(route_entry, struct x25_route, node);
-               if (--pos)
-                       break;
+               if (!pos--)
+                       goto found;
        }
-
+       rt = NULL;
+found:
        return rt;
 }

