From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net-next] lapb: moved export of lapb_register.
Date: Sun, 16 Jun 2019 14:25:16 -0700 (PDT)
Message-ID: <20190616.142516.1232002000997040524.davem@davemloft.net>
References: <20190616104159.20268-1-jeremy@azazel.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190616104159.20268-1-jeremy@azazel.net>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: jeremy@azazel.net
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>
Date: Sun, 16 Jun 2019 11:41:59 +0100

> The EXPORT_SYMBOL for lapb_register was next to a different function.
> Moved it to the right place.
> 
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Applied, thanks.
