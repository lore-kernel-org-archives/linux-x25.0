From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net v2] drivers/net/wan/lapbether: Added needed_tailroom
Date: Mon, 24 Aug 2020 16:09:49 -0700 (PDT)
Message-ID: <20200824.160949.2284526241463900498.davem@davemloft.net>
References: <20200821212659.14551-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200821212659.14551-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, willemdebruijn.kernel@gmail.com, ms@dev.tdt.de

From: Xie He <xie.he.0141@gmail.com>
Date: Fri, 21 Aug 2020 14:26:59 -0700

> The underlying Ethernet device may request necessary tailroom to be
> allocated by setting needed_tailroom. This driver should also set
> needed_tailroom to request the tailroom needed by the underlying
> Ethernet device to be allocated.
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thank you.
