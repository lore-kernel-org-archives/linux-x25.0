From: Andrew Hendry <ahendry@tusc.com.au>
Subject: Re: CISCO with xot
Date: Mon, 30 Aug 2004 08:59:33 +1000
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <1093820373.2289.16.camel@ahendry>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: frederico@ati.com.br
Cc: linux-x25@vger.kernel.org

Is there any patch to use xotd with PVC ?

For xotd with PVCs I dont know of a patch, its in the TODO for xotd.
Would having the PVC's on the router x25 side and just have xotd like
normal on the ip side do what you need?

With the diagram below:
- You could use IP over x25 on the x25 side of the router and have the
applications on both hosts use IP.
or
http://www.cisco.com/en/US/tech/tk713/tk730/technologies_configuration_example09186a0080094a46.shtml

Andrew.

On Sat, 2004-08-28 at 07:25, Frederico Faria wrote:
>    Hi,
> 
>      Is somebody using CISCO routers ?!
>      Today I use xotd with CISCO.  Is there any configuration for  the
> CISCO routers TCP/IP ( pure, without xotd )  to X25  ? As below:
> 
> 
>               Host-----> TCP/IP ----> CISCO ---> X25 --->Host
> 
> Thank you.
> 
> Frederico Faria

