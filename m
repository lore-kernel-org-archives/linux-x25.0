From: Bill Lynn <blynn@gwdi.com>
Subject: Re: Buggy kernel header
Date: Fri, 19 Jul 2002 08:25:33 +0000
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <3D37CCFD.6F2504F0@gwdi.com>
References: <Pine.GS4.4.33.0207191509050.10877-100000@lutra.sztaki.hu>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 
Cc: linux-x25@vger.kernel.org

Gabor,

   Thanks! I'll make the change to my source right away. I'm not currently using
any Cisco routers but this will head off any future Cisco hardware.

Regards,
Bill

"Gabor Kiss [Bitman]" wrote:

> You can found in many (all?) kernel version in file include/net/x25.h:
>
> #define X25_DEFAULT_THROUGHPUT  0x0A                    /* Deafult Throughput */
>
> This constant should be 0xAA. The lower nibble describes the troughput class
> from caller to called DTE, meanwhile the upper nibble does the same
> in opposite direction. Value 0 for this is makes Cisco routers unhappy. ;-)
>
> I listen the zero traffic of this list for weeks.
> Is anobody here at all? ;-)
>
> Gabor
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-x25" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

