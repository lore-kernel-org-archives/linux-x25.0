From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/x25: Fix null-ptr-deref in x25_connect
Date: Mon, 28 Sep 2020 18:43:26 -0700 (PDT)
Message-ID: <20200928.184326.1754311969939569006.davem@davemloft.net>
References: <20200928092327.329-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200928092327.329-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: andrew.hendry@gmail.com, kuba@kernel.org, edumazet@google.com, xiyuyang19@fudan.edu.cn, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Mon, 28 Sep 2020 11:23:27 +0200

> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index 0bbb283f23c9..0524a5530b91 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -820,7 +820,7 @@ static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
>  
>  	rc = x25_wait_for_connection_establishment(sk);
>  	if (rc)
> -		goto out_put_neigh;
> +		goto out;

If x25_wait_for_connection_establishment() returns because of an interrupting
signal, we are not going to call x25_disconnect().

The case you are fixing only applies _sometimes_ when
x25_wait_for_connection_establishment() returns.  But not always.

That neighbour has to be released at this spot otherwise.
