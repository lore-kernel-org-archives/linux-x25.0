From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Mon, 01 Feb 2021 11:05:16 +0100
Message-ID: <204c18e95caf2ae84fb567dd4be0c3ac@dev.tdt.de>
References: <20210201055706.415842-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20210201055706.415842-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2021-02-01 06:57, Xie He wrote:
> When sending a packet, we will prepend it with an LAPB header.
> This modifies the shared parts of a cloned skb, so we should copy the
> skb rather than just clone it, before we prepend the header.
> 
> In "Documentation/networking/driver.rst" (the 2nd point), it states
> that drivers shouldn't modify the shared parts of a cloned skb when
> transmitting.
> 
> The "dev_queue_xmit_nit" function in "net/core/dev.c", which is called
> when an skb is being sent, clones the skb and sents the clone to
> AF_PACKET sockets. Because the LAPB drivers first remove a 1-byte
> pseudo-header before handing over the skb to us, if we don't copy the
> skb before prepending the LAPB header, the first byte of the packets
> received on AF_PACKET sockets can be corrupted.

What kind of packages do you mean are corrupted?
ETH_P_X25 or ETH_P_HDLC?

I have also sent a patch here in the past that addressed corrupted
ETH_P_X25 frames on an AF_PACKET socket:

https://lkml.org/lkml/2020/1/13/388

Unfortunately I could not track and describe exactly where the problem
was.

I just wonder when/where is the logically correct place to copy the skb.
Shouldn't it be copied before removing the pseudo header (as I did in my
patch)?

> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  net/lapb/lapb_out.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/lapb/lapb_out.c b/net/lapb/lapb_out.c
> index 7a4d0715d1c3..a966d29c772d 100644
> --- a/net/lapb/lapb_out.c
> +++ b/net/lapb/lapb_out.c
> @@ -82,7 +82,8 @@ void lapb_kick(struct lapb_cb *lapb)
>  		skb = skb_dequeue(&lapb->write_queue);
> 
>  		do {
> -			if ((skbn = skb_clone(skb, GFP_ATOMIC)) == NULL) {
> +			skbn = skb_copy(skb, GFP_ATOMIC);
> +			if (!skbn) {
>  				skb_queue_head(&lapb->write_queue, skb);
>  				break;
>  			}
