From: Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH] net/x25: Fix x25_neigh refcnt leak when reveiving frame
Date: Thu, 23 Apr 2020 15:14:18 +0800
Message-ID: <a5cfb5ee-cd8b-b694-3d83-cd4fe08429c7@huawei.com>
References: <1587618786-13481-1-git-send-email-xiyuyang19@fudan.edu.cn>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1587618786-13481-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>, Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>, Allison Randal <allison@lohutok.net>, Thomas Gleixner <tglx@linutronix.de>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>

On 2020/4/23 13:13, Xiyu Yang wrote:
> x25_lapb_receive_frame() invokes x25_get_neigh(), which returns a
> reference of the specified x25_neigh object to "nb" with increased
> refcnt.
> 
> When x25_lapb_receive_frame() returns, local variable "nb" becomes
> invalid, so the refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in one path of
> x25_lapb_receive_frame(). When pskb_may_pull() returns false, the
> function forgets to decrease the refcnt increased by x25_get_neigh(),
> causing a refcnt leak.
> 
> Fix this issue by calling x25_neigh_put() when pskb_may_pull() returns
> false.
> 

Fixes: cb101ed2c3c7 ("x25: Handle undersized/fragmented skbs")

> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  net/x25/x25_dev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/x25/x25_dev.c b/net/x25/x25_dev.c
> index 00e782335cb0..25bf72ee6cad 100644
> --- a/net/x25/x25_dev.c
> +++ b/net/x25/x25_dev.c
> @@ -115,8 +115,10 @@ int x25_lapb_receive_frame(struct sk_buff *skb, struct net_device *dev,
>  		goto drop;
>  	}
>  
> -	if (!pskb_may_pull(skb, 1))
> +	if (!pskb_may_pull(skb, 1)) {
> +		x25_neigh_put(nb);
>  		return 0;
> +	}
>  
>  	switch (skb->data[0]) {
>  
> 

