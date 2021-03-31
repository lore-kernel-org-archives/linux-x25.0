From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Wed, 31 Mar 2021 11:41:32 -0700
Message-ID: <CAJht_EMVAV1eyredF+VEF=hxTTMVRMx+89XdpVAWpD5Lq1Y9Tw@mail.gmail.com>
References: <20210328221205.726511-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=miQIpXzzSlxlo4KCoDggGOO7tlc2KNpZkFxFMVFV92M=;
        b=BBVci2aDzZp0k3vai2pZSBeQB7mvcYj+yO++e/R3MT2nyxhBztOzV/jUK8nLSol0Ve
         n5jdWA8m98lu6ym230WH3jJqJK3MIYTd9ikGAc5iuqeBwPnnbVs3h2aYrDNX3UQQs8DY
         vxa0q41TGffu4BpNiR+2UL1IFZK5qJ4Fzuz+SAAd0ywlgQD9WnJU3x337+9dWxX7zC0h
         +U16xAOOYGnxILBih+qiIqIsoRBkl5fGvjLIWPwlYcmMhcosGl0pzWMFOkpRxyXZ6fVD
         kjBuTIqnRDLFLE7BsTKwhmhvh0tPkQ8Z9F5fcyBBKykSz8GwqUV8IbexAcd0cpJx1kj1
         evkw==
In-Reply-To: <20210328221205.726511-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Halasa <khc@pm.waw.pl>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Martin,

Could you ack this patch again? The only change from the RFC version
(that you previously acked) is the addition of the "__GFP_NOMEMALLOC"
flag in "dev_alloc_skb". This is because I want to prevent pfmemalloc
skbs (which can't be handled by netif_receive_skb_core) from
occurring.

Thanks!
