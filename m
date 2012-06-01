From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] lapb-nl: Added driver
Date: Fri, 1 Jun 2012 15:54:46 +0100
Message-ID: <20120601155446.51751e61@pyramind.ukuu.org.uk>
References: <1338478278-24732-1-git-send-email-slapin@ossfans.org>
	<1338478278-24732-2-git-send-email-slapin@ossfans.org>
	<20120601145201.07a35cc3@pyramind.ukuu.org.uk>
	<20120601144040.GA24774@build.ihdev.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120601144040.GA24774@build.ihdev.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sergey Lapin <slapin@ossfans.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

On the socket family side I was thinking not of a "lapb-nl" socket layer
but a simple pure LAPB socket - that just uses interface name type
addressing and only supported SOCK_RAW for raw data frames over LAPB
encodings.


> > Again the sl->tty locking needs sorting (I think this may well be true of
> > slip and the others too)
> 
> Could you please explain a bit more on this?

In modern kernels the tty object is refcounted and not locked by any big
global locks.

So in your open do

	tty = tty_kref_get(tty);

and in the close
	tty_kref_put(tty);

and you are guaranteed the tty won't vanish under you between those
points.

> > Why flush ?
> Problems occured a long time ago, will remove and check.

That should be handled by the core code now.

> The whole thing is data packat transfer. Application is also notified when
> packet is delivered. That's it, no fancy stuff. There is also UDP code, but it is
> weird mess, and I think if it is to live or be removed. What do you think?

Weird mess removal is always good stuff.

Alan
