From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net/x25: Fix skb leak in x25_lapb_receive_frame()
Date: Mon, 14 Nov 2022 12:53:48 +0100
Message-ID: <ca0d14934e90d4767309cea20e6510dd@dev.tdt.de>
References: <20221114110519.514538-1-weiyongjun@huaweicloud.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20221114110519.514538-1-weiyongjun@huaweicloud.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Wei Yongjun <weiyongjun@huaweicloud.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Hendry <andrew.hendry@gmail.com>, Matthew Daley <mattjd@gmail.com>, Wei Yongjun <weiyongjun1@huawei.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org

On 2022-11-14 12:05, Wei Yongjun wrote:
> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> x25_lapb_receive_frame() using skb_copy() to get a private copy of
> skb, the new skb should be freed in the undersized/fragmented skb
> error handling path. Otherwise there is a memory leak.
> 
> Fixes: cb101ed2c3c7 ("x25: Handle undersized/fragmented skbs")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  net/x25/x25_dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/x25/x25_dev.c b/net/x25/x25_dev.c
> index 5259ef8f5242..748d8630ab58 100644
> --- a/net/x25/x25_dev.c
> +++ b/net/x25/x25_dev.c
> @@ -117,7 +117,7 @@ int x25_lapb_receive_frame(struct sk_buff *skb,
> struct net_device *dev,
> 
>  	if (!pskb_may_pull(skb, 1)) {
>  		x25_neigh_put(nb);
> -		return 0;
> +		goto drop;
>  	}
> 
>  	switch (skb->data[0]) {

Looks good to me.

Thanks.

Acked-by: Martin Schiller <ms@dev.tdt.de>
