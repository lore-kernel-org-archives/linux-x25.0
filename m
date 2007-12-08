From: "Hendry, Andrew" <ahendry@tusc.com.au>
Subject: RE: x.25 status in kernel
Date: Sat, 8 Dec 2007 11:37:57 +1100
Message-ID: <9C0EDD40745FC748B560F2EC6D607E770A5D49@judd.tusc.com.au>
References: <43deb2920712071602v3a7bf32cyc908d67ccc754215@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-x25-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Mehturt <mehturt@gmail.com>, linux-x25@vger.kernel.org

Hi,

Haven't tried to use LAPB over E, or X.25 over LLC2. 
But, X.25 over TCP got the job done on another project migrating away from solaris.
http://www.fyonne.net/ for some more details on x.25 over TCP.

I have wondered about the ALPHA status there myself. Its been in there a long time, what does it take to move from alpha? 

Cheers,
Andrew.

-----Original Message-----
From: linux-x25-owner@vger.kernel.org on behalf of Mehturt
Sent: Sat 12/8/2007 11:02 AM
To: linux-x25@vger.kernel.org
Subject: x.25 status in kernel
 
Hello list,
I am reading about the current status of x.25 in Linux kernel.
Is the information in net/x25/Kconfig up-to-date?
Is the x.25 over LLC 2 still not present in kernel?
Is this information (from
http://www.baty.hanse.de/linux-x25/doc/FAQ.txt) true as of 2.6.23
kernel?
	"LAPB over Ethernet driver" for doing X.25 over lapb over Ethernet
	      (CAUTION: this is only intended for testing, it does not
	      implement a standardised protocol, it uses ethernet
	      broadcasting which might disturn other hosts)
Is this statement (from kernel sources) still valid?
 *      This is ALPHA test software. This code may break your machine,
 *      randomly fail to work with new releases, misbehave and/or generally
 *      screw up. It might even work.

The reason I'm asking is that our customer wants to migrate some
services from Solaris (using Solstice x.25 stack) to Linux and I need
to find linux stacks out there - I started with the implementation
currently in Linux kernel.

Thanks
m.
-
To unsubscribe from this list: send the line "unsubscribe linux-x25" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

