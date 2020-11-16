From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH net-next v2 2/6] net/x25: make neighbour params
 configurable
Date: Mon, 16 Nov 2020 17:05:22 +0000
Message-ID: <5d4faa10de734ba0af7a471b0eadd782@AcuMS.aculab.com>
References: <20201116135522.21791-1-ms@dev.tdt.de>
 <20201116135522.21791-3-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201116135522.21791-3-ms@dev.tdt.de>
Content-Language: en-US
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Martin Schiller' <ms@dev.tdt.de>, "andrew.hendry@gmail.com" <andrew.hendry@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>, "xie.he.0141@gmail.com" <xie.he.0141@gmail.com>
Cc: "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

From: Martin Schiller
> Sent: 16 November 2020 13:55
> Extended struct x25_neigh and x25_subscrip_struct to configure following
> params through SIOCX25SSUBSCRIP:
>   o mode (DTE/DCE)
>   o number of channels
>   o facilities (packet size, window size)
>   o timer T20
> 
> Based on this configuration options the following changes/extensions
> where made:
>   o DTE/DCE handling to select the next lc (DCE=from bottom / DTE=from
>     top)
>   o DTE/DCE handling to set correct clear/reset/restart cause
>   o take default facilities from neighbour settings
> 
...
> +/*
> + *	DTE/DCE subscription options.
> + *
> + *      As this is missing lots of options, user should expect major
> + *	changes of this structure in 2.5.x which might break compatibility.

A little out of date!

> + *      The somewhat ugly dimension 200-sizeof() is needed to maintain
> + *	backward compatibility.
> + */
> +struct x25_subscrip_struct {
> +	char device[200 - ((2 * sizeof(unsigned long)) +
> +		    sizeof(struct x25_facilities) +
> +		    (2 * sizeof(unsigned int)))];
> +	unsigned int		dce;
> +	unsigned int		lc;
> +	struct x25_facilities	facilities;
> +	unsigned long		t20;
> +	unsigned long		global_facil_mask;	/* 0 to disable negotiation */
> +	unsigned int		extended;
> +};

Would it be better to used fixed size integer types to avoid
'compat_32' issues?

It might even be worth adding padding after the existing
32bit layout to align any additional fields at the same offset
in both 64bit and 32bit systems.

I was also wondering if you can use an anonymous structure
member for the actual fields and then use 200 - sizeof (struct foo)
for the pad?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

