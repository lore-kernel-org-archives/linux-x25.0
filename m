From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: RE : XOT
Date: Mon, 7 Oct 2002 22:53:12 -0300
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <20021008015311.GR3485@conectiva.com.br>
References: <000901c26c96$622c4d80$28fdc350@defender> <004f01c26dd2$319ce200$f70127d5@britannic>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <004f01c26dd2$319ce200$f70127d5@britannic>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: John Hughes <John@Calva.COM>
Cc: 'Ian Cass' <ian.cass@mblox.com>, linux-x25@vger.kernel.org

Em Mon, Oct 07, 2002 at 09:21:43AM +0200, John Hughes escreveu:
> Ian Cass writes:
> 
> > John Hughes wrote: 
> >>'ve not had time to look at the code; what's so hacky about it?
> 
> >It's a userland driver using a ethertap like device. That sort of
> >thing should really be integrated into the kernel. However, it
> >does work, although not 100% reliably for me at the moment.
> 
> Ah, you mean it's very existence is a hack :-)
> 
> Any idea how you write a Linux driver that uses another Linux
> driver for it's I/O?

Look at ncpfs, smbfs, TUX, khttpd, IPX and Appletalk working on top of SNAP
that works on top of LLC, etc.

- Arnaldo
