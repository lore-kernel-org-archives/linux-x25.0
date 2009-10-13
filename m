From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] x25: bit and/or confusion in x25_ioctl()?
Date: Tue, 13 Oct 2009 03:47:24 -0700 (PDT)
Message-ID: <20091013.034724.44299172.davem@davemloft.net>
References: <4ACC749E.4060806@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <4ACC749E.4060806@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: roel.kluin@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, akpm@linux-foundation.org

From: Roel Kluin <roel.kluin@gmail.com>
Date: Wed, 07 Oct 2009 12:59:42 +0200

> Looking at commit ebc3f64b864f it appears that this was intended
> and not the original, equivalent to `if (facilities.reverse & ~0x81)'.
> 
> In x25_parse_facilities() that patch changed how facilities->reverse
> was set. No other bits were set than 0x80 and/or 0x01.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>

Looks good to me, applied to net-next-2.6
