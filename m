From: Dermot Smith <dermot.smith@farsite.co.uk>
Subject: RE: XOT and Sockets (X25 over TCP/IP)
Date: Thu, 20 Jun 2002 09:10:28 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <7C078C66B7752B438B88E11E5E20E72E0E3C75@GENERAL.farsite.co.uk>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Lange, Harald'" <Harald.Lange@t-systems.com>, linux-x25@vger.kernel.org

I was looking at this very same issue yesterday for a customer but they
couldn't use the "translate" command you mentioned because (as stated in the
Cisco document you linked to) it is only available in the ENTERPRISE edition
of IOS software on the 2600 series and above making it a very expensive
solution for them.

Regards

Dermot Smith

Jacque, Ashwin: if you are still looking for a PCI X.25 card, do take a look
at our range which have drivers included as standard for 2.2 and 2.4 series
kernels: www.farsite.co.uk.

-----Original Message-----
From: Lange, Harald [mailto:Harald.Lange@t-systems.com]
Sent: 20 June 2002 08:00
To: retsam@prodigy.net; linux-x25@vger.kernel.org
Subject: AW: XOT and Sockets (X25 over TCP/IP)

Hello Jaque,

the Cicso router has a 'translate' command.
see: http://www.cisco.com/warp/public/133/x25_tcptrans.html

When you connect the router with the appropriate destination address, the
cisco will perform a X.25 connect to the X.25 system. We did this with a
Cisco 2600 and everything worked well.

This may possibly solve your problem.


Best Regards

Harald Lange

----------------------------------------------------------------------------
T-Systems
Kommunikation
Systems Integration
T-Systems Nova GmbH
Entwicklungszentrum Nord
Hausadresse: Willy-Brandt-Platz 3, 28215 Bremen
Telefon: +49-421-37 99-474,
Telefax: +49-421-37 99-4 09
E-Mail: harald.lange@t-systems.com
Internet: http://www.t-systems.com



-----Ursprungliche Nachricht-----
Von: Jacque Andre' Bussey [mailto:retsam@prodigy.net]
Gesendet: Mittwoch, 19. Juni 2002 23:39
An: linux-x25@vger.kernel.org
Betreff: XOT and Sockets (X25 over TCP/IP)


Greetings all,

I am presented with a situation that requires that I monitor 200 Telco
switches via X.25. My problem is that my monitoring platform
is on TCP/IP. I know that with Cisco routers you can map a X.121 address to
an IP but does that mean I can make a TCP/IP connection to that device? If
not, is there any software that I can run on a Unix box that can map a
Socket back to that device over TCP/IP? (a listener on the Unix box gets a
connection then forwards that via X.25 encapsulated in TCP/IP to the far
side X.25 on the other side of the XOT cisco router. *WHEEEW*)


Any help will be greatly appreciated ,


Jacque Bussey

-
To unsubscribe from this list: send the line "unsubscribe linux-x25" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
-
To unsubscribe from this list: send the line "unsubscribe linux-x25" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
