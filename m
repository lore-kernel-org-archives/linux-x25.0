From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net/x25: prevent a couple of overflows
Date: Tue, 01 Dec 2020 07:50:34 +0100
Message-ID: <ecf3321f20cc4f6dcf02b5b73105da58@dev.tdt.de>
References: <20201130100425.GB2789@kadam>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201130100425.GB2789@kadam>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"; format="flowed"
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, =?UTF-8?Q?kiyin=28=E5=B0=B9?= =?UTF-8?Q?=E4=BA=AE=29?= <kiyin@tencent.com>, security@kernel.org, linux-distros@vs.openwall.org, =?UTF-8?Q?huntchen=28=E9=99=88=E9=98=B3?= =?UTF-8?Q?=29?= <huntchen@tencent.com>, =?UTF-8?Q?dannywang=28?= =?UTF-8?Q?=E7=8E=8B=E5=AE=87=29?= <dannywang@tencent.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org

On 2020-11-30 11:04, Dan Carpenter wrote:
> From: "kiyin(尹亮)" <kiyin@tencent.com>
> 
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
> The x25 protocol only allows 15 character addresses so putting a NUL
> terminator as the 16th character is safe and obviously preferable to
> reading out of bounds.
> 

OK, I see the potential danger. I'm just wondering what is the better
approach here to counteract it:
1. check if the string is terminated or exceeds the maximum allowed
    length and report an error if necessary.
2. always terminate the string at byte 15 as you suggested.

> Signed-off-by: "kiyin(尹亮)" <kiyin@tencent.com>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> 
>  net/x25/af_x25.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index 0bbb283f23c9..3180f15942fe 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -686,6 +686,8 @@ static int x25_bind(struct socket *sock, struct
> sockaddr *uaddr, int addr_len)
>  		goto out;
>  	}
> 
> +	addr->sx25_addr.x25_addr[X25_ADDR_LEN - 1] = '\0';
> +
>  	/* check for the null_x25_address */
>  	if (strcmp(addr->sx25_addr.x25_addr, null_x25_address.x25_addr)) {
> 
> @@ -779,6 +781,7 @@ static int x25_connect(struct socket *sock, struct
> sockaddr *uaddr,
>  		goto out;
> 
>  	rc = -ENETUNREACH;
> +	addr->sx25_addr.x25_addr[X25_ADDR_LEN - 1] = '\0';
>  	rt = x25_get_route(&addr->sx25_addr);
>  	if (!rt)
>  		goto out;
