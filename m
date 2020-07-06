From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Fixed the value of
 hard_header_len
Date: Mon, 06 Jul 2020 12:16:36 -0700 (PDT)
Message-ID: <20200706.121636.148338846008093922.davem@davemloft.net>
References: <20200706004521.78091-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200706004521.78091-1-xie.he.0141@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, madhuparnabhowmik04@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

From: Xie He <xie.he.0141@gmail.com>
Date: Sun,  5 Jul 2020 17:45:21 -0700

> When this driver transmits data,
>   first this driver will remove a pseudo header of 1 byte,
>   then the lapb module will prepend the LAPB header of 2 or 3 bytes,
>   then this driver will prepend a length field of 2 bytes,
>   then the underlying Ethernet device will prepend its own header.
> 
> So, the header length required should be:
>   -1 + 3 + 2 + "the header length needed by the underlying device".
> 
> This patch fixes kernel panic when this driver is used with AF_PACKET
> SOCK_DGRAM sockets.
> 
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thank you.
