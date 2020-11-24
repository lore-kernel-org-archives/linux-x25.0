From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH net-next v5 3/5] net/lapb: fix t1 timer handling for
 LAPB_STATE_0
Date: Tue, 24 Nov 2020 11:43:02 +0000
Message-ID: <2d40b42aee314611b9ba1627e5eab30b@AcuMS.aculab.com>
References: <20201124093538.21177-1-ms@dev.tdt.de>
 <20201124093538.21177-4-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201124093538.21177-4-ms@dev.tdt.de>
Content-Language: en-US
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Martin Schiller' <ms@dev.tdt.de>, "andrew.hendry@gmail.com" <andrew.hendry@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, "xie.he.0141@gmail.com" <xie.he.0141@gmail.com>
Cc: "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Martin Schiller
> Sent: 24 November 2020 09:36
> 
> 1. DTE interface changes immediately to LAPB_STATE_1 and start sending
>    SABM(E).
> 
> 2. DCE interface sends N2-times DM and changes to LAPB_STATE_1
>    afterwards if there is no response in the meantime.

Seems reasonable.
It is 35 years since I wrote LAPB and I can't exactly remember
what we did.
If I stole a copy of the code it's on a QIC-150 tape cartridge!

I really don't remember having a DTE/DCE option.
It is likely that LAPB came up sending DM (response without F)
until level3 requested the link come up when it would send
N2 SABM+P hoping to get a UA+F.
It would then send DM-F until a retry request was made.

We certainly had several different types of crossover connectors
for DTE-DTE working.

	David

> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> ---
>  net/lapb/lapb_timer.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/net/lapb/lapb_timer.c b/net/lapb/lapb_timer.c
> index 8f5b17001a07..baa247fe4ed0 100644
> --- a/net/lapb/lapb_timer.c
> +++ b/net/lapb/lapb_timer.c
> @@ -85,11 +85,18 @@ static void lapb_t1timer_expiry(struct timer_list *t)
>  	switch (lapb->state) {
> 
>  		/*
> -		 *	If we are a DCE, keep going DM .. DM .. DM
> +		 *	If we are a DCE, send DM up to N2 times, then switch to
> +		 *	STATE_1 and send SABM(E).
>  		 */
>  		case LAPB_STATE_0:
> -			if (lapb->mode & LAPB_DCE)
> +			if (lapb->mode & LAPB_DCE &&
> +			    lapb->n2count != lapb->n2) {
> +				lapb->n2count++;
>  				lapb_send_control(lapb, LAPB_DM, LAPB_POLLOFF, LAPB_RESPONSE);
> +			} else {
> +				lapb->state = LAPB_STATE_1;
> +				lapb_establish_data_link(lapb);
> +			}
>  			break;
> 
>  		/*
> --
> 2.20.1

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

