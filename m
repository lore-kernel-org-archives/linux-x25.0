From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a
 skb->len check
Date: Sun, 9 Aug 2020 11:12:33 +0200
Message-ID: <CA+FuTSe-FaQFn4WNvVPJ1v+jVZAghgd1AZc-cWn2+GjPR4GzVQ@mail.gmail.com>
References: <20200809023548.684217-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+74zSb8Mdp9nDMJHIbR9g9Xvn68Ir31r0eIPx9VKJQ=;
        b=uCfT5JrYlSPG0FEa68vEPgOHLYMvfbUL6H6bDMPguXZp/Qlh6YGNBBSj7uXfYtckc3
         cCO8ZypmSwK+tFs6jZQZ8bV5QoFG6dMLcGwBbYmTjQcJwhzbAZy1FuTLz8rCe1U3HJeC
         zKvA5bxJpLgNBw3IKo6tBM7xvaAiyNa4gqbUktEbvi/BpJLo4OBC3d6nFRRMLvo0jYFV
         mPIozp32zeE+OPwRs8ihRtN221ms6sh5PQG6jmDjxMWrjY1xXxJxA5cEv4MHobpF6mWm
         6+gT3Jq0cUI/PRGxlQM9zzh+6uviWzHh/PFTNjQmhz9Z6vZaU+wg6EVnCUNC5JBQVOpM
         bM2Q==
In-Reply-To: <20200809023548.684217-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin Schiller <ms@dev.tdt.de>

On Sun, Aug 9, 2020 at 4:36 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> 1. Added a skb->len check
>
> This driver expects upper layers to include a pseudo header of 1 byte
> when passing down a skb for transmission. This driver will read this
> 1-byte header. This patch added a skb->len check before reading the
> header to make sure the header exists.
>
> 2. Added needed_headroom
>
> When this driver transmits data,
>   first this driver will remove a pseudo header of 1 byte,
>   then the lapb module will prepend the LAPB header of 2 or 3 bytes.
> So the value of needed_headroom in this driver should be 3 - 1.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

The patch is analogous to commit c7ca03c216ac
("drivers/net/wan/lapbether: Added needed_headroom and a skb->len
check").

Seems to make sense based on call stack

  x25_asy_xmit               // skb_pull(skb, 1)
  lapb_data_request
  lapb_kick
  lapb_send_iframe        // skb_push(skb, 2)
  lapb_transmit_buffer    // skb_push(skb, 1)
  lapb_data_transmit
  x25_asy_data_transmit
  x25_asy_encaps

But I frankly don't know this code and would not modify logic that no
one has complained about for many years without evidence of a real
bug.

Were you able to actually exercise this path, similar to lapb_ether:
configure the device, send data from a packet socket? If so, can you
share the configuration steps?
