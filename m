From: Frederico Faria <frederico@ati.com.br>
Subject: Re: Linux's X.25 and Isode
Date: Tue, 26 Oct 2004 11:27:06 -0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <417E50AA.8040801@ati.com.br>
References: <I66JXT01.009@metrored-telecom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Francisco A. Lozano Lopez" <francisco.lozano@metrored-telecom.com>
Cc: 'Andrew Hendry' <ahendry@tusc.com.au>, linux-x25@vger.kernel.org

     Hi Francisco,

      I also am searching  a open source Ftam implementation  for Linux 
about X25.
      Today I am evaluating  a commercial  software that implements Ftam 
on Linux over X25. It works fine!!!
       Now, I am starting the tests with FTAM/XOT using CISCO router to 
tranfer file with an EWSD ( Siemens ) switch.


   Regards,

   Frederico Faria

Francisco A. Lozano Lopez escreveu:
> This patch enables ISODE to work under Linux, but I thought it was only for
> ISO/OSI through TCP/IP. 
> Has anyone managed to make it work with Linux's X.25? In the config.h file,
> if you define X_25 it doesn't compile :(
> 
> I just need a ftam client for Linux's X.25; if there is any other different
> from isode's I'd be glad to hear about it.
> 
> I was planning on using Linux 2.2 because I couldn't patch a more current
> kernel with the needed patch. If there is any chance of making it work under
> a newer version i'd like to do so, but anyway for what I need to do with XOT
> Linux 2.2 is more than enough. I just need an opensource platform for CDR
> recollection from a 5ess phone switch, which has a Cisco router serving X.25
> through XOT.
> 
> Currently we have a proprietary implementation from a commercial software
> company which is based on ISODE but has the X.25 stack and the XOT client
> inside the FTAM binary... So it must be possible :)
> 
> 
> By the way, thankyou very much, you're almost the only person i've found on
> internet which knows what XOT is :/
> 
> -----Mensaje original-----
> De: linux-x25-owner@vger.kernel.org [mailto:linux-x25-owner@vger.kernel.org]
> En nombre de Andrew Hendry
> Enviado el: martes, 26 de octubre de 2004 0:21
> Para: Francisco A. Lozano Lopez
> CC: linux-x25@vger.kernel.org
> Asunto: Re: Linux's X.25 and Isode
> 
> 
> A linux patch for isode 8.0 exists here:
> http://www.ibiblio.org/pub/Linux/system/network/isode/
> I haven't used it.
> 
> As for the XOT implementation I have used this and it works well with cisco
> XOT. Are you planning on using 2.4 or 2.6?
> 
> Attached is an updated xotd.c file with a minor locking fix.
> gcc -o xotd xotd.c -lpthread is all it needs.
> 
> Andrew.
> 
> On Mon, 2004-10-25 at 18:25, Francisco A. Lozano Lopez wrote:
> 
>>Is there any way to use ISODE 8.0 with Linux's X.25?
>>
>>I have a Cisco router which tunnels X.25 throught XOT. I've seen that 
>>there is a small XOT implementation for older kernels so I'd like to 
>>try it to connect to a 5ess switch which, serves files throught FTAM over
> 
> X.25.
> 
>>If not, is there any other FTAM client which can connect throught 
>>Linux's X.25?
>>
>>Thankyou.
>>
>>-
>>To unsubscribe from this list: send the line "unsubscribe linux-x25" 
>>in the body of a message to majordomo@vger.kernel.org More majordomo 
>>info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-x25" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 


-- 
Frederico Charles S. Faria
ATI / ATITEL  Ltda
www.ati.com.br
(31) - 2105-3100


