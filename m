From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v2 5/6] net/lapb: support netdev events
Date: Mon, 16 Nov 2020 12:16:15 -0800
Message-ID: <CAJht_EM-ic4-jtN7e9F6zcJgG3OTw_ePXiiH1i54M+Sc8zq6bg@mail.gmail.com>
References: <20201116135522.21791-1-ms@dev.tdt.de> <20201116135522.21791-6-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hn+QJJDM3c7nvolPdWtjfb/V2c3QL8eTTV7HryUasbo=;
        b=cdi3E7QjT4b66BWeXGUrBBDZIbJKQThCrL0W53RsvoMm2a//jNUHh6pHiaqvJS2Kbe
         RpOAetEqtWzyq1iRqCD/LSGNh3xOlU15idieIZFU/HnTxSkVpaUcNZkfs4zqI5ThbJet
         6iyFT7NhPHEQgiGPo1ig97kjlx6iyEWl3u/afLJV3y2/vX9MTnpY0f6rhq4hm1+9jypK
         1xYLZSCNr5SrSj1fxWx5uDqLIAW0l+DEkNXJuTW0cpjUDRcg4yTrGBDBFMh5vG+pY2wP
         N70HazL0C5Id+NrpmoQLKweS99qytySxUHrMuGBFg+HQhMtPA0Z80V1uMpgYlLCNhCDh
         IbiQ==
In-Reply-To: <20201116135522.21791-6-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Mon, Nov 16, 2020 at 6:01 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> This makes it possible to handle carrier loss and detection.
> In case of Carrier Loss, layer 2 is terminated
> In case of Carrier Detection, we start timer t1 on a DCE interface,
> and on a DTE interface we change to state LAPB_STATE_1 and start
> sending SABM(E).

> +                               lapb_dbg(0, "(%p): Carrier detected: %s\n",
> +                                        dev, dev->name);
> +                               if (lapb->mode & LAPB_DCE) {
> +                                       lapb_start_t1timer(lapb);
> +                               } else {
> +                                       if (lapb->state == LAPB_STATE_0) {
> +                                               lapb->state = LAPB_STATE_1;
> +                                               lapb_establish_data_link(lapb);
> +                                       }
> +                               }

Do you mean we will now automatically establish LAPB connections
without upper layers instructing us to do so?

If that is the case, is the one-byte header for instructing the LAPB
layer to connect / disconnect no longer needed?
