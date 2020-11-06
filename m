From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH v2] net/x25: Fix null-ptr-deref in x25_connect
Date: Fri, 06 Nov 2020 07:23:05 +0100
Message-ID: <9751fc51170c9bf776e03d079a3e92e3@dev.tdt.de>
References: <20201006054558.19453-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201006054558.19453-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, edumazet@google.com, xiyuyang19@fudan.edu.cn
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-10-06 07:45, Martin Schiller wrote:
> This fixes a regression for blocking connects introduced by commit
> 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 
> disconnect").
> 
> The x25->neighbour is already set to "NULL" by x25_disconnect() now,
> while a blocking connect is waiting in
> x25_wait_for_connection_establishment(). Therefore x25->neighbour must
> not be accessed here again and x25->state is also already set to
> X25_STATE_0 by x25_disconnect().
> 
> Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 
> disconnect")
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
> 
> Change from v1:
> also handle interrupting signals correctly
> 
> ---
>  net/x25/af_x25.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index 0bbb283f23c9..046d3fee66a9 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -825,7 +825,7 @@ static int x25_connect(struct socket *sock, struct
> sockaddr *uaddr,
>  	sock->state = SS_CONNECTED;
>  	rc = 0;
>  out_put_neigh:
> -	if (rc) {
> +	if (rc && x25->neighbour) {
>  		read_lock_bh(&x25_list_lock);
>  		x25_neigh_put(x25->neighbour);
>  		x25->neighbour = NULL;

@David
Is there anything left I need to do, to get this fix merged?

