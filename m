From: Steve Schefter <steve@wanware.com>
Subject: Re: Null X.25 cable?
Date: Fri, 14 May 2004 09:30:45 -0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <40A4CA05.7000501@wanware.com>
References: <129179533859.20040514122213@rootelecom.ru>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <129179533859.20040514122213@rootelecom.ru>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: un@rootelecom.ru, linux-x25@vger.kernel.org

Hi.

>   Is there any way to connect two X.25 card directly via cable (may be
>   NULL MODEM)?
>   If yes, what configuration of connectors it must have?
>   Will two cards (configured as DTE) work together?
> 
>   If anyone knows, please help!

The short answer is yes.

But in order for this to work, there are a few things you need to
check.

First, the card must be capable of being internally clocked.  One
side will need to be setup as internal and the other as external.

Second, make sure you use a synchronous null modem cable.  The
more common async null modem won't route the clocks properly between
the two sides (it just crosses the data and control signals).
You'll need to make sure that the "I" side of the null modem goes
to the side that has the clocking set to internal.

Third, there are two concepts of DTE and DCE in X.25: physical and
logical.  The null modem will take care of the fact that you are
connecting two physical DTEs together, but you also need to change
the logical setting (in software) to DCE on one side.

You can find the pinout for null modem cables for various electrical
interfaces on our website under "support".

There's also an application note covering this topic on our website:
http://www.wanware.com/index.php?page=support/app_notes/mach2mach&menu=support

Regards,
	Steve

------------------------------------------------------------------------
Steve Schefter                               phone: +1 705 725 9999 x26
The Software Group Limited		       fax: +1 705 725 9666
642 Welham Road, 			     email: steve@wanware.com
Barrie, Ontario CANADA  L4N 9A1 	       Web: www.wanware.com

