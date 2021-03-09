From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Tue, 9 Mar 2021 11:31:47 -0800
Message-ID: <CAJht_EM7Wtmtwi4=vEybSNbQrNmugC7HCLYcAjM07gEgeRtHMA@mail.gmail.com>
References: <20210305054312.254922-1-xie.he.0141@gmail.com> <4b30ca506b0d79ef5ba1a5e9ce9cf2cd@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HYJycecCKR8mJEVeAV0bVwc2FaxFgSqtKDz5fqSfG+Y=;
        b=t/BAtgEgV5Af5sZNLuhwg2mdyygRwGzvxfza2L1PSTQ6joDvwFqZ8lbBB+By+CVx8/
         dUqnPxqvWKnjVW+DAQdeYYddYwnXCiTXS+gRCOmwf50ydHtFaTTdJSkJD3cC8ydC+Gze
         Ykg6oQQ7UEKaTY1Bm86L0+LFwWHnybFhTlmYqONyfIEtKyCV6u8kt68Mwh4PN6hryHfv
         NyQsnZZCaGGMKf0/7tNfVmSnhHbiz2lRUO3BDw0/PhNNZxZAHj6hp/Aq6/Plhk3db8xN
         RpYtQCQNgk7c14Z5nBq9fA0iRHVwjHJJxGrZ80Ymthrn9iohWPWdp4y+MEVbfYTNqJLN
         U2JQ==
In-Reply-To: <4b30ca506b0d79ef5ba1a5e9ce9cf2cd@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Halasa <khc@pm.waw.pl>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Mar 9, 2021 at 5:23 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> I've tested the hdlc_x25 driver.
> Looks good to me.
>
> Acked-by: Martin Schiller <ms@dev.tdt.de>

Thank you!!

I'll re-send this patch after net-next is re-opened and my other fixes
get merged into net-next.

Thanks!
