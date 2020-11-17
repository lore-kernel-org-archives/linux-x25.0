From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v2 5/6] net/lapb: support netdev events
Date: Tue, 17 Nov 2020 10:52:58 +0100
Message-ID: <f3ab8d522b2bcd96506352656a1ef513@dev.tdt.de>
References: <20201116135522.21791-1-ms@dev.tdt.de>
 <20201116135522.21791-6-ms@dev.tdt.de>
 <CAJht_EM-ic4-jtN7e9F6zcJgG3OTw_ePXiiH1i54M+Sc8zq6bg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJht_EM-ic4-jtN7e9F6zcJgG3OTw_ePXiiH1i54M+Sc8zq6bg@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-16 21:16, Xie He wrote:
> Do you mean we will now automatically establish LAPB connections
> without upper layers instructing us to do so?

Yes, as soon as the physical link is established, the L2 and also the
L3 layer (restart handshake) is established.

In this context I also noticed that I should add another patch to this
patch-set to correct the restart handling.

As already mentioned I have a stack of fixes and extensions lying around
that I would like to get upstream.

> If that is the case, is the one-byte header for instructing the LAPB
> layer to connect / disconnect no longer needed?

The one-byte header is still needed to signal the status of the LAPB
connection to the upper layer.
