From: Jerzy Tryjarski <jurekt@pkp.com.pl>
Subject: ip over x.25
Date: Mon, 18 Aug 2003 15:06:10 +0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <3F40CF42.2020001@pkp.com.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-x25@vger.kernel.org

Hi,
  I want to connect my PC under linux RH 9 with e-mail server  via X.25 
packet network.
                                                                                                                        
 
IP datagrams are encapsulated inside packets on an X.25 virtual circuit.
                                                                                                                        
 
Mail server is connected to X.25 network via Cisco router. So I use the 
IETF standard encapsulation, as specified by RFC
1356, set X.121 address, set IP address and I map between X.121 address 
and IP address.
                                                                                                                        
 
Finaly in my pc It must be additional software for rs232 and user 
application to be abble to configure the interface with such as 
functions as assigning IP address, assigning X.121 address, mapping, pad 
and other specific for X.25 network functions.
                                                                                                                        
 
Are there products just for Linux ?
                                                                                                                        
 
Can anybody recommend the best solution ?
                                                                                                                        
 
Jurek


