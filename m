From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: Newbie: X.25 on Linux over Ethernet & Cisco?
Date: Tue, 3 Aug 2004 15:05:23 +0300
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <20040803120523.GB2716@mea-ext.zmailer.org>
References: <001f01c4793f$5d898290$2b02010a@w8x00020>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <001f01c4793f$5d898290$2b02010a@w8x00020>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bernhard Roth <Bernhard.Roth@pwrnet.de>
Cc: linux-x25@vger.kernel.org

On Tue, Aug 03, 2004 at 11:50:52AM +0200, Bernhard Roth wrote:
> Hello!
> 
> I hope somebody can give me some hints using X.25.
> 
> The basic task is to write a linux program which can receive and send X.25
> packets to the public X.25 network.
> I wanted to use a Cisco router to interface the X.25 side (X.31) to
> ethernet.
> Unfortunately I'm quite unexperienced doing this so I have some questions:

I haven't seen it anywhere in use, but about 10 years ago an INFORMATIONAL
RFC was written with title:   cisco Systems X.25 over TCP (XOT)
That is RFC 1613.

> - Which protocol shall be used on the Linux-Box' site to communicate with
> the Cisco

TCP connection in which XOT is run.

> - How is the X.25 routing working? Is it possible to forward and received
> X.25 packets to the Linux-Box?

per the XOT specification: yes.

> - Do I receive only the userdata or do I need to decode the X.25 packets (I
> mean connecting phase etc...)

The XOT carries all of the X.25 packets, so you do need to
process the X.25 protocol.

> - XOT seems to be fine (isn't it?) but cannot find as all URL's are invalid

ftp://ftp.rfc-editor.org/in-notes/rfc1613.txt

> - Are there any examples available?

  http://www.deakin.edu.au/~jamesmiw/xotd-0.04.tar.gz

(googling for "linux xotd" did find that rather quickly)

There seems to be some newer version of the xotd.c (the daemon
for Linux), and I was able to find it from Google cache.
Just for you I did copy it into:

  ftp://ftp.zmailer.org/linux/xotd.c

There is also copy of that xotd-0.04.tar.gz  package.

That process acts as an interface in between Linux kernel
X.25, and XOT services in a cisco.

> Thanks for any help :)
> 
> Regards
> 
> Bernhard Roth

/Matti Aarnio
