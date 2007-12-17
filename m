From: venkat4p <venkat_p257@yahoo.co.in>
Subject: X.25 in linux
Date: Sun, 16 Dec 2007 21:11:16 -0800 (PST)
Message-ID: <14370077.post@talk.nabble.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org


Hai all,
 
I want to make two Linux systems communicating through X.25 suite.
I am successful in sending data through X.25 PLP over lapb over
Ethernet. (by using X25 socket API, x25route and lapb0 virtual interface)
 
Now, I want to communicate via lapb over serial interface (like "ttyS0")
instead
of Ethernet layer.
I installed Net-tools package, then I tried with "slattach -p x25
/dev/ttyS0" but got message
> Cannot change line discipline to `x25'.
Can any one tell me from where can I get the modified version of "slattach" 
so that it supports X25 Async network interface or any available  modules
which helps me in doing this?
 
Thanks,
Venkat.
-- 
View this message in context: http://www.nabble.com/X.25-in-linux-tp14370077p14370077.html
Sent from the linux-x25 mailing list archive at Nabble.com.

