From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Tue, 28 Jul 2020 12:52:46 -0700
Message-ID: <20200728195246.GA482576@google.com>
References: <20200726110524.151957-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lw5Yo6LYMJj0wtDoaefLNGkgc5QTYl1SaK6AazO3v2w=;
        b=gq6HFa7X7QMj2DalmEMErYJdwibaHGKntgGODdJmOjnvl71XNlf89WdFly/p/8zUsD
         adf6UQmHbEE2XxscjVPyDBuPLHifM78QvAfOfX0iBq+iwH0lfV4yGvEBEVtksCgn6YyM
         K7ENcyD3xpKYwQsxBe6eWsKzfX5e3ZKuSjRas=
Content-Disposition: inline
In-Reply-To: <20200726110524.151957-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, Cong Wang <xiyou.wangcong@gmail.com>

(Reviewing as requested; I'm not familiar with this driver either, or
really any WAN driver. It also seems that hard_header_len vs.
needed_headroom aren't very well documented, and even I can't guarantee
I understand them completely. So take my thoughts with a grain of salt.)

Hi,

On Sun, Jul 26, 2020 at 04:05:24AM -0700, Xie He wrote:
> In net/packet/af_packet.c, the function packet_snd first reserves a
> headroom of length (dev->hard_header_len + dev->needed_headroom).
> Then if the socket is a SOCK_DGRAM socket, it calls dev_hard_header,
> which calls dev->header_ops->create, to create the link layer header.
> If the socket is a SOCK_RAW socket, it "un-reserves" a headroom of
> length (dev->hard_header_len), and assumes the user to provide the
> appropriate link layer header.
> 
> So according to the logic of af_packet.c, dev->hard_header_len should
> be the length of the header that would be created by
> dev->header_ops->create.

I believe I'm with you up to here, but:

> However, this driver doesn't provide dev->header_ops, so logically
> dev->hard_header_len should be 0.

I'm not clear on this part.

What's to say you shouldn't be implementing header_ops instead? Note
that with WiFi drivers, they're exposing themselves as ARPHRD_ETHER, and
only the Ethernet headers are part of the upper "protocol" headers. So
my patch deferred to the eth headers.

What is the intention with this X25 protocol? I guess the headers added
in lapbeth_data_transmit() are supposed to be "invisible", as with this
note in af_packet.c?

   - if device has no dev->hard_header routine, it adds and removes ll header
     inside itself. In this case ll header is invisible outside of device,
     but higher levels still should reserve dev->hard_header_len.

If that's the case, then yes, I believe this patch should be correct.

Brian

> So we should use dev->needed_headroom instead of dev->hard_header_len
> to request necessary headroom to be allocated.
> 
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
