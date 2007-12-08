From: Mehturt <mehturt@gmail.com>
Subject: x.25 status in kernel
Date: Fri, 7 Dec 2007 16:02:50 -0800
Message-ID: <43deb2920712071602v3a7bf32cyc908d67ccc754215@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=GlBmaVh7CjV0r05v0vmUaDhLheXh3fWaogJVesYPPzo=;
        b=rtNM9YJ4ZKcIRPfDm33hh9UaGCXirNE1PMmBSMxvbB8R0MWCj1B/umI5YvlSvR12gLrYUUyCuz3+WShIm2jGfdisutpnLv5BqPXL7OEdCUf41BoiUE3jJ+Y4JLXTvKlKqHAiYHnfP5IfuMk+nr4t5kIlpEm6qftUeoHem4dfFYE=
Content-Disposition: inline
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org

Hello list,
I am reading about the current status of x.25 in Linux kernel.
Is the information in net/x25/Kconfig up-to-date?
Is the x.25 over LLC 2 still not present in kernel?
Is this information (from
http://www.baty.hanse.de/linux-x25/doc/FAQ.txt) true as of 2.6.23
kernel?
	"LAPB over Ethernet driver" for doing X.25 over lapb over Ethernet
	      (CAUTION: this is only intended for testing, it does not
	      implement a standardised protocol, it uses ethernet
	      broadcasting which might disturn other hosts)
Is this statement (from kernel sources) still valid?
 *      This is ALPHA test software. This code may break your machine,
 *      randomly fail to work with new releases, misbehave and/or generally
 *      screw up. It might even work.

The reason I'm asking is that our customer wants to migrate some
services from Solaris (using Solstice x.25 stack) to Linux and I need
to find linux stacks out there - I started with the implementation
currently in Linux kernel.

Thanks
m.
