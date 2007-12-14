From: Mehturt <mehturt@gmail.com>
Subject: Re: x.25 status in kernel
Date: Fri, 14 Dec 2007 11:02:45 +0100
Message-ID: <43deb2920712140202p53cc3606ib8e1ea0fac9ed175@mail.gmail.com>
References: <43deb2920712071602v3a7bf32cyc908d67ccc754215@mail.gmail.com>
	 <9C0EDD40745FC748B560F2EC6D607E770A5D49@judd.tusc.com.au>
	 <43deb2920712120021n44eb6bd5u8b00eba9a897e326@mail.gmail.com>
	 <1197593293.6555.246.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=d3lgmbPVXKbXmfVVS+pnYB5ujBp+MTskxT8kBMPPRys=;
        b=keD3gvALYYDu4dzccOII5GttwyyRgYAj8LKZTdiXxmq9DTd0iglZQVNfOxEsV9OD+wOGU1z2AejUT9eKi+WQJ6ixwmkaDlPjYflAcmMbOTSZOy1H5xjzGLrkYyAGflppxGIw44RKyySTbzOPBrDrxVMU0jbAbRRAgnWmD2pXOAw=
In-Reply-To: <1197593293.6555.246.camel@localhost>
Content-Disposition: inline
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org

Hi,
actually what I need is not XOT, but the protocol translation done on
Cisco - translating TCP/IP to x.25.


On Dec 14, 2007 1:48 AM, ahendry <ahendry@tusc.com.au> wrote:
> Hi,
>
> For the other end of XoT, as far as I know it can be another linux box,
> or some vendors packaged linux boxes, or a cisco router. There could be
> more I haven't had to work on it for a year or so. When we did it, an
> x.25 network was being virtualized with XoT to get rid of the old x.25
> network hardware. The applications and end point hardware/firmware
> stayed x.25, and we used XoT to join it to the network. In this scenerio
> XoT made sense, as an added bonus on the cisco side XoT works with
> normal IOS, XoE/llc2 requires an enterprise IOS.
>
> If your migrating from solstice without changing the network, and
> already have something for XoE, the x.25 over llc2 will be the one to
> look at, from memory solstice didn't do XoT. I noticed Venkat just
> posted this
> "I want to make two Linux systems communicating through X.25 suite.
> I am successful in sending data through X.25 PLP over lapb over
> Ethernet. (by using X25 socket API, x25route and lapb0 virtual
> interface)" Sounds like what you need.

Hmm, perhaps I'm not really familiar with terms here.. I thought for
ethernet you need LLC2, not LAPB.
But yes, that's something I need.

>
> Your right on the x25tap. It seems to work well enough for the moment,
> but should be migrated from the obsolete interface.
>
> Cheers,
> Andrew
>
>
> On Wed, 2007-12-12 at 09:21 +0100, Mehturt wrote:
> > Hi, thanks for the pointer to fyonne.net.
> > From what I see there I understand that in order to use XOT I need to
> > communicate either to Cisco HW or another XOT daemon (e.g. another
> > Linux box)?  Are there any other HW vendors supporting XOT you have
> > experience with?
> > My concern, and I'm sure other people will complain about this as
> > well, is that the kernel module is based on obsoleted ethertap module.
> >  I'd have to see what it takes to rewrite this to use the tuntap
> > stuff.
> > m.
> >
> > On Dec 8, 2007 1:37 AM, Hendry, Andrew <ahendry@tusc.com.au> wrote:
> > > Hi,
> > >
> > > Haven't tried to use LAPB over E, or X.25 over LLC2.
> > > But, X.25 over TCP got the job done on another project migrating away from solaris.
> > > http://www.fyonne.net/ for some more details on x.25 over TCP.
> > >
> > > I have wondered about the ALPHA status there myself. Its been in there a long time, what does it take to move from alpha?
> > >
> > > Cheers,
> > > Andrew.
> > >
> > >
> > > -----Original Message-----
> > > From: linux-x25-owner@vger.kernel.org on behalf of Mehturt
> > > Sent: Sat 12/8/2007 11:02 AM
> > > To: linux-x25@vger.kernel.org
> > > Subject: x.25 status in kernel
> > >
> > > Hello list,
> > > I am reading about the current status of x.25 in Linux kernel.
> > > Is the information in net/x25/Kconfig up-to-date?
> > > Is the x.25 over LLC 2 still not present in kernel?
> > > Is this information (from
> > > http://www.baty.hanse.de/linux-x25/doc/FAQ.txt) true as of 2.6.23
> > > kernel?
> > >         "LAPB over Ethernet driver" for doing X.25 over lapb over Ethernet
> > >               (CAUTION: this is only intended for testing, it does not
> > >               implement a standardised protocol, it uses ethernet
> > >               broadcasting which might disturn other hosts)
> > > Is this statement (from kernel sources) still valid?
> > >  *      This is ALPHA test software. This code may break your machine,
> > >  *      randomly fail to work with new releases, misbehave and/or generally
> > >  *      screw up. It might even work.
> > >
> > > The reason I'm asking is that our customer wants to migrate some
> > > services from Solaris (using Solstice x.25 stack) to Linux and I need
> > > to find linux stacks out there - I started with the implementation
> > > currently in Linux kernel.
> > >
> > > Thanks
> > > m.
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-x25" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> > >
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-x25" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
