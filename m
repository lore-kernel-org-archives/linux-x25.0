From: Bek <berikm@pisem.net>
Subject: Using x25_asy.o
Date: Fri, 28 Jun 2002 11:31:46 +0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <929631289.20020628113146@pisem.net>
Reply-To: Bek <berikm@pisem.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org

Hello ALL,

Is it possible to organize connection over "clean"(no incapsulation :-)) x.25 between, linux box
and, for example, EiconCard, using layout like that:
+-------+                +-----+                   +-----+ +---------+
| LINUX |-(/dev/x25asy0)-|modem|----leased line----|modem|-|EiconCard|
+-------+                +-----+                   +-----+ +---------+


Is there any ready to use daemon like pppd?

Thanx everyone in advance.

-- 
Best regards,
 Bek

