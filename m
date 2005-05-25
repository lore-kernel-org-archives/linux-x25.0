From: Bahri Okuroglu <bahrio@yahoo.com>
Subject: Can't an application (running on X25/LAPB/x25_asy) converge to the line speed?
Date: Wed, 25 May 2005 00:01:51 -0700 (PDT)
Message-ID: <20050525070151.86862.qmail@web54109.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-x25@vger.kernel.org

I've been playing with X25/LAPB with x25-asy driver
running on serial ports. I've modified x25-asy driver
to add CRC and to configure LAPB to act as DCE or DTE.
With the last change, I can have one port acting as
DCE and another acting as DTE for LAPB on the same PC.


I've looped COM1 and COM2 using a cable with full
handshake pins connected, and x25asy is set as line
discipline for COM1(dce) and COM2(dte) at 115200kbps
speed. Please note that I've modified slattach also,
to let ports to be selected as DCE or DTE. MTU was 256
as default, and I've set it to 2048 bytes to reduce
the overhead of X25/LAPB headers and to increase the
buffer kept at x25-asy code. 

It seems that UART interrupt handler code keeps 4K
buffer to buffer the data coming from upper layers,
and reads from this buffer in the interrupt for the
new data request from UART. 

After bringing the new network interfaces x25asy0 and
x25asy1 up and setting the relevant routes up, I've
tried to evaluate the performance using a simple
greedy application, which is basically sleeping on
socket using select() for read and write operations.
Both server and client are sending data in 1K blocks
whenever possible and reading data whenever available.
Client terminates the connection after 100 secs and
reports the average speed experienced for both
incoming and outgoing directions.

With those large buffers (2K at x25-asy and 4K at UART
driver), I was expecting to see a speed about 100kpbs
data rate at the application level; but I've seen
about 50kbps for both directions (full duplex).

- First I suspected the CPU power, but with that
traffic rate, CPU is about 50% idle (PIV 1600MHz with
2.4 kernel). 

- Another possible problem could be the delay between
the driver and application for data feed-up. But the
application is always writing as far as select() lets;
and we have relatively large buffers in driver codes. 

- I haven't used the extended mode, but 7 as the
window size should be enough since the propagation
delay is quite low.

I also tried 19200kpbs link speed and observed about
13kbps full duplex data rate. 

Is this reasonable? Can't I converge to the link speed
at the application level? Or am I doing something
wrong? Any idea is welcome...



__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
