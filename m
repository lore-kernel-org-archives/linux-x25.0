From: "Jacque Andre' Bussey" <retsam@prodigy.net>
Subject: XOT and Sockets (X25 over TCP/IP)
Date: Wed, 19 Jun 2002 16:39:06 -0500
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <5.0.2.1.2.20020619163143.029c9890@pop.prodigy.net>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-x25@vger.kernel.org

Greetings all,

I am presented with a situation that requires that I monitor 200 Telco 
switches via X.25. My problem is that my monitoring platform
is on TCP/IP. I know that with Cisco routers you can map a X.121 address to 
an IP but does that mean I can make a TCP/IP connection to that device? If 
not, is there any software that I can run on a Unix box that can map a 
Socket back to that device over TCP/IP? (a listener on the Unix box gets a 
connection then forwards that via X.25 encapsulated in TCP/IP to the far 
side X.25 on the other side of the XOT cisco router. *WHEEEW*)


Any help will be greatly appreciated ,


Jacque Bussey

