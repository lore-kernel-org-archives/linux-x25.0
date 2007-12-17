From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: X.25 in linux
Date: Mon, 17 Dec 2007 14:00:54 +0200
Message-ID: <20071217120054.GJ6372@mea-ext.zmailer.org>
References: <14370077.post@talk.nabble.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <14370077.post@talk.nabble.com>
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: venkat4p <venkat_p257@yahoo.co.in>
Cc: linux-x25@vger.kernel.org

On Sun, Dec 16, 2007 at 09:11:16PM -0800, venkat4p wrote:
> Hai all,

Hello,

  
> I want to make two Linux systems communicating through X.25 suite.
> I am successful in sending data through X.25 PLP over lapb over
> Ethernet. (by using X25 socket API, x25route and lapb0 virtual interface)
>  
> Now, I want to communicate via lapb over serial interface (like "ttyS0")
> instead of Ethernet layer.
> I installed Net-tools package, then I tried with "slattach -p x25 /dev/ttyS0"
> but got message
> > Cannot change line discipline to `x25'.
> Can any one tell me from where can I get the modified version of "slattach" 
> so that it supports X25 Async network interface or any available  modules
> which helps me in doing this?

Kernel already has module  x25_asy.c  which needs to be configured from WAN
submenu - an EXPERIMENTAL module:

config X25_ASY
        tristate "X.25 async driver (EXPERIMENTAL)"
        depends on WAN && LAPB && X25
        ---help---
          Send and receive X.25 frames over regular asynchronous serial
          lines such as telephone lines equipped with ordinary modems.

          Experts should note that this driver doesn't currently comply with
          the asynchronous HDLS framing protocols in CCITT recommendation X.25.

          To compile this driver as a module, choose M here: the
          module will be called x25_asy.

          If unsure, say N.


It is not configured on in default case.
You have to make your own kernel configuration with that (and all dependencies)
turned into modules.  (You probably already did spin your own kernel to have
X.25 in system in the first place..)

Even then the  slattach  might not know what "x25" is supposed to be.

> Thanks,
> Venkat.

/Matti Aarnio
