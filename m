From: Derek Vair <derek@wanware.com>
Subject: Issues to be aware of with X.25 on Linux over Ethernet & Cisco?
Date: Mon, 09 Aug 2004 12:29:12 -0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <4117A658.7080706@wanware.com>
Reply-To: derek@wanware.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux_mailing_list <linux-x25@vger.kernel.org>

Bernhard,

One other thing you need to be aware of if you're going the linux X.25 / 
xotd.c route - the X.25 protocol implementation in the Linux kernel is 
not complete.

For example, it doesn't support Permanent Virtual Circuits (although 
there may well have patches developed for it since we worked with it).  
There was also a recent posting to the list about a packet level 
negotiation option which was defaulted incorrectly (and is now 
corrected, thanks to the poster).

If you are successful with your development / investigation, let us know 
- we could act as an alternate site for supplying the code to the community.

Best regards,


Derek

-------- Original Message --------
Return-Path: 	<linux-x25-owner@vger.kernel.org>
Received: 	from vger.kernel.org (vger.kernel.org [12.107.209.244]) by 
ns2.wanware.com (8.11.6p2/8.11.6) with ESMTP id i73C5hh02639; Tue, 3 Aug 
2004 08:05:44 -0400
Received: 	(majordomo@vger.kernel.org) by vger.kernel.org via listexpand 
id S265887AbUHCMFe (ORCPT <rfc822;steve@wanware.com> + 1 other); Tue, 3 
Aug 2004 08:05:34 -0400
Received: 	(majordomo@vger.kernel.org) by vger.kernel.org id 
S265900AbUHCMFe (ORCPT <rfc822;linux-x25-outgoing>); Tue, 3 Aug 2004 
08:05:34 -0400
Received: 	from mail.zmailer.org ([62.78.96.67]:7336 "EHLO 
mail.zmailer.org") by vger.kernel.org with ESMTP id S265887AbUHCMF0 
(ORCPT <rfc822;linux-x25@vger.kernel.org>); Tue, 3 Aug 2004 08:05:26 -0400
Received: 	(mea@mea-ext) by mail.zmailer.org id S258300AbUHCMFX (ORCPT 
<rfc822;linux-x25@vger.kernel.org>); Tue, 3 Aug 2004 15:05:23 +0300
Date: 	Tue, 3 Aug 2004 15:05:23 +0300
From: 	Matti Aarnio <matti.aarnio@zmailer.org>
To: 	Bernhard Roth <Bernhard.Roth@pwrnet.de>
Cc: 	linux-x25@vger.kernel.org
Subject: 	Re: Newbie: X.25 on Linux over Ethernet & Cisco?
Message-ID: 	<20040803120523.GB2716@mea-ext.zmailer.org>
References: 	<001f01c4793f$5d898290$2b02010a@w8x00020>
Mime-Version: 	1.0
Content-Type: 	text/plain; charset=us-ascii
Content-Disposition: 	inline
In-Reply-To: 	<001f01c4793f$5d898290$2b02010a@w8x00020>
Sender: 	linux-x25-owner@vger.kernel.org
Precedence: 	bulk
X-Mailing-List: 	linux-x25@vger.kernel.org
X-AntiVirus: 	checked by SentiNet Avira Milter [6.26.0.10]
X-Spam-Checker-Version: 	SpamAssassin 2.63-sentinet (2004-01-11) on 
ns2.wanware.com
X-Spam-Report: 	* -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 
1% * [score: 0.0000]
X-Spam-Status: 	No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
version=2.63-sentinet
X-Spam-Level: 	



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
-
To unsubscribe from this list: send the line "unsubscribe linux-x25" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


-- 
Derek Vair
The Software Group Limited        Tel:    +1(705)725-9999x22
642 Welham Road			    Fax:    +1(705)725-9666
Barrie, Ontario			    e-mail: derek@wanware.com
Canada L4N 9A1			    web:    www.wanware.com


