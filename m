From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next] net: x25: drop harmless check of !more
Date: Wed, 08 Dec 2021 08:51:17 +0100
Message-ID: <591bfc0470ca596995e13337460f99d0@dev.tdt.de>
References: <20211208024732.142541-5-sakiwit@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20211208024732.142541-5-sakiwit@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: =?UTF-8?Q?J=CE=B5an_Sacren?= <sakiwit@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org

On 2021-12-08 08:20, J=CE=B5an Sacren wrote:
> From: Jean Sacren <sakiwit@gmail.com>
>=20
> 'more' is checked first.  When !more is checked immediately after that,
> it is always true.  We should drop this check.
>=20
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
>  net/x25/x25_in.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/x25/x25_in.c b/net/x25/x25_in.c
> index e1c4197af468..b981a4828d08 100644
> --- a/net/x25/x25_in.c
> +++ b/net/x25/x25_in.c
> @@ -41,7 +41,7 @@ static int x25_queue_rx_frame(struct sock *sk,
> struct sk_buff *skb, int more)
>  		return 0;
>  	}
>=20
> -	if (!more && x25->fraglen > 0) {	/* End of fragment */
> +	if (x25->fraglen > 0) {	/* End of fragment */
>  		int len =3D x25->fraglen + skb->len;
>=20
>  		if ((skbn =3D alloc_skb(len, GFP_ATOMIC)) =3D=3D NULL){

Acked-by: Martin Schiller <ms@dev.tdt.de>
