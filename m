From: Bernd Jendrissek <berndj@prism.co.za>
Subject: Re: XOT and Sockets (X25 over TCP/IP)
Date: Thu, 20 Jun 2002 12:51:04 +0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <20020620125104.K1057@prism.co.za>
References: <5.0.2.1.2.20020619163143.029c9890@pop.prodigy.net> <001b01c21835$313a1aa0$6602a8c0@salamander>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <001b01c21835$313a1aa0$6602a8c0@salamander>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Cass <ian.cass@mblox.com>
Cc: linux-x25@vger.kernel.org, Jacque Andre' Bussey <retsam@prodigy.net>

On Thu, Jun 20, 2002 at 09:33:45AM +0100, Ian Cass wrote:
> The XOTd worked pretty much out of the box. It's running on Linux v2.2.19. I
> had to modify the Linux X25 stack slightly in order to fix a facilities bug,
> but other than that it works great.
> 
> --- net/x25/old_af_x25.c        Wed Nov 28 18:37:15 2001
> +++ net/x25/af_x25.c    Thu Nov 29 12:33:50 2001
> @@ -1150,7 +1150,7 @@
>                                 return -EINVAL;
>                         if (facilities.winsize_in < 1 ||
> facilities.winsize_in > 127)
>                                 return -EINVAL;
> -                       if (facilities.throughput < 0x03 ||
> facilities.throughput > 0x2C)
> +                       if (facilities.throughput && (facilities.throughput
> < 0x03 || facilities.throughput > 0x2C))
>                                 return -EINVAL;
>                         if (facilities.reverse != 0 && facilities.reverse !=
> 1)
>                                 return -EINVAL;

[I'm a total idiot with regards to X.25; please excuse my ignorance.]

When is facilities.throughput ever set to 0?  The only place I can find is in
net/x25/x25_facilities.c

What does facilities.throughput == 0 mean anyway?  X25_DEFAULT_THROUGHPUT?
No change?

bernd

BTW 2.4.18 has 0xDD instead of 0x2C - I guess that just allows higher
throughput.
