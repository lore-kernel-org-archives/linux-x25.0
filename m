From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next] MAINTAINERS: Add Martin Schiller as a maintainer
 for the X.25 stack
Date: Mon, 16 Nov 2020 10:01:20 +0100
Message-ID: <3a556cae7d869059fa3b30c921a91658@dev.tdt.de>
References: <20201114111029.326972-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20201114111029.326972-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Hendry <andrew.hendry@gmail.com>

On 2020-11-14 12:10, Xie He wrote:
> Martin Schiller is an active developer and reviewer for the X.25 code.
> His company is providing products based on the Linux X.25 stack.
> So he is a good candidate for maintainers of the X.25 code.
> 
> The original maintainer of the X.25 network layer (Andrew Hendry) has
> not sent any email to the netdev mail list since 2013. So he is 
> probably
> inactive now.
> 
> Cc: Martin Schiller <ms@dev.tdt.de>
> Cc: Andrew Hendry <andrew.hendry@gmail.com>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  MAINTAINERS | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index af9f6a3ab100..ab8b2c9ad00e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9842,13 +9842,6 @@ S:	Maintained
>  F:	arch/mips/lantiq
>  F:	drivers/soc/lantiq
> 
> -LAPB module
> -L:	linux-x25@vger.kernel.org
> -S:	Orphan
> -F:	Documentation/networking/lapb-module.rst
> -F:	include/*/lapb.h
> -F:	net/lapb/
> -
>  LASI 53c700 driver for PARISC
>  M:	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>  L:	linux-scsi@vger.kernel.org
> @@ -18986,12 +18979,18 @@ L:	linux-kernel@vger.kernel.org
>  S:	Maintained
>  N:	axp[128]
> 
> -X.25 NETWORK LAYER
> -M:	Andrew Hendry <andrew.hendry@gmail.com>
> +X.25 STACK
> +M:	Martin Schiller <ms@dev.tdt.de>
>  L:	linux-x25@vger.kernel.org
> -S:	Odd Fixes
> +S:	Maintained
> +F:	Documentation/networking/lapb-module.rst
>  F:	Documentation/networking/x25*
> +F:	drivers/net/wan/hdlc_x25.c
> +F:	drivers/net/wan/lapbether.c
> +F:	include/*/lapb.h
>  F:	include/net/x25*
> +F:	include/uapi/linux/x25.h
> +F:	net/lapb/
>  F:	net/x25/
> 
>  X86 ARCHITECTURE (32-BIT AND 64-BIT)

Acked-by: Martin Schiller <ms@dev.tdt.de>
