From: Prasanna Kumar K <kumarkp@knowsys.net>
Subject: Blocking write and read on X.25 sockets
Date: Mon, 22 Apr 2002 11:46:23 +0530
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <3CC3AAB7.5000009@knowsys.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-x25@vger.kernel.org

Hi Group,

    I have a strange problem in using the X.25 under linux. I have a 
server listenining on x.25 socket and a x.25 client sending data to the 
server. The client writes data in a chunk of 256 bytes in a while loop 
and the server stores the data received to a file. Things work fine for 
sometime. But, after successfully transferring some data (size varies 
from about 50k to 500k) the write call at the client and the read call 
at the server both blocks. After certain time, both come out indicating 
"Network unreachable" (error number 101).

    I also observe that the server has received about 20k data less that 
what is successfully written by the client!

    Can anyone help me in identifying what's going wrong!? Here are the 
details on my environmet:

NET4: LAPB for Linux. Version 0.01 for NET4.0 

X.25 for Linux. Version 0.2 for Linux 2.1.15
LAPB Ethernet driver version 0.01
Redhat Linux: 2.4.2-2
X.25 server address: 123451234512345
x.25 client address: 123451234512344

Thanks and regards,
:)Prasanna


