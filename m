From: "un@roo" <un@rootelecom.ru>
Subject: Re[2]: Is the kernel X.25 support still actively maintained?
Date: Fri, 26 Mar 2004 13:15:05 +0300
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <67165034453.20040326131505@rootelecom.ru>
References: <200403241055.24386.tsokorai@xperts.cl>
 <027c01c41293$a90a8d30$0402a8c0@ati.corp.ati.com.br>
Reply-To: "un@roo" <un@rootelecom.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <027c01c41293$a90a8d30$0402a8c0@ati.corp.ati.com.br>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org

Hello All,

      Is anybody working with x.25 now?
      Is anybody use Eicon cards in Linux?
      Can anybody help in setting up x.25 in there?

      Nicolay

Thursday, March 25, 2004, 9:04:47 PM, you wrote:

FF> Hi Thomas,

FF>  I am working with XOT ( using  xotd ) to communicate with a CISCO router.
FF>  After ,  I  will need implement  FTAM  on Linux over X25 too. Then  I am
FF> interested
FF> to get  a stable and full   featured X.25 support for Linux.

FF>  Any  newness you can contact-me on my  email.

FF> Thank you,

FF> Frederico Faria




FF> ----- Original Message -----
FF> From: "Tomas J. Sokorai Sch." <tsokorai@xperts.cl>
FF> To: <linux-x25@vger.kernel.org>
FF> Sent: Wednesday, March 24, 2004 11:55 AM
FF> Subject: Is the kernel X.25 support still actively maintained?


>> Hi,
>> I've been playing with X.25 networking over Linux, and found that there's
>> little information (if any) and much of the stuff is outdated.
>> I'm trying to get ISODE's FTAM client to work on Linux over X.25. I'm also
>> trying to use XOT (with xotd) to communicate with a Cisco router.
>> There started my problems: I had to make a port of the xotd's x25tap
FF> interface
>> to the 2.6.x kernel, as the patch on xotd is for the 2.4.x series.
>> I already have a port of ISODE FTAM initiator that I'm debbuging, that at
>> least tries to open a X.25 call to my responder.
>> I was trying too to get a serial async X.25 link working, but the problems
>> went on: No documentation on how to set up the link. Then I found that
>> slattach is not patched to be able to set the tty to X.25, and the patch
FF> is
>> nowhere to be found. I made my own patched slattach, managed to get the
>> x25asy interface up, but slattach freezes, and if I try to kill it or
FF> reboot,
>> the whole machine freezes.
>> Is there anyone still working on Linux's X.25 support?
>> It could be nice to unificate efforts and try to get a stable and full
>> featured X.25 support for Linux.
>>
>>
>> --
>> Tomas J. Sokorai Sch.
>> Socio director, Gerente Proyectos Especiales
>> Xperts Ltda. F: 63 244591, Valdivia, Chile
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-x25" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

FF> -
FF> To unsubscribe from this list: send the line "unsubscribe linux-x25" in
FF> the body of a message to majordomo@vger.kernel.org
FF> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best regards,
 un                            mailto:un@rootelecom.ru

