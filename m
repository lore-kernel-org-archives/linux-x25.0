From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [net v3] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Wed, 05 Aug 2020 07:23:55 +0200
Message-ID: <9975370f14b8ddeafc8dec7bc6c0878a@dev.tdt.de>
References: <20200802195046.402539-1-xie.he.0141@gmail.com>
 <d02996f90f64d55d5c5e349560bfde46@dev.tdt.de>
 <CAJht_ENuzbyYesYtP0703xgRwRBTY9SySe3oXLEtkyL_H_yTSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJht_ENuzbyYesYtP0703xgRwRBTY9SySe3oXLEtkyL_H_yTSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Brian Norris <briannorris@chromium.org>, netdev-owner@vger.kernel.org

On 2020-08-04 21:20, Xie He wrote:
> On Tue, Aug 4, 2020 at 5:43 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> I'm not an expert in the field, but after reading the commit message 
>> and
>> the previous comments, I'd say that makes sense.
> 
> Thanks!
> 
>> Shouldn't this kernel panic be intercepted by a skb_cow() before the
>> skb_push() in lapbeth_data_transmit()?
> 
> When a skb is passing down a protocol stack for transmission, there
> might be several different skb_push calls to prepend different
> headers. It would be the best (in terms of performance) if we can
> allocate the needed header space in advance, so that we don't need to
> reallocate the skb every time a new header needs to be prepended.

Yes, I agree.

> Adding skb_cow before these skb_push calls would indeed help
> preventing kernel panics, but that might not be the essential issue
> here, and it might also prevent us from discovering the real issue. (I
> guess this is also the reason skb_cow is not included in skb_push
> itself.)

Well, you are right that the panic is "useful" to discover the real
problem. But on the other hand, if it is possible to prevent a panic, I
think we should do so. Maybe with adding a warning, when skb_cow() needs
to reallocate memory.

But this is getting a little bit off topic. For this patch I can say:

LGTM.

Reviewed-by: Martin Schiller <ms@dev.tdt.de>

