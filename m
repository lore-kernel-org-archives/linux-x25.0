From: Ferenci Daniel <Daniel.Ferenci@siemens.com>
Subject: Re: hello?  XOT? tuntap?
Date: Tue, 27 Jul 2004 10:17:55 +0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <41060FB3.7060406@siemens.com>
References: <200407262100.44988.peter@bsqt.homeip.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <200407262100.44988.peter@bsqt.homeip.net>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-x25@vger.kernel.org

Hi Peter,

I have new x25tap patch for 2.4.25 kernel.
You can find the patch at http://www.dafe.net/x25/

You have to:
1. Patch the kernel
2. during kernel configuration set up x25 stack,  net link sockets, 
x25tap devices
3. compile kernel
4. compile xot daemon
5. boot new kernel and load appropriate modules (/sbin/modprobe x25tap 
unit=0)
6. up the x25tun0 device (ifconfig x25tap0 up)
6. update x25 route (route --x25 add 0/0 x25tap0)
7. run xotd and it may work (./xotd -v x25tap0 ipaddr)

It works for me within two Linux maschines.
But I haven't tested it with the CISCO yet.

Best regards
Daniel.

Peter wrote:

>Hi folks, 
>
>I am pinging the list to see if there is anyone on it.
>might as well ask a question... 
>
>Cannot find a FAQ, as geocrawler.com refuses my packets... 
>
>I have a machine that exchanges messages with another one over X.25.  The X.25 
>link is long gone, being replaced by two cisco's and XOT many years ago.    I 
>want to transparently replace the machine on my end.   that is, run XOT on a 
>new linux box to the cisco at the other end.   I can test by running over XOT 
>to a cisco connected to my old machine.
>
>So, to start things off, I downloaded xotd-0.04 of 1998 vintage to have a 
>look.  It mentions using x25tap0. That module is a late lamented one.
>I guess I should be looking at tuntap?  How do I set a tap interface with 
>x25 ?
>
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-x25" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>


