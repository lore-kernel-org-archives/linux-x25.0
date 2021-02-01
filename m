From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Mon, 01 Feb 2021 13:47:54 +0100
Message-ID: <abe3a003ad7fd68d3ecae5246e8d5137@dev.tdt.de>
References: <20210201055706.415842-1-xie.he.0141@gmail.com>
 <204c18e95caf2ae84fb567dd4be0c3ac@dev.tdt.de>
 <CAJht_EPGk871aqK-1+=W7vGZrX8QY8LDVF26jkFjm3veeQmPWw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_EPGk871aqK-1+=W7vGZrX8QY8LDVF26jkFjm3veeQmPWw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2021-02-01 11:49, Xie He wrote:
> On Mon, Feb 1, 2021 at 2:05 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> What kind of packages do you mean are corrupted?
>> ETH_P_X25 or ETH_P_HDLC?
> 
> I mean ETH_P_X25. I was using "lapbether.c" to test so there was no 
> ETH_P_HDLC.
> 
>> I have also sent a patch here in the past that addressed corrupted
>> ETH_P_X25 frames on an AF_PACKET socket:
>> 
>> https://lkml.org/lkml/2020/1/13/388
>> 
>> Unfortunately I could not track and describe exactly where the problem
>> was.
> 
> Ah... Looks like we had the same problem.
> 
>> I just wonder when/where is the logically correct place to copy the 
>> skb.
>> Shouldn't it be copied before removing the pseudo header (as I did in 
>> my
>> patch)?
> 
> I think it's not necessary to copy it before removing the pseudo
> header, because "skb_pull" will not change any data in the data
> buffer. "skb_pull" will only change the values of "skb->data" and
> "skb->len". These values are not shared between clones of skbs, so
> it's safe to change them without affecting other clones of the skb.
> 
> I also choose to copy the skb in the LAPB module (rather than in the
> drivers) because I see all drivers have this problem (including the
> recently deleted x25_asy.c driver), so it'd be better to fix this
> issue in the LAPB module, for all drivers.

OK.

Acked-by: Martin Schiller <ms@dev.tdt.de>

