From: "Frederico Faria" <frederico@ati.com.br>
Subject: Re: Is the kernel X.25 support still actively maintained?
Date: Thu, 25 Mar 2004 15:04:47 -0300
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <027c01c41293$a90a8d30$0402a8c0@ati.corp.ati.com.br>
References: <200403241055.24386.tsokorai@xperts.cl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "Tomas J. Sokorai Sch." <tsokorai@xperts.cl>, linux-x25@vger.kernel.org

Hi Thomas,

 I am working with XOT ( using  xotd ) to communicate with a CISCO router.
 After ,  I  will need implement  FTAM  on Linux over X25 too. Then  I am
interested
to get  a stable and full   featured X.25 support for Linux.

 Any  newness you can contact-me on my  email.

Thank you,

Frederico Faria




----- Original Message -----
From: "Tomas J. Sokorai Sch." <tsokorai@xperts.cl>
To: <linux-x25@vger.kernel.org>
Sent: Wednesday, March 24, 2004 11:55 AM
Subject: Is the kernel X.25 support still actively maintained?


> Hi,
> I've been playing with X.25 networking over Linux, and found that there's
> little information (if any) and much of the stuff is outdated.
> I'm trying to get ISODE's FTAM client to work on Linux over X.25. I'm also
> trying to use XOT (with xotd) to communicate with a Cisco router.
> There started my problems: I had to make a port of the xotd's x25tap
interface
> to the 2.6.x kernel, as the patch on xotd is for the 2.4.x series.
> I already have a port of ISODE FTAM initiator that I'm debbuging, that at
> least tries to open a X.25 call to my responder.
> I was trying too to get a serial async X.25 link working, but the problems
> went on: No documentation on how to set up the link. Then I found that
> slattach is not patched to be able to set the tty to X.25, and the patch
is
> nowhere to be found. I made my own patched slattach, managed to get the
> x25asy interface up, but slattach freezes, and if I try to kill it or
reboot,
> the whole machine freezes.
> Is there anyone still working on Linux's X.25 support?
> It could be nice to unificate efforts and try to get a stable and full
> featured X.25 support for Linux.
>
>
> --
> Tomas J. Sokorai Sch.
> Socio director, Gerente Proyectos Especiales
> Xperts Ltda. F: 63 244591, Valdivia, Chile
> -
> To unsubscribe from this list: send the line "unsubscribe linux-x25" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

