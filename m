From: Ashwin Mansinghka <ashwin@midascomm.com>
Subject: Re: XOT and Sockets (X25 over TCP/IP)
Date: Thu, 20 Jun 2002 10:29:06 +0530
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <3D11611A.50501@midascomm.com>
References: <5.0.2.1.2.20020619163143.029c9890@pop.prodigy.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jacque Andre' Bussey <retsam@prodigy.net>
Cc: linux-x25@vger.kernel.org

Hi Jack,

I am also in a similar situation.

Infact I also need to do file transfer between Linux and Maintenance 
Terminals of the switches using FTAM.

I am all lost right now.

I was looking for some free source OSI stack and drivers (Linux) for any 
PCI based X.25 cards.

I also need suggestions on which hardware to choose.

All help is welcome.

with Regards,
ASHWIN

Jacque Andre' Bussey wrote:

> Greetings all,
>
> I am presented with a situation that requires that I monitor 200 Telco 
> switches via X.25. My problem is that my monitoring platform
> is on TCP/IP. I know that with Cisco routers you can map a X.121 
> address to an IP but does that mean I can make a TCP/IP connection to 
> that device? If not, is there any software that I can run on a Unix 
> box that can map a Socket back to that device over TCP/IP? (a listener 
> on the Unix box gets a connection then forwards that via X.25 
> encapsulated in TCP/IP to the far side X.25 on the other side of the 
> XOT cisco router. *WHEEEW*)
>
>
> Any help will be greatly appreciated ,
>
>
> Jacque Bussey
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-x25" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


