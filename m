From: "Ian Cass" <ian.cass@mblox.com>
Subject: Re: XOT and Sockets (X25 over TCP/IP)
Date: Thu, 20 Jun 2002 09:33:45 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <001b01c21835$313a1aa0$6602a8c0@salamander>
References: <5.0.2.1.2.20020619163143.029c9890@pop.prodigy.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org, Jacque Andre' Bussey <retsam@prodigy.net>

Hi,

We've got 2 different X25 implementations here.

The first uses a Cisco router and a Linux XOTd & the 2nd uses a Cyclades X25
card.

For the XOT, the cisco router has been configured to tunnel X25 inside TCPIP
with a Linux box as the local endpoint. This uses the userland XOT daemon
written by Stephane Fillod <sfillod@charybde.gyptis.frmug.org>. I'm not sure
where I downloaded it from, but I suggest you do a search for it on the net.
If you can't find it, I can mail it to you.

The XOTd will terminate the XOT tunnel, unwrap the X25 and present it to the
Linux X25 stack. In our case, the far end x25 host was an SMSC and I wanted
our internal applications to talk to it via TCP rather than X25, so I made a
TCP<>X25 proxy. This makes the far end X25 host look like a TCP service
running on a local server. If you can't find or make a similar application,
I can probably mail this to you too. No promises on code quality though :)

The XOTd worked pretty much out of the box. It's running on Linux v2.2.19. I
had to modify the Linux X25 stack slightly in order to fix a facilities bug,
but other than that it works great.

--- net/x25/old_af_x25.c        Wed Nov 28 18:37:15 2001
+++ net/x25/af_x25.c    Thu Nov 29 12:33:50 2001
@@ -1150,7 +1150,7 @@
                                return -EINVAL;
                        if (facilities.winsize_in < 1 ||
facilities.winsize_in > 127)
                                return -EINVAL;
-                       if (facilities.throughput < 0x03 ||
facilities.throughput > 0x2C)
+                       if (facilities.throughput && (facilities.throughput
< 0x03 || facilities.throughput > 0x2C))
                                return -EINVAL;
                        if (facilities.reverse != 0 && facilities.reverse !=
1)
                                return -EINVAL;

--
Ian Cass

----- Original Message -----
From: "Jacque Andre' Bussey" <retsam@prodigy.net>
To: <linux-x25@vger.kernel.org>
Sent: Wednesday, June 19, 2002 10:39 PM
Subject: XOT and Sockets (X25 over TCP/IP)


> Greetings all,
>
> I am presented with a situation that requires that I monitor 200 Telco
> switches via X.25. My problem is that my monitoring platform
> is on TCP/IP. I know that with Cisco routers you can map a X.121 address
to
> an IP but does that mean I can make a TCP/IP connection to that device? If
> not, is there any software that I can run on a Unix box that can map a
> Socket back to that device over TCP/IP? (a listener on the Unix box gets a
> connection then forwards that via X.25 encapsulated in TCP/IP to the far
> side X.25 on the other side of the XOT cisco router. *WHEEEW*)
>
>
> Any help will be greatly appreciated ,
>
>
> Jacque Bussey
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-x25" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

