From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net: hdlc_x25: Return meaningful error code in
 x25_open
Date: Thu, 04 Feb 2021 07:20:23 +0100
Message-ID: <352fd651d4fd98e46f7c58fc05eea4e7@dev.tdt.de>
References: <20210203071541.86138-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20210203071541.86138-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Halasa <khc@pm.waw.pl>

On 2021-02-03 08:15, Xie He wrote:
> It's not meaningful to pass on LAPB error codes to HDLC code or other
> parts of the system, because they will not understand the error codes.
> 
> Instead, use system-wide recognizable error codes.
> 
> Fixes: f362e5fe0f1f ("wan/hdlc_x25: make lapb params configurable")
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  drivers/net/wan/hdlc_x25.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wan/hdlc_x25.c b/drivers/net/wan/hdlc_x25.c
> index bb164805804e..4aaa6388b9ee 100644
> --- a/drivers/net/wan/hdlc_x25.c
> +++ b/drivers/net/wan/hdlc_x25.c
> @@ -169,11 +169,11 @@ static int x25_open(struct net_device *dev)
> 
>  	result = lapb_register(dev, &cb);
>  	if (result != LAPB_OK)
> -		return result;
> +		return -ENOMEM;
> 
>  	result = lapb_getparms(dev, &params);
>  	if (result != LAPB_OK)
> -		return result;
> +		return -EINVAL;
> 
>  	if (state(hdlc)->settings.dce)
>  		params.mode = params.mode | LAPB_DCE;
> @@ -188,7 +188,7 @@ static int x25_open(struct net_device *dev)
> 
>  	result = lapb_setparms(dev, &params);
>  	if (result != LAPB_OK)
> -		return result;
> +		return -EINVAL;
> 
>  	return 0;
>  }

Thanks for fixing this.

Acked-by: Martin Schiller <ms@dev.tdt.de>
