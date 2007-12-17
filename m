From: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: X.25 in linux
Date: Mon, 17 Dec 2007 14:57:42 +0200
Message-ID: <20071217125742.GL6372@mea-ext.zmailer.org>
References: <20071217120054.GJ6372@mea-ext.zmailer.org> <750297.65484.qm@web8406.mail.in.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <750297.65484.qm@web8406.mail.in.yahoo.com>
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ven swe <venkat_p257@yahoo.co.in>
Cc: linux-x25@vger.kernel.org

On Mon, Dec 17, 2007 at 12:25:14PM +0000, ven swe wrote:
> 
> Thanks for your reply Matti.
> 
> I already configured my kernel (version 2.6.22.8) with  "X25_ASY" .
> And I am getting the error message.
> 
> I think this is because slattach is not supporting X25.
> 
> -venkat

It should be trivialish to add that support, if same thing
is enough what SLIP and PPP do  -- turn on the serial discipline
and let driver do everything.

Current slattach man-page tells that known disciplines are:

	slip, cslip, adaptive, ppp


SLIP is really trivial thing in terms of what the slattach
command does.  External scripts and programs then do ifconfig
and other magic for the network interfaces.

You could, probably, do the required moves with e.g. few lines
of perl script.  (Or C)

/Matti Aarnio
