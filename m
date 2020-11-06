From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH v2] net/x25: Fix null-ptr-deref in x25_connect
Date: Fri, 6 Nov 2020 08:06:49 -0800
Message-ID: <20201106080649.122dfb22@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201006054558.19453-1-ms@dev.tdt.de>
        <9751fc51170c9bf776e03d079a3e92e3@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604678810;
        bh=d9Gi07iaKLOb6bYB85zhOUrzxMsKmvTb4B3WbC93xyk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=T1WynHEc7leJzJZzHbDHezQ67N930g/hMbtg3wtJfD7rVSSzOv0kZ4ULHgzAE05r7
         EHkbxrxOHUYzF2/A9PV3QTKXe+wk1oqGT4qlRNUOG7xJfeRWABriGoSFogWnwgLCgK
         L1vBPfCVk83uRSPbbDh6ZgEn1mFDNVHngHSrGDWw=
In-Reply-To: <9751fc51170c9bf776e03d079a3e92e3@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: andrew.hendry@gmail.com, davem@davemloft.net, edumazet@google.com, xiyuyang19@fudan.edu.cn, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 06 Nov 2020 07:23:05 +0100 Martin Schiller wrote:
> On 2020-10-06 07:45, Martin Schiller wrote:
> > This fixes a regression for blocking connects introduced by commit
> > 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 
> > disconnect").
> > 
> > The x25->neighbour is already set to "NULL" by x25_disconnect() now,
> > while a blocking connect is waiting in
> > x25_wait_for_connection_establishment(). Therefore x25->neighbour must
> > not be accessed here again and x25->state is also already set to
> > X25_STATE_0 by x25_disconnect().
> > 
> > Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 
> > disconnect")
> > Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> 
> @David
> Is there anything left I need to do, to get this fix merged?

Hm, no idea what happened here (you could try to check the state in
patchwork but it's gonna take some digging to find a month old patch).

Please resend and we'll take it from there.
