From: Neal Norwitz <neal@metaslash.com>
Subject: X.25 crashes in 2.4.20
Date: Fri, 06 Jun 2003 10:07:09 -0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <20030606140709.GA15818@epoch.metaslash.com>
Reply-To: neal@metaslash.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org
Cc: eis@baty.hanse.de

I'm using X.25 on 2.4.20 User Mode Linux (UML) with Henner Eisen's
loopback patch.  The reason I'm using UML is that in the past, I've
heard of crashes due to X.25.  But I am also experiencing crashes
within UML.  The crashes have almost always occurred when doing
netstat -Ax25.

Is this the correct place to discuss these issues?
Has there been any progress made on X.25 stability or features?

I can try to help develop/debug if someone can provide more info.

Thanks,
Neal
