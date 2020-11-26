From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v6 2/5] net/lapb: support netdev events
Date: Thu, 26 Nov 2020 07:14:24 +0100
Message-ID: <5c74d51e4cd3ee0aae47c84988dbbf91@dev.tdt.de>
References: <20201124093938.22012-3-ms@dev.tdt.de>
 <20201126000814.12108-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201126000814.12108-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-11-26 01:08, Xie He wrote:
> Hi Martin,
> 
> Since we are going to assume lapb->state would remain in LAPB_STATE_0 
> when
> the carrier is down (as understood by me. Right?), could we add a check 
> in
> lapb_connect_request to reject the upper layer's "connect" instruction 
> when
> the carrier is down? Like this:

No, because this will break the considered "on demand" calling feature.

> 
> diff --git a/include/linux/lapb.h b/include/linux/lapb.h
> index eb56472f23b2..7923b1c6fc6a 100644
> --- a/include/linux/lapb.h
> +++ b/include/linux/lapb.h
> @@ -14,6 +14,7 @@
>  #define	LAPB_REFUSED		5
>  #define	LAPB_TIMEDOUT		6
>  #define	LAPB_NOMEM		7
> +#define	LAPB_NOCARRIER		8
> 
>  #define	LAPB_STANDARD		0x00
>  #define	LAPB_EXTENDED		0x01
> diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
> index 3c03f6512c5f..c909d8db1bef 100644
> --- a/net/lapb/lapb_iface.c
> +++ b/net/lapb/lapb_iface.c
> @@ -270,6 +270,10 @@ int lapb_connect_request(struct net_device *dev)
>  	if (!lapb)
>  		goto out;
> 
> +	rc = LAPB_NOCARRIER;
> +	if (!netif_carrier_ok(dev))
> +		goto out_put;
> +
>  	rc = LAPB_OK;
>  	if (lapb->state == LAPB_STATE_1)
>  		goto out_put;
> 
> Also, since we are going to assume the lapb->state would remain in
> LAPB_STATE_0 when the carrier is down, are the
> "lapb->state == LAPB_STATE_0" checks in carrier-up/device-up event
> handling necessary? If they are not necessary, it might be better to
> remove them because it may confuse people reading the code.

They are still necessary, because if the link setup is initiated by
upper layers, we've already entered the respective state by
lapb_connect_request().


Every suggestion for improvement is really welcome, but please let this
patch set pass now, if you don't find any more gross errors.

Martin
