From: Peter <peter@bsqt.homeip.net>
Subject: hello?  XOT? tuntap?
Date: Mon, 26 Jul 2004 21:00:44 -0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <200407262100.44988.peter@bsqt.homeip.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org


Hi folks, 

I am pinging the list to see if there is anyone on it.
might as well ask a question... 

Cannot find a FAQ, as geocrawler.com refuses my packets... 

I have a machine that exchanges messages with another one over X.25.  The X.25 
link is long gone, being replaced by two cisco's and XOT many years ago.    I 
want to transparently replace the machine on my end.   that is, run XOT on a 
new linux box to the cisco at the other end.   I can test by running over XOT 
to a cisco connected to my old machine.

So, to start things off, I downloaded xotd-0.04 of 1998 vintage to have a 
look.  It mentions using x25tap0. That module is a late lamented one.
I guess I should be looking at tuntap?  How do I set a tap interface with 
x25 ?



