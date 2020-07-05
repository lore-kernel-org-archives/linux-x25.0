From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Fixed the value of
 hard_header_len
Date: Sat, 04 Jul 2020 17:52:46 -0700 (PDT)
Message-ID: <20200704.175246.123858644791564054.davem@davemloft.net>
References: <20200704051246.203413-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200704051246.203413-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, madhuparnabhowmik04@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

From: Xie He <xie.he.0141@gmail.com>
Date: Fri,  3 Jul 2020 22:12:46 -0700

> When transmitting data from upper layers or from AF_PACKET sockets,
>   this driver will first remove a pseudo header of 1 byte,
>   then the lapb module will prepend the LAPB header of 2 or 3 bytes,
>   then this driver will prepend a length field of 2 bytes,
>   then the underlying Ethernet device will prepend its own header.

Please add something like this above text to a comment:

> @@ -324,6 +323,8 @@ static int lapbeth_new_device(struct net_device *dev)
>  	if (!ndev)
>  		goto out;
>  
> +	ndev->hard_header_len = -1 + 3 + 2 + dev->hard_header_len;
> +

Above this new line so that someone reading the code can understand
these magic numbers and what they mean.

Thank you.
