From: Frederico Faria <frederico@ati.com.br>
Subject: X25 application problem
Date: Mon, 12 Jan 2004 15:15:55 -0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <4002D64B.2040601@ati.com.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-x25@vger.kernel.org

Hi,

I have a client/server application using the X25 in Linux over lapb - 
ethernet.

I loaded the modules, added the x25 routes  and runs my applications.

My client application dont find the server application. I thinks that I 
need to associate the server application ( X.121 address = 33 ) with the 
lapb interface . Is it correct ?
Any help ?

Thank you,

Faria


Below is my proc/x25 and proc/x25_route configuration.

dest_addr  src_addr   dev   lci st vs vr va   t  t2 t21 t22 t23 Snd-Q 
Rcv-Q inode
33         44         lapb0 001  1  0  0  0 134   3 200 180 180     0 
   0 48139
*          33         ???   000  0  0  0  0   0   3 200 180 180     0 
   0 48138



address          digits  device
000000000000000  0       lapb0


-- 
Frederico Charles S. Faria
ATI / ATITEL  Ltda
www.ati.com.br
(31) - 3275-3100


