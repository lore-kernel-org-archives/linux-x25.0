From: "Ian Cass" <ian.cass@mblox.com>
Subject: Re: XOT and Sockets (X25 over TCP/IP)
Date: Thu, 20 Jun 2002 11:57:36 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <016501c21849$4a393ea0$6602a8c0@salamander>
References: <5.0.2.1.2.20020619163143.029c9890@pop.prodigy.net> <001b01c21835$313a1aa0$6602a8c0@salamander> <20020620125104.K1057@prism.co.za>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Bernd Jendrissek <berndj@prism.co.za>
Cc: linux-x25@vger.kernel.org

> When is facilities.throughput ever set to 0?  The only place I can find is
in
> net/x25/x25_facilities.c

Because some (possibly broken) German X25 networks do not support that
particular facility. It's been a long time since I actually coded this
stuff, but it made sense back then and fixed our problem in a way
non-detrimental to other uses.

--
Ian Cass

