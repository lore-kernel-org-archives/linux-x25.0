From: Frederico Faria <frederico@ati.com.br>
Subject: XOT Configuration
Date: Fri, 16 Jan 2004 08:50:16 -0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <4007C1E8.7040003@ati.com.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-x25@vger.kernel.org


  Hi,

   I have two linux box that communicate using X25 sockets over 
lapb-ethernet.  The hostA runs the  X25 socket client application and 
hostB runs  the x25 server socket application:

     hostA --------- LAPB ( ethernet )--------hostB.

This configuration  is working fine!


Now I want to configure the XOT ( using xotd daemon ) for the link 
between hostA and hostB.

My X25 route configured in "hostA" is:

  route add -Ax25 33/2 lapb0  //33 is the X25 addr. of server in "hostB"

Then I run xotd in "hostA" as:

  xotd -v lapb0  IP-HOSTB   // IP-HOSTB is the IP address of "hostB"

The X25 route in "hostB" is:

  route add -Ax25 0/0 lapb0

In "hostB" I didn't run the xotd daemon.

Then I run again the sockets applications and everything continues 
working fine,  but nothing to appear in xotd debug. Then I think that 
the XOT  isn't being used.

My doubt is How configure the two x25 linux box above to use the XOT.
  Is the hostA xotd configuration correct  ? do I need to run the xotd 
daemon in host B ?  is it necessary some modification in X25 socket 
applications ?   Is there any configuration example ?


Thank you,

Faria


-- 
Frederico Charles S. Faria
ATI / ATITEL  Ltda
www.ati.com.br
(31) - 3275-3100


