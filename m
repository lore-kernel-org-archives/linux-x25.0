From: Derek Vair <derek@wanware.com>
Subject: Re: CISCO with xot
Date: Mon, 30 Aug 2004 09:44:31 -0400
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <41332F3F.5040802@wanware.com>
References: <1093820373.2289.16.camel@ahendry>
Reply-To: derek@wanware.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <1093820373.2289.16.camel@ahendry>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Andrew Hendry <ahendry@tusc.com.au>
Cc: frederico@ati.com.br, linux-x25@vger.kernel.org

Hello Andrew and Frederico:

Even if there were (a patch for xotd and PVCs), it wouldn't do any 
good.  As far as I know, the public domain X.25 that comes with Linux 
doesn't support PVCs. 

If you want to run PVCs over an IP network, we offer a solution based on 
an embedded (diskless, fanless) device on one side of the network (next 
to the host that has only an X.25 interface), and an X.25 API library 
that interfaces with TCP/IP at the other. (we're one of those "non-free" 
vendors that Frederico refers to in an earlier post to the list).  Drop 
me a line by e-mail if you'd like to know more.


Derek



Andrew Hendry wrote:

>Is there any patch to use xotd with PVC ?
>  
>
>For xotd with PVCs I dont know of a patch, its in the TODO for xotd.
>Would having the PVC's on the router x25 side and just have xotd like
>normal on the ip side do what you need?
>
>With the diagram below:
>- You could use IP over x25 on the x25 side of the router and have the
>applications on both hosts use IP.
>or
>http://www.cisco.com/en/US/tech/tk713/tk730/technologies_configuration_example09186a0080094a46.shtml
>
>Andrew.
>
>On Sat, 2004-08-28 at 07:25, Frederico Faria wrote:
>  
>
>>   Hi,
>>
>>     Is somebody using CISCO routers ?!
>>     Today I use xotd with CISCO.  Is there any configuration for  the
>>CISCO routers TCP/IP ( pure, without xotd )  to X25  ? As below:
>>
>>
>>              Host-----> TCP/IP ----> CISCO ---> X25 --->Host
>>
>>Thank you.
>>
>>Frederico Faria
>>    
>>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-x25" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  
>

-- 
Derek Vair
The Software Group Limited        Tel:    +1(705)725-9999x22
642 Welham Road			    Fax:    +1(705)725-9666
Barrie, Ontario			    e-mail: derek@wanware.com
Canada L4N 9A1			    web:    www.wanware.com


