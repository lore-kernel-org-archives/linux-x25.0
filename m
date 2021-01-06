From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net: lapb: Decrease the refcount of "struct lapb_cb"
 in lapb_device_event
Date: Wed, 06 Jan 2021 08:35:32 +0100
Message-ID: <4bba668b619e32e87e713b5b9d0876a7@dev.tdt.de>
References: <20201231174331.64539-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201231174331.64539-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-12-31 18:43, Xie He wrote:
> In lapb_device_event, lapb_devtostruct is called to get a reference to
> an object of "struct lapb_cb". lapb_devtostruct increases the refcount
> of the object and returns a pointer to it. However, we didn't decrease
> the refcount after we finished using the pointer. This patch fixes this
> problem.
> 
> Fixes: a4989fa91110 ("net/lapb: support netdev events")
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  net/lapb/lapb_iface.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
> index 213ea7abc9ab..40961889e9c0 100644
> --- a/net/lapb/lapb_iface.c
> +++ b/net/lapb/lapb_iface.c
> @@ -489,6 +489,7 @@ static int lapb_device_event(struct notifier_block
> *this, unsigned long event,
>  		break;
>  	}
> 
> +	lapb_put(lapb);
>  	return NOTIFY_DONE;
>  }

Well, I guess I missed that one. Thank you!

Acked-by: Martin Schiller <ms@dev.tdt.de>
