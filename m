From: Ferenci Daniel <Daniel.Ferenci@siemens.com>
Subject: BUG in X25 stack
Date: Fri, 06 Aug 2004 16:59:01 +0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <41139CB5.9050100@siemens.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-x25@vger.kernel.org

Hi List,

I found bug in X25 linux stack.

It is in x25.h file
define value X25_DEFAULT_THROUGHPUT had default value 0x0A.
But 0 is not allowed Troughput facility number and CISCO router uses to 
drop the connection.

The rigth value can be for example
#define    X25_DEFAULT_THROUGHPUT    0xAA
Then I was able to route x25 connection from Linux trough CISCO.

Regards
Daniel Ferenci.




