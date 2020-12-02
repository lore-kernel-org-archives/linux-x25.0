From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net v2] net/x25: prevent a couple of overflows
Date: Wed, 02 Dec 2020 10:27:18 +0100
Message-ID: <41de2a35016a1eb9a188a71d11709f16@dev.tdt.de>
References: <X8ZeAKm8FnFpN//B@mwanda>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <X8ZeAKm8FnFpN//B@mwanda>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, Andrew Hendry <andrew.hendry@gmail.com>, =?UTF-8?Q?kiyin=28=E5=B0=B9=E4=BA=AE?= =?UTF-8?Q?=29?= <kiyin@tencent.com>, security@kernel.org, linux-distros@vs.openwall.org, =?UTF-8?Q?huntchen=28=E9=99=88=E9=98=B3?= =?UTF-8?Q?=29?= <huntchen@tencent.com>, =?UTF-8?Q?dannywang=28?= =?UTF-8?Q?=E7=8E=8B=E5=AE=87=29?= <dannywang@tencent.com>, kernel-janitors@vger.kernel.org

On 2020-12-01 16:15, Dan Carpenter wrote:
> The .x25_addr[] address comes from the user and is not necessarily
> NUL terminated.  This leads to a couple problems.  The first problem is
> that the strlen() in x25_bind() can read beyond the end of the buffer.
> 
> The second problem is more subtle and could result in memory 
> corruption.
> The call tree is:
>   x25_connect()
>   --> x25_write_internal()
>       --> x25_addr_aton()
> 
> The .x25_addr[] buffers are copied to the "addresses" buffer from
> x25_write_internal() so it will lead to stack corruption.
> 
> Verify that the strings are NUL terminated and return -EINVAL if they
> are not.
> 
> Reported-by: "kiyin(尹亮)" <kiyin@tencent.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> The first patch put a NUL terminator on the end of the string and this
> patch returns an error instead.  I don't have a strong preference, 
> which
> patch to go with.
> 
>  net/x25/af_x25.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index 9232cdb42ad9..d41fffb2507b 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -675,7 +675,8 @@ static int x25_bind(struct socket *sock, struct
> sockaddr *uaddr, int addr_len)
>  	int len, i, rc = 0;
> 
>  	if (addr_len != sizeof(struct sockaddr_x25) ||
> -	    addr->sx25_family != AF_X25) {
> +	    addr->sx25_family != AF_X25 ||
> +	    strnlen(addr->sx25_addr.x25_addr, X25_ADDR_LEN) == X25_ADDR_LEN) 
> {
>  		rc = -EINVAL;
>  		goto out;
>  	}
> @@ -769,7 +770,8 @@ static int x25_connect(struct socket *sock, struct
> sockaddr *uaddr,
> 
>  	rc = -EINVAL;
>  	if (addr_len != sizeof(struct sockaddr_x25) ||
> -	    addr->sx25_family != AF_X25)
> +	    addr->sx25_family != AF_X25 ||
> +	    strnlen(addr->sx25_addr.x25_addr, X25_ADDR_LEN) == X25_ADDR_LEN)
>  		goto out;
> 
>  	rc = -ENETUNREACH;

Acked-by: Martin Schiller <ms@dev.tdt.de>
