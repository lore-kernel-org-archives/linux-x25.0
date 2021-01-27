From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB
 frames
Date: Wed, 27 Jan 2021 10:14:10 +0000
Message-ID: <77971dffcff441c3ad3d257825dc214b@AcuMS.aculab.com>
References: <20210127090747.364951-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20210127090747.364951-1-xie.he.0141@gmail.com>
Content-Language: en-US
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Xie He' <xie.he.0141@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>

From: Xie He
> Sent: 27 January 2021 09:08
> 
> An HDLC hardware driver may call netif_stop_queue to temporarily stop
> the TX queue when the hardware is busy sending a frame, and after the
> hardware has finished sending the frame, call netif_wake_queue to
> resume the TX queue.
> 
> However, the LAPB module doesn't know about this. Whether or not the
> hardware driver has stopped the TX queue, the LAPB module still feeds
> outgoing frames to the hardware driver for transmission. This can cause
> frames to be dropped by the hardware driver.
> 
> It's not easy to fix this issue in the LAPB module. We can indeed let the
> LAPB module check whether the TX queue has been stopped before feeding
> each frame to the hardware driver, but when the hardware driver resumes
> the TX queue, it's not easy to immediately notify the LAPB module and ask
> it to resume transmission.
> 
> Instead, we can fix this issue at the hdlc_x25 layer, by using qdisc TX
> queues to queue outgoing LAPB frames. The qdisc TX queue will then
> automatically be controlled by netif_stop_queue and netif_wake_queue.
> 
> This way, when sending, we will use the qdisc queue to queue and send
> the data twice: once as the L3 packet and then (after processed by the
> LAPB module) as an LAPB (L2) frame. This does not make the logic of the
> code messy, because when receiving, data are already "received" on the
> device twice: once as an LAPB (L2) frame and then (after processed by
> the LAPB module) as the L3 packet.

If I read this correctly it adds a (potentially big) queue between the
LAPB code that adds the sequence numbers to the frames and the hardware
that actually sends them.

IIRC [1] there is a general expectation that the NR in a transmitted frame
will be the same as the last received NS unless acks are being delayed
for flow control reasons.

You definitely want to be able to ack a received frame while transmitting
back-to-back I-frames.

This really means that you only want 2 frames in the hardware driver.
The one being transmitted and the next one - so it gets sent with a
shared flag.
There is no point sending an RR unless the hardware link is actually idle.

[1] I've been doing to much SS7 MTP2 recently, I can't quite remember
all of LAPB!

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

