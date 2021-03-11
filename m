From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] net: lapbether: Prevent racing when checking
 whether the netif is running
Date: Thu, 11 Mar 2021 12:43:09 -0800
Message-ID: <20210311124309.5ee0ef02@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210311072311.2969-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615495390;
        bh=lACAyzgyWnB0qDdJmwRNuIg9HZ/bFs2tkjMU1/F663M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jygzY1rRtsVGwjNNJ8o9zfl+B5X/stcV78bX4sE+faSz2JjoSXOJ3oLk7wwA2OeAS
         sAIvIyainCGFTtRCs4yu4RBnIbZe471ktRhC+k+Tl3zVY/YGOObhY26RLhx09ZbU+8
         y2kpNk+J/GS/I0e4aYlU86gpoFILypwhTa+6K/sEavd526rPX7a+u/9FqoJi7SE1Tn
         cQhNPkn7M1fFaejJzxVWwKBIJevjmzdpNu1OdwHdppiAXmfITt4rj5kJvbRWxBoaJy
         bMPvrgkvC0zvqfCDh4TPsVV0F0GX44JTQ6G8MuBSbVka2p6T+Hz9fzGxRmJm7lxlWA
         J5oo+qUdLDCBQ==
In-Reply-To: <20210311072311.2969-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021 23:23:09 -0800 Xie He wrote:
> There are two "netif_running" checks in this driver. One is in
> "lapbeth_xmit" and the other is in "lapbeth_rcv". They serve to make
> sure that the LAPB APIs called in these functions are called before
> "lapb_unregister" is called by the "ndo_stop" function.
> 
> However, these "netif_running" checks are unreliable, because it's
> possible that immediately after "netif_running" returns true, "ndo_stop"
> is called (which causes "lapb_unregister" to be called).
> 
> This patch adds locking to make sure "lapbeth_xmit" and "lapbeth_rcv" can
> reliably check and ensure the netif is running while doing their work.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Is this a theoretical issues or do you see a path where it triggers?

Who are the callers sending frames to a device which went down?
