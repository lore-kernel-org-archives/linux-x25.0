From: TProvoni@aol.com
Subject: Re: Null X.25 cable?
Date: Sat, 15 May 2004 15:46:21 EDT
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <1db.21926d64.2dd7cd8d@aol.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: steve@wanware.com, un@rootelecom.ru, linux-x25@vger.kernel.org

Wanware hardware sounds somewhat restrictive in its clock
configurations.  I have worked with several vendors' equipment that
allows symmetric independent clocking.  Transmit clocks are sent from
both sides and the receivers extract the clocks as they receive data.
Of course, even in symmetric clocking setups, one side must be the
logical or protocol DCE and the other must be the logical or protocol
DTE.

Joachim Martillo 

BTW, some specifications provide a third sense of DTE
and DCE in terms of connector definition.

Thus it is possible to use a DCE connector on the interface that is a
DTE in the clock sense and a DCE in the protocol sense.

In a message dated 5/14/04 9:25:32 AM Eastern Daylight Time, 
steve@wanware.com writes:
Hi.

>>   Is there any way to connect two X.25 card directly via cable (may be
>>   NULL MODEM)?
>>   If yes, what configuration of connectors it must have?
>>   Will two cards (configured as DTE) work together?
>> 
>>   If anyone knows, please help!
>
>The short answer is yes.
>
>But in order for this to work, there are a few things you need to
>check.
>
>First, the card must be capable of being internally clocked.  One
>side will need to be setup as internal and the other as external.
>
>Second, make sure you use a synchronous null modem cable.  The
>more common async null modem won't route the clocks properly between
>the two sides (it just crosses the data and control signals).
>You'll need to make sure that the "I" side of the null modem goes
>to the side that has the clocking set to internal.
>
>Third, there are two concepts of DTE and DCE in X.25: physical and
>logical.  The null modem will take care of the fact that you are
>connecting two physical DTEs together, but you also need to change
>the logical setting (in software) to DCE on one side.
>
>You can find the pinout for null modem cables for various electrical
>interfaces on our website under "support".
>
>There's also an application note covering this topic on our website:
>http://www.wanware.com/index.php?page=support/app_notes/mach2mach&menu=suppor
t
>
>Regards,
>    Steve
