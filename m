From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB
 frames
Date: Thu, 28 Jan 2021 07:39:38 +0100
Message-ID: <2b14439178ff54e991c45a9a1574243e@dev.tdt.de>
References: <20210127090747.364951-1-xie.he.0141@gmail.com>
 <77971dffcff441c3ad3d257825dc214b@AcuMS.aculab.com>
 <CAJht_ENmxCBk=h68CN55qySMAiYhcgS0AtVzo6RvS5xf_6EkRw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_ENmxCBk=h68CN55qySMAiYhcgS0AtVzo6RvS5xf_6EkRw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: David Laight <David.Laight@aculab.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Halasa <khc@pm.waw.pl>

On 2021-01-27 21:29, Xie He wrote:
> On Wed, Jan 27, 2021 at 2:14 AM David Laight <David.Laight@aculab.com> 
> wrote:
>> 
>> If I read this correctly it adds a (potentially big) queue between the
>> LAPB code that adds the sequence numbers to the frames and the 
>> hardware
>> that actually sends them.
> 
> Yes. The actual number of outgoing LAPB frames being queued depends on
> how long the hardware driver stays in the TX busy state, and is
> limited by the LAPB sending window.
> 
>> IIRC [1] there is a general expectation that the NR in a transmitted 
>> frame
>> will be the same as the last received NS unless acks are being delayed
>> for flow control reasons.
>> 
>> You definitely want to be able to ack a received frame while 
>> transmitting
>> back-to-back I-frames.
>> 
>> This really means that you only want 2 frames in the hardware driver.
>> The one being transmitted and the next one - so it gets sent with a
>> shared flag.
>> There is no point sending an RR unless the hardware link is actually 
>> idle.
> 
> If I understand correctly, what you mean is that the frames sent on
> the wire should reflect the most up-to-date status of what is received
> from the wire, so queueing outgoing LAPB frames is not appropriate.
> 
> But this would require us to deal with the "TX busy" issue in the LAPB
> module. This is (as I said) not easy to do. I currently can't think of
> a good way of doing this.
> 
> Instead, we can think of the TX queue as part of the "wire". We can
> think of the wire as long and having a little higher latency. I
> believe the LAPB protocol has no problem in handling long wires.
> 
> What do you think?

David: Can you please elaborate on your concerns a little bit more?

I think Xie's approach is not bad at all. LAPB (L2) has no idea about L1
(apart from the link state) and sends as many packets as possible, which
of course we should not discard. The remaining window determines how
many packets are put into this queue.
Since we can't send anything over the line due to the TX Busy state, the
remote station (due to lack of ACKs) will also stop sending anything
at some point.

When the link goes down, all buffers/queues must be cleared.
