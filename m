From: Steve Schefter <steve@wanware.com>
Subject: Re: Null X.25 cable?
Date: Mon, 17 May 2004 09:29:11 -0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <40A8BE27.7020606@wanware.com>
References: <1a4.23eb82b5.2dd7cc89@aol.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <1a4.23eb82b5.2dd7cc89@aol.com>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: TProvoni@aol.com
Cc: un@rootelecom.ru, linux-x25@vger.kernel.org

Hi Joachim.

> Wanware hardware sounds somewhat restrictive in its clock 
> configurations.  I have worked with several vendors' equipment that 
> allows symmetric independent clocking.  Transmit clocks are sent from 
> both sides and the receivers extract the clocks as they receive data.  

We support that as well.  It is just more common to have the physical
DCE generate the clock for both sides to use (such as when you are
connected to a modem or DSU/CSU).  I generally only put internal clocking
on both sides when I'm using FM0 line encoding.

> BTW, some specifications provide a third sense of DTE and DCE in terms 
> of connector definition.
>  
> Thus it is possible to use a DCE connector on the interface that is a 
> DTE in the clock sense and a DCE in the protocol sense.

When you say the DCE is "DTE in the clock sense", do you mean it's
externally clocked?  (And you didn't like my arbitrary selection of DTE
as externally clocked above ;-)

Just to be clear, there's the selection of:
	- physical DTE versus physical DCE
	- logical DTE versus logical DTE
	- who will provide the clock
All three of these are independently chosen.  You can mix and match
and get lots of combinations.

	Steve

------------------------------------------------------------------------
Steve Schefter                               phone: +1 705 725 9999 x26
The Software Group Limited		       fax: +1 705 725 9666
642 Welham Road, 			     email: steve@wanware.com
Barrie, Ontario CANADA  L4N 9A1 	       Web: www.wanware.com

