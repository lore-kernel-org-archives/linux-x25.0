From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net: lapbether: Remove netif_start_queue /
 netif_stop_queue
Date: Tue, 09 Mar 2021 14:48:30 +0100
Message-ID: <6f885ff41da24d41cb5d430d9abe42f7@dev.tdt.de>
References: <20210307113309.443631-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20210307113309.443631-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2021-03-07 12:33, Xie He wrote:
> For the devices in this driver, the default qdisc is "noqueue",
> because their "tx_queue_len" is 0.
> 
> In function "__dev_queue_xmit" in "net/core/dev.c", devices with the
> "noqueue" qdisc are specially handled. Packets are transmitted without
> being queued after a "dev->flags & IFF_UP" check. However, it's 
> possible
> that even if this check succeeds, "ops->ndo_stop" may still have 
> already
> been called. This is because in "__dev_close_many", "ops->ndo_stop" is
> called before clearing the "IFF_UP" flag.
> 
> If we call "netif_stop_queue" in "ops->ndo_stop", then it's possible in
> "__dev_queue_xmit", it sees the "IFF_UP" flag is present, and then it
> checks "netif_xmit_stopped" and finds that the queue is already 
> stopped.
> In this case, it will complain that:
> "Virtual device ... asks to queue packet!"
> 
> To prevent "__dev_queue_xmit" from generating this complaint, we should
> not call "netif_stop_queue" in "ops->ndo_stop".
> 
> We also don't need to call "netif_start_queue" in "ops->ndo_open",
> because after a netdev is allocated and registered, the
> "__QUEUE_STATE_DRV_XOFF" flag is initially not set, so there is no need
> to call "netif_start_queue" to clear it.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  drivers/net/wan/lapbether.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
> index 605fe555e157..c3372498f4f1 100644
> --- a/drivers/net/wan/lapbether.c
> +++ b/drivers/net/wan/lapbether.c
> @@ -292,7 +292,6 @@ static int lapbeth_open(struct net_device *dev)
>  		return -ENODEV;
>  	}
> 
> -	netif_start_queue(dev);
>  	return 0;
>  }
> 
> @@ -300,8 +299,6 @@ static int lapbeth_close(struct net_device *dev)
>  {
>  	int err;
> 
> -	netif_stop_queue(dev);
> -
>  	if ((err = lapb_unregister(dev)) != LAPB_OK)
>  		pr_err("lapb_unregister error: %d\n", err);

Seems reasonable to me.

Acked-by: Martin Schiller <ms@dev.tdt.de>
