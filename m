From: Andrew Hendry <ahendry@tusc.com.au>
Subject: [PATCH TRIVIAL 2.6.8.1] X.25 : Stop x25_destroy_socket timer
	looping
Date: Mon, 25 Oct 2004 10:10:44 +1000
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <1098663044.3099.164.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org, eis@baty.hanse.de
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org


The sk_timer.data for the x.25 destroy_socket timer went missing at some
stage, causing a timer loop where x25_destroy_socket would keep setting
up timers to call itself.

Signed-off-by: Andrew Hendry <ahendry@tusc.com.au>


diff -up linux-2.6.8.1/net/x25/af_x25.c.orig
linux-2.6.8.1/net/x25/af_x25.c
--- linux-2.6.8.1/net/x25/af_x25.c.orig 2004-10-25 08:49:40.780391664
+1000
+++ linux-2.6.8.1/net/x25/af_x25.c      2004-10-25 09:08:22.797819088
+1000
@@ -347,6 +347,7 @@ void x25_destroy_socket(struct sock *sk)
                /* Defer: outstanding buffers */
                sk->sk_timer.expires  = jiffies + 10 * HZ;
                sk->sk_timer.function = x25_destroy_timer;
+               sk->sk_timer.data = (unsigned long)sk;
                add_timer(&sk->sk_timer);
        } else {
                /* drop last reference so sock_put will free */

