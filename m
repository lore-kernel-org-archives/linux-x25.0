From: Kevin Curtis <kevin.curtis@farsite.co.uk>
Subject: RE: Buggy kernel header
Date: Fri, 19 Jul 2002 14:25:08 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0EF457@GENERAL.farsite.co.uk>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Gabor Kiss [Bitman]'" <kissg@sztaki.hu>, linux-x25@vger.kernel.org

Hi Gabor,
	you are not the only one to listen to zero traffic.  It couldn't be
more opposite to the main kernel list.  I am currently working on a sockets
interface to our FarSync X.25 card which should be compatible with the
Kernel X.25 module.  I am actually looking for some applications that I
could test my implementation against.  If anyone has any such applications
that I can try please let me know.

Thanks for you input on the default throughput.

Kevin

-----Original Message-----
From: Gabor Kiss [Bitman] [mailto:kissg@sztaki.hu]
Sent: 19 July 2002 14:20
To: linux-x25@vger.kernel.org
Subject: Buggy kernel header


You can found in many (all?) kernel version in file include/net/x25.h:

#define X25_DEFAULT_THROUGHPUT  0x0A                    /* Deafult
Throughput */

This constant should be 0xAA. The lower nibble describes the troughput class
from caller to called DTE, meanwhile the upper nibble does the same
in opposite direction. Value 0 for this is makes Cisco routers unhappy. ;-)

I listen the zero traffic of this list for weeks.
Is anobody here at all? ;-)

Gabor

-
To unsubscribe from this list: send the line "unsubscribe linux-x25" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
