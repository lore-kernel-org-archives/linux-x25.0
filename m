From: "Gabor Kiss [Bitman]" <kissg@sztaki.hu>
Subject: Buggy kernel header
Date: Fri, 19 Jul 2002 15:20:03 +0200 (MEST)
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <Pine.GS4.4.33.0207191509050.10877-100000@lutra.sztaki.hu>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-x25@vger.kernel.org

You can found in many (all?) kernel version in file include/net/x25.h:

#define X25_DEFAULT_THROUGHPUT  0x0A                    /* Deafult Throughput */

This constant should be 0xAA. The lower nibble describes the troughput class
from caller to called DTE, meanwhile the upper nibble does the same
in opposite direction. Value 0 for this is makes Cisco routers unhappy. ;-)

I listen the zero traffic of this list for weeks.
Is anobody here at all? ;-)

Gabor

