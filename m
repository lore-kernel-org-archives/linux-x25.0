From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: Is the kernel X.25 support still actively maintained?
Date: Thu, 25 Mar 2004 15:16:22 -0300
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <200403251516.25271.acme@conectiva.com.br>
References: <200403241055.24386.tsokorai@xperts.cl> <027c01c41293$a90a8d30$0402a8c0@ati.corp.ati.com.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <027c01c41293$a90a8d30$0402a8c0@ati.corp.ati.com.br>
Content-Disposition: inline
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Frederico Faria <frederico@ati.com.br>
Cc: "Tomas J. Sokorai Sch." <tsokorai@xperts.cl>, linux-x25@vger.kernel.org

On Thursday 25 March 2004 15:04, Frederico Faria wrote:
> Hi Thomas,
> 
>  I am working with XOT ( using  xotd ) to communicate with a CISCO router.
>  After ,  I  will need implement  FTAM  on Linux over X25 too. Then  I am
> interested
> to get  a stable and full   featured X.25 support for Linux.
> 
>  Any  newness you can contact-me on my  email.

I'll probably put my hands on the x.25 code in the coming months, as part of 
my TCPfication world tour :) I'm refactoring a ton of core networking code to 
reduce the differences on network protocol families implementations for the 
Linux kernel, initially I'm doing it on my stacks (Appletalk, LLC, IPX) and 
of course on the net/ipv4 and net/ipv6 code bases, but I'll eventually get to 
things like X.25.

For the curious the latest snapshot of my net-experimental tree is at this
URL:

http://www.kernel.org/pub/linux/kernel/people/acme/v2.6/net-experimental-2.6-20031224.patch.bz2

I've been busy with real life work after this christmas drop :-\

Just a heads up! :-)

- Arnaldo
