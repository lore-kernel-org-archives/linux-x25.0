From: Steve Schefter <steve@wanware.com>
Subject: Re: Linux's X.25 and Isode
Date: Tue, 26 Oct 2004 10:02:42 -0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <417E5902.10905@wanware.com>
References: <I66JXT01.009@metrored-telecom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <I66JXT01.009@metrored-telecom.com>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Francisco A. Lozano Lopez" <francisco.lozano@metrored-telecom.com>
Cc: 'Andrew Hendry' <ahendry@tusc.com.au>, linux-x25@vger.kernel.org

Francisco A. Lozano Lopez wrote:

> This patch enables ISODE to work under Linux, but I thought it was only for
> ISO/OSI through TCP/IP. 

That's correct.  The interfaces for X.25 are still limited to Concurrent X.25,
HPUX X.25, UBC X.25 and Ultrix X.25.

> Has anyone managed to make it work with Linux's X.25? In the config.h file,
> if you define X_25 it doesn't compile :(
> 
> I just need a ftam client for Linux's X.25; if there is any other different
> from isode's I'd be glad to hear about it.
> 
> I was planning on using Linux 2.2 because I couldn't patch a more current
> kernel with the needed patch.

We've got a patch which adds support for ISODE over our commercial X.25
stack.  If you want to use the open X.25 stack rather than ours, it'll
at least get you an ISODE with X25 defined that compiles on a 2.4 kernel.

There's a link for downloading the patch as well as compile tips and other
information at:
http://www.wanware.com/index.php?page=products/wan/isode&menu=products/wan

Regards,
	Steve

------------------------------------------------------------------------
Steve Schefter                               phone: +1 705 725 9999 x26
The Software Group Limited		       fax: +1 705 725 9666
642 Welham Road, 			     email: steve@wanware.com
Barrie, Ontario CANADA  L4N 9A1 	       Web: www.wanware.com

