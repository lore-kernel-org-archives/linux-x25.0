From: "Tomas J. Sokorai Sch." <tsokorai@xperts.cl>
Subject: Is the kernel X.25 support still actively maintained?
Date: Wed, 24 Mar 2004 10:55:24 -0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <200403241055.24386.tsokorai@xperts.cl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org

Hi,
I've been playing with X.25 networking over Linux, and found that there's 
little information (if any) and much of the stuff is outdated.
I'm trying to get ISODE's FTAM client to work on Linux over X.25. I'm also 
trying to use XOT (with xotd) to communicate with a Cisco router.
There started my problems: I had to make a port of the xotd's x25tap interface 
to the 2.6.x kernel, as the patch on xotd is for the 2.4.x series.
I already have a port of ISODE FTAM initiator that I'm debbuging, that at 
least tries to open a X.25 call to my responder.
I was trying too to get a serial async X.25 link working, but the problems 
went on: No documentation on how to set up the link. Then I found that 
slattach is not patched to be able to set the tty to X.25, and the patch is 
nowhere to be found. I made my own patched slattach, managed to get the 
x25asy interface up, but slattach freezes, and if I try to kill it or reboot, 
the whole machine freezes.
Is there anyone still working on Linux's X.25 support?
It could be nice to unificate efforts and try to get a stable and full 
featured X.25 support for Linux.


-- 
Tomas J. Sokorai Sch.
Socio director, Gerente Proyectos Especiales
Xperts Ltda. F: 63 244591, Valdivia, Chile
