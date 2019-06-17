From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] lapb: fixed leak of control-blocks.
Date: Sun, 16 Jun 2019 20:44:57 -0700 (PDT)
Message-ID: <20190616.204457.1507896436828804410.davem@davemloft.net>
References: <0000000000005c5d1d0589660769@google.com>
        <20190616155437.25299-1-jeremy@azazel.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190616155437.25299-1-jeremy@azazel.net>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: jeremy@azazel.net
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, syzbot+afb980676c836b4a0afa@syzkaller.appspotmail.com

From: Jeremy Sowden <jeremy@azazel.net>
Date: Sun, 16 Jun 2019 16:54:37 +0100

> lapb_register calls lapb_create_cb, which initializes the control-
> block's ref-count to one, and __lapb_insert_cb, which increments it when
> adding the new block to the list of blocks.
> 
> lapb_unregister calls __lapb_remove_cb, which decrements the ref-count
> when removing control-block from the list of blocks, and calls lapb_put
> itself to decrement the ref-count before returning.
> 
> However, lapb_unregister also calls __lapb_devtostruct to look up the
> right control-block for the given net_device, and __lapb_devtostruct
> also bumps the ref-count, which means that when lapb_unregister returns
> the ref-count is still 1 and the control-block is leaked.
> 
> Call lapb_put after __lapb_devtostruct to fix leak.
> 
> Reported-by: syzbot+afb980676c836b4a0afa@syzkaller.appspotmail.com
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Applied and queued up for -stable.
