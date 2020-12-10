From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] net: lapbether: Consider it successful if
 (dis)connecting when already (dis)connected
Date: Thu, 10 Dec 2020 13:19:23 -0800 (PST)
Message-ID: <20201210.131923.261956317613003321.davem@davemloft.net>
References: <20201208225044.5522-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201208225044.5522-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ms@dev.tdt.de

From: Xie He <xie.he.0141@gmail.com>
Date: Tue,  8 Dec 2020 14:50:44 -0800

> When the upper layer instruct us to connect (or disconnect), but we have
> already connected (or disconnected), consider this operation successful
> rather than failed.
> 
> This can help the upper layer to correct its record about whether we are
> connected or not here in layer 2.
> 
> The upper layer may not have the correct information about whether we are
> connected or not. This can happen if this driver has already been running
> for some time when the "x25" module gets loaded.
> 
> Another X.25 driver (hdlc_x25) is already doing this, so we make this
> driver do this, too.
> 
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thank you.
