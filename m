From: Ferenci Daniel <Daniel.Ferenci@siemens.com>
Subject: new patches
Date: Fri, 12 Nov 2004 15:39:44 +0100
Message-ID: <4194CB30.90703@siemens.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-x25@vger.kernel.org

Hi all x25 linux people,

I would like to contribute with some patches.

- hdlc_bridge patch - creates new hdlc stack and I found it usable for 
hdlc sniffer (within 2 hdlc devices)


- x25_forward patch - extends capabilities of current x25 stack
                                        stack is then able to forward 
x25 packets which are not originated from local maschine or not roted to 
local maschine
                                        I found it usable with tap 
devices forward traffic through maschine (x25 router)

- updated version of sethdlc.c

All this you can find at
http://www.dafe.net/x25/

Regards
Daniel Ferenci.



