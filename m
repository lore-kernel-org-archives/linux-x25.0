From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH 2/4] wan/hdlc_x25: fix skb handling
Date: Fri, 05 Apr 2019 08:56:44 +0200
Message-ID: <cf0354c31dd1a20c07d38bd465df5896@dev.tdt.de>
References: <20190403050118.12785-1-ms@dev.tdt.de>
 <20190403050118.12785-2-ms@dev.tdt.de>
 <20190404.173240.1338878948110207179.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190404.173240.1338878948110207179.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Miller <davem@davemloft.net>
Cc: andrew.hendry@gmail.com, khc@pm.waw.pl, isdn@linux-pingi.de, edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2019-04-05 02:32, David Miller wrote:
> From: Martin Schiller <ms@dev.tdt.de>
> Date: Wed,  3 Apr 2019 07:01:16 +0200
> 
>>  	/* X.25 to LAPB */
>>  	switch (skb->data[0]) {
>>  	case X25_IFACE_DATA:	/* Data to be transmitted */
>> -		skb_pull(skb, 1);
>> -		if ((result = lapb_data_request(dev, skb)) != LAPB_OK)
>> -			dev_kfree_skb(skb);
>> -		return NETDEV_TX_OK;
>> +		skbn = skb_copy(skb, GFP_ATOMIC);
>> +		skb_pull(skbn, 1);
>> +		skb_reset_network_header(skbn);
>> +		if ((result = lapb_data_request(dev, skbn)) != LAPB_OK)
>> +			dev_kfree_skb(skbn);
> 
> This leaks 'skb'.

What exactly do you mean?
'skb' will get freed at the end of x25_xmit() function:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/wan/hdlc_x25.c#n129

> 
> No way I'm applying this stuff.

