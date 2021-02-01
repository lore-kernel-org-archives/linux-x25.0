From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: Re: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Mon, 1 Feb 2021 15:10:45 +0100
Message-ID: <4d1988d9-6439-ae37-697c-d2b970450498@linux.ibm.com>
References: <20210201055706.415842-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=kFfdiVRSosOPGBsI44S5SiAq787FhllDr5Y5F5u5cYQ=;
 b=cs8rpuv8dySai1YarWb142wHJt556SoyMPcuFzcwp/hyMhhz9qnOko+MBSlIlr4LGGBx
 qdh79pg3YjpLZv3J76TZF/TOkFBKnJK+yUWPkJ5DsaiaL+aUwPTrHb38b4LPazQrKvwB
 GascykC2BjdBQuHzxWOfyV3o54rGpoEx3fXR7x6YV8XT/TZUQGmi7MU0yN0JsYWF66oJ
 U67TsnkaZV5ced82dUM2xDXPz30M/FnOi9iQuTuaBA2KZGCsKPbWbVCSq5N7ut2V7o3k
 sD4oKDZ5P/dNvk+vGhWRYQPj2USdEq6nqcNdHe+q6RlXUdfKToIUm6w74LlTLyEr3r6J NA== 
In-Reply-To: <20210201055706.415842-1-xie.he.0141@gmail.com>
Content-Language: en-US
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

On 01.02.21 06:57, Xie He wrote:
> When sending a packet, we will prepend it with an LAPB header.
> This modifies the shared parts of a cloned skb, so we should copy the
> skb rather than just clone it, before we prepend the header.
> 
> In "Documentation/networking/driver.rst" (the 2nd point), it states
> that drivers shouldn't modify the shared parts of a cloned skb when
> transmitting.
> 

This sounds a bit like you want skb_cow_head() ... ?

> The "dev_queue_xmit_nit" function in "net/core/dev.c", which is called
> when an skb is being sent, clones the skb and sents the clone to
> AF_PACKET sockets. Because the LAPB drivers first remove a 1-byte
> pseudo-header before handing over the skb to us, if we don't copy the
> skb before prepending the LAPB header, the first byte of the packets
> received on AF_PACKET sockets can be corrupted.
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
> 

