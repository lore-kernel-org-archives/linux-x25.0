From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next] net: lapbether: Consider it successful if
 (dis)connecting when already (dis)connected
Date: Thu, 10 Dec 2020 07:41:28 +0100
Message-ID: <15c1ad7b52562e2ca37d8084a90197d8@dev.tdt.de>
References: <20201208225044.5522-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201208225044.5522-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-12-08 23:50, Xie He wrote:
> When the upper layer instruct us to connect (or disconnect), but we 
> have
> already connected (or disconnected), consider this operation successful
> rather than failed.
> 
> This can help the upper layer to correct its record about whether we 
> are
> connected or not here in layer 2.
> 
> The upper layer may not have the correct information about whether we 
> are
> connected or not. This can happen if this driver has already been 
> running
> for some time when the "x25" module gets loaded.
> 
> Another X.25 driver (hdlc_x25) is already doing this, so we make this
> driver do this, too.

Looks good to me.

Acked-by: Martin Schiller <ms@dev.tdt.de>

> 
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  drivers/net/wan/lapbether.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> index b6be2454b8bd..605fe555e157 100644
> --- a/drivers/net/wan/lapbether.c
> +++ b/drivers/net/wan/lapbether.c
> @@ -55,6 +55,9 @@ struct lapbethdev {
> 
>  static LIST_HEAD(lapbeth_devices);
> 
> +static void lapbeth_connected(struct net_device *dev, int reason);
> +static void lapbeth_disconnected(struct net_device *dev, int reason);
> +
>  /* 
> ------------------------------------------------------------------------ 
> */
> 
>  /*
> @@ -167,11 +170,17 @@ static netdev_tx_t lapbeth_xmit(struct sk_buff 
> *skb,
>  	case X25_IFACE_DATA:
>  		break;
>  	case X25_IFACE_CONNECT:
> -		if ((err = lapb_connect_request(dev)) != LAPB_OK)
> +		err = lapb_connect_request(dev);
> +		if (err == LAPB_CONNECTED)
> +			lapbeth_connected(dev, LAPB_OK);
> +		else if (err != LAPB_OK)
>  			pr_err("lapb_connect_request error: %d\n", err);
>  		goto drop;
>  	case X25_IFACE_DISCONNECT:
> -		if ((err = lapb_disconnect_request(dev)) != LAPB_OK)
> +		err = lapb_disconnect_request(dev);
> +		if (err == LAPB_NOTCONNECTED)
> +			lapbeth_disconnected(dev, LAPB_OK);
> +		else if (err != LAPB_OK)
>  			pr_err("lapb_disconnect_request err: %d\n", err);
>  		fallthrough;
>  	default:
