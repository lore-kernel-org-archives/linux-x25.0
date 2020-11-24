From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v6 2/5] net/lapb: support netdev events
Date: Tue, 24 Nov 2020 11:05:35 -0800
Message-ID: <CAJht_EOJ2M3tjN_2dQa2PweHCvJK8EXpnY7kGyJ7RezXBP4f8g@mail.gmail.com>
References: <20201124093938.22012-1-ms@dev.tdt.de> <20201124093938.22012-3-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B3AQ7qIleZ98ol81EX8UKJux3KkrTXmQK6HY6sjAr3Q=;
        b=cyZ66djmj11YFpB8eyen5l1og8njPdYe2JKIwrrePLcZoLVDmSMe+hS6Od0LksguBw
         eGwGFF6Q8d1FuGq6FkgIE266FU9eYTFoNGP2fsz7xIZuOxnBWLdO63qRCpREvO26AGQu
         +S0pVAXwYJoJiubREQlItqhFva77//OPa1w4dfs1B75V/T4+pLDe3SKPoRnJCAMhi91m
         P4zLMOU+Aw4XfzqlNzhKbm0Tho6QwgYVat0gVeYi3BM5C+1232G6a2H1UjXlRFTkyQFF
         rSYxs/+8lsI22Hy1hiMC+Iy46F7PifXVZAXrx0Ied4gEXvPORA/46C4iHMKEgmLIGgvB
         ObZw==
In-Reply-To: <20201124093938.22012-3-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Nov 24, 2020 at 1:40 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> This patch allows layer2 (LAPB) to react to netdev events itself and
> avoids the detour via layer3 (X.25).
>
> 1. Establish layer2 on NETDEV_UP events, if the carrier is already up.
>
> 2. Call lapb_disconnect_request() on NETDEV_GOING_DOWN events to signal
>    the peer that the connection will go down.
>    (Only when the carrier is up.)
>
> 3. When a NETDEV_DOWN event occur, clear all queues, enter state
>    LAPB_STATE_0 and stop all timers.
>
> 4. The NETDEV_CHANGE event makes it possible to handle carrier loss and
>    detection.
>
>    In case of Carrier Loss, clear all queues, enter state LAPB_STATE_0
>    and stop all timers.
>
>    In case of Carrier Detection, we start timer t1 on a DCE interface,
>    and on a DTE interface we change to state LAPB_STATE_1 and start
>    sending SABM(E).
>
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Acked-by: Xie He <xie.he.0141@gmail.com>

Thanks!
