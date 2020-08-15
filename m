From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/hdlc_x25: Added needed_headroom and a
 skb->len check
Date: Fri, 14 Aug 2020 22:21:43 -0700
Message-ID: <CAJht_EP_DKC=WXATeO8YKcRas5UW2xLYRx5Qn=pL8A1PZW=E7Q@mail.gmail.com>
References: <20200813181704.62694-1-xie.he.0141@gmail.com> <20200814.204121.2301287009173291675.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6kl9CRsSuMe4k5oZIw9J5TSUS7ssSZkQEzpcLwtOTwA=;
        b=CZUM7UYuw66dEqtL20gVt538tXU2Mcd3v6gBlDG/sqMfeSQonIv/W7kw3D/EHvRDUW
         e37kICOlAtjhdL/k9lqxN9g+TLhDdAsboP+30w5RG8jGhgisW5e9cyJ8+L9yUHBls/Tq
         WMXnOJrZhKmwtWDmcJvZiorWK9uktdLLkPiriSn+ecf5YJ+6jX1kyjE+fBvVwbrBosM9
         oosh7oZJvPHbvGpSQ4OmwRjSeJyQY/q1D3SGVmzJiXAZv2N3Q7DcQyRVDtR2I34U4M/n
         SOkJD9xAzonFoJ4cgZI+Z2EE6egxkHFhYJBvSD7qQ8K4HYRG81jjGZa+96AWY4BhJfG8
         o8fA==
In-Reply-To: <20200814.204121.2301287009173291675.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin Schiller <ms@dev.tdt.de>, Andrew Hendry <andrew.hendry@gmail.com>

On Fri, Aug 14, 2020 at 8:41 PM David Miller <davem@davemloft.net> wrote:
>
> Applied, thanks.

Thank you, David!
