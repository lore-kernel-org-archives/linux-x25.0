From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v4] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Thu, 01 Apr 2021 12:06:38 +0200
Message-ID: <21ec9eafa230f2e20dd88d31fd95faa0@dev.tdt.de>
References: <20210328221205.726511-1-xie.he.0141@gmail.com>
 <CAJht_EMVAV1eyredF+VEF=hxTTMVRMx+89XdpVAWpD5Lq1Y9Tw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <CAJht_EMVAV1eyredF+VEF=hxTTMVRMx+89XdpVAWpD5Lq1Y9Tw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Halasa <khc@pm.waw.pl>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On 2021-03-31 20:41, Xie He wrote:
> Hi Martin,
> 
> Could you ack this patch again? The only change from the RFC version
> (that you previously acked) is the addition of the "__GFP_NOMEMALLOC"
> flag in "dev_alloc_skb". This is because I want to prevent pfmemalloc
> skbs (which can't be handled by netif_receive_skb_core) from
> occurring.
> 
> Thanks!

Hi!

Sorry for my late answer.
Can you please also fix this line length warning?
https://patchwork.hopto.org/static/nipa/442445/12117801/checkpatch/stdout

- Martin
