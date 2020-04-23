From: Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH 1/2] net/x25: Fix x25_neigh refcnt leak when x25_connect()
 fails
Date: Thu, 23 Apr 2020 14:36:51 +0800
Message-ID: <8636fc9a-001a-9d48-087b-7f243527cd99@huawei.com>
References: <1587618822-13544-1-git-send-email-xiyuyang19@fudan.edu.cn>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1587618822-13544-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xiyu Yang <xiyuyang19@fudan.edu.cn>, Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Martin Schiller <ms@dev.tdt.de>, Eric Dumazet <edumazet@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: yuanxzhang@fudan.edu.cn, kjlu@umn.edu, Xin Tan <tanxin.ctf@gmail.com>

On 2020/4/23 13:13, Xiyu Yang wrote:
> x25_connect() invokes x25_get_neigh(), which returns a reference of the
> specified x25_neigh object to "x25->neighbour" with increased refcnt.
> 
> When x25_connect() returns, local variable "x25" and "x25->neighbour"
> become invalid, so the refcount should be decreased to keep refcount
> balanced.
> 
> The reference counting issue happens in one exception handling path of
> x25_connect(). When sock state is not TCP_ESTABLISHED and its flags
> include O_NONBLOCK, the function forgets to decrease the refcnt
> increased by x25_get_neigh(), causing a refcnt leak.
> 
> Fix this issue by jumping to "out_put_neigh" label when x25_connect()
> fails.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>
> ---
>  net/x25/af_x25.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index d5b09bbff375..e6571c56209b 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -816,7 +816,7 @@ static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
>  	/* Now the loop */
>  	rc = -EINPROGRESS;
>  	if (sk->sk_state != TCP_ESTABLISHED && (flags & O_NONBLOCK))
> -		goto out;
> +		goto out_put_neigh;

This seems not right, see

commit e21dba7a4df4 ("net/x25: fix nonblocking connect")

>  
>  	rc = x25_wait_for_connection_establishment(sk);
>  	if (rc)
> 

