From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] drivers/net/wan: lapb: Corrected the usage of skb_cow
Date: Fri, 24 Jul 2020 20:17:59 -0700 (PDT)
Message-ID: <20200724.201759.487082545769759347.davem@davemloft.net>
References: <20200724163347.57213-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200724163347.57213-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, edumazet@google.com, ms@dev.tdt.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

From: Xie He <xie.he.0141@gmail.com>
Date: Fri, 24 Jul 2020 09:33:47 -0700

> This patch fixed 2 issues with the usage of skb_cow in LAPB drivers
> "lapbether" and "hdlc_x25":
> 
> 1) After skb_cow fails, kfree_skb should be called to drop a reference
> to the skb. But in both drivers, kfree_skb is not called.
> 
> 2) skb_cow should be called before skb_push so that is can ensure the
> safety of skb_push. But in "lapbether", it is incorrectly called after
> skb_push.
> 
> More details about these 2 issues:
> 
> 1) The behavior of calling kfree_skb on failure is also the behavior of
> netif_rx, which is called by this function with "return netif_rx(skb);".
> So this function should follow this behavior, too.
> 
> 2) In "lapbether", skb_cow is called after skb_push. This results in 2
> logical issues:
>    a) skb_push is not protected by skb_cow;
>    b) An extra headroom of 1 byte is ensured after skb_push. This extra
>       headroom has no use in this function. It also has no use in the
>       upper-layer function that this function passes the skb to
>       (x25_lapb_receive_frame in net/x25/x25_dev.c).
> So logically skb_cow should instead be called before skb_push.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thank you.
