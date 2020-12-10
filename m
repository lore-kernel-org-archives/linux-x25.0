From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: x25: Fix handling of Restart Request and
 Restart Confirmation
Date: Wed, 09 Dec 2020 19:35:06 -0800 (PST)
Message-ID: <20201209.193506.2090158352867619865.davem@davemloft.net>
References: <20201209081604.464084-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201209081604.464084-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de

From: Xie He <xie.he.0141@gmail.com>
Date: Wed,  9 Dec 2020 00:16:04 -0800

> 1. When the x25 module gets loaded, layer 2 may already be running and
> connected. In this case, although we are in X25_LINK_STATE_0, we still
> need to handle the Restart Request received, rather than ignore it.
> 
> 2. When we are in X25_LINK_STATE_2, we have already sent a Restart Request
> and is waiting for the Restart Confirmation with t20timer. t20timer will
> restart itself repeatedly forever so it will always be there, as long as we
> are in State 2. So we don't need to check x25_t20timer_pending again.
> 
> Fixes: d023b2b9ccc2 ("net/x25: fix restart request/confirm handling")
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thanks.
