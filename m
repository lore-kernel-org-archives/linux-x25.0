From: "Ian Cass" <ian.cass@mblox.com>
Subject: Re: XOT
Date: Tue, 8 Oct 2002 11:16:08 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <008d01c26eb3$b83c8310$4c28a8c0@cblan.mblox.com>
References: <005f01c26e9c$1c353dc0$f70127d5@britannic>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Hughes <John@Calva.COM>
Cc: linux-x25@vger.kernel.org

It'll just stop accepting inbound X25 connections & stop allowing outgoing
connections to be initiated. A restart of xotd & all x25 daemons cures this.
It'll show this behaviour every 10-12hrs.

--
Ian Cass

----- Original Message -----
From: "John Hughes" <John@Calva.COM>
To: "'Ian Cass'" <ian.cass@mblox.com>
Cc: <linux-x25@vger.kernel.org>
Sent: Tuesday, October 08, 2002 8:27 AM
Subject: RE : XOT


> Ian sez:
> > ... However, it [xot] does work, although not 100% reliably
> > for me at the moment.
>
> What's unreliable for you?
>
> I'm having a little problem making Linux xotd work with my
> home grown implementation, but I think I've tracked it down
> to a difference of opinion about when the TCP call should be
> cleared.
>
> (rfc1613 says:
>
>
>    The TCP connection MUST be created before the virtual circuit
>    can be established.  The TCP connection MAY be maintained after
>    the virtual circuit has been cleared.
>
> Great, it MAY be maintained, but when should it be cleared?  Can
> it be cleared by either end, or only by the caller?)
>
>
>

