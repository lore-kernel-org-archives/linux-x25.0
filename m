From: Herbert Poetzl <herbert@13thfloor.at>
Subject: x25_create initializing socket data twice ...
Date: Thu, 3 Mar 2005 02:14:13 +0100
Message-ID: <20050303011413.GB11516@mail.13thfloor.at>
Mime-Version: 1.0
Content-Disposition: inline
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eis@baty.hanse.de, linux-x25@vger.kernel.org
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>


Hi Folks!

x25_create() [net/x25/af_x25.c] is calling sock_init_data()
twice ... once indirectly via x25_alloc_socket() and a
second time directly via sock_init_data(sock, sk);

while this might not look as critical as it seems, it can
easily break stuff which assumes that sock_init_data()
isn't called twice on the same socket ...

maybe something like this might be appropriate?

--- ./net/x25/af_x25.c.orig	2005-03-02 12:39:11 +0100
+++ ./net/x25/af_x25.c	2005-03-03 02:12:11 +0100
@@ -490,7 +490,6 @@ static int x25_create(struct socket *soc
 
 	x25 = x25_sk(sk);
 
-	sock_init_data(sock, sk);
 	sk_set_owner(sk, THIS_MODULE);
 
 	x25_init_timers(sk);


best,
Herbert

