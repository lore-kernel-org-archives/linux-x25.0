From: Andrew Hendry <ahendry@tusc.com.au>
Subject: [PATCH] - Trivial 2.6.8.1 /proc/net/x25/route is infinite when x25
	routes > 0
Date: Fri, 20 Aug 2004 17:09:32 +1000
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <1092985772.2292.447.camel@ahendry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: eis@baty.hanse.de
Cc: linux-x25@vger.kernel.org, trivial@rustcorp.com.au

When displaying x25 routes:

route add --x25 1234/2 eth0
route add --x25 4321/2 eth0
cat /proc/net/x25/route
Is infinite

This patch makes x25_get_route_idx the same as x25_get_socket_idx which
works correctly. Applies to 2.6.8.1 and probably much older.

Andrew.


diff -up linux-2.6.8.1/net/x25/x25_proc.c.orig
linux-2.6.8.1/net/x25/x25_proc.c

--- linux-2.6.8.1/net/x25/x25_proc.c.orig       2004-08-20
17:02:43.311326384 +1000
+++ linux-2.6.8.1/net/x25/x25_proc.c    2004-08-20 16:38:42.491364312
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


