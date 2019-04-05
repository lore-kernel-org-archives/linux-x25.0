From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/4] wan/hdlc_x25: fix skb handling
Date: Thu, 04 Apr 2019 17:32:40 -0700 (PDT)
Message-ID: <20190404.173240.1338878948110207179.davem@davemloft.net>
References: <20190403050118.12785-1-ms@dev.tdt.de>
        <20190403050118.12785-2-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190403050118.12785-2-ms@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: andrew.hendry@gmail.com, khc@pm.waw.pl, isdn@linux-pingi.de, edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Wed,  3 Apr 2019 07:01:16 +0200

>  	/* X.25 to LAPB */
>  	switch (skb->data[0]) {
>  	case X25_IFACE_DATA:	/* Data to be transmitted */
> -		skb_pull(skb, 1);
> -		if ((result = lapb_data_request(dev, skb)) != LAPB_OK)
> -			dev_kfree_skb(skb);
> -		return NETDEV_TX_OK;
> +		skbn = skb_copy(skb, GFP_ATOMIC);
> +		skb_pull(skbn, 1);
> +		skb_reset_network_header(skbn);
> +		if ((result = lapb_data_request(dev, skbn)) != LAPB_OK)
> +			dev_kfree_skb(skbn);

This leaks 'skb'.

No way I'm applying this stuff.
