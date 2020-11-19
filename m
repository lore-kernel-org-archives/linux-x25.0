From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v3 0/6] net/x25: netdev event handling
Date: Thu, 19 Nov 2020 08:02:22 +0100
Message-ID: <ae263ce5b1b31bfa763f755bdb3ef962@dev.tdt.de>
References: <20201118135919.1447-1-ms@dev.tdt.de>
 <CAJht_EPB5g5ahHrVCM+K8MZG9u5bmqfjpB9-UptTt+bWqhyHWw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJht_EPB5g5ahHrVCM+K8MZG9u5bmqfjpB9-UptTt+bWqhyHWw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-18 15:47, Xie He wrote:
> On Wed, Nov 18, 2020 at 5:59 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> ---
>> Changes to v2:
>> o restructure complete patch-set
>> o keep netdev event handling in layer3 (X.25)
> 
> But... Won't it be better to handle L2 connections in L2 code?
> 
> For example, if we are running X.25 over XOT, we can decide in the XOT
> layer whether and when we reconnect in case the TCP connection is
> dropped. We can decide how long we wait for responses before we
> consider the TCP connection to be dropped.
> 
> If we still want "on-demand" connections in certain L2's, we can also
> implement it in that L2 without the need to change L3.
> 
> Every L2 has its own characteristics. It might be better to let
> different L2's handle their connections in their own way. This gives
> L2 the flexibility to handle their connections according to their
> actual link characteristics.
> 
> Letting L3 handle L2 connections also makes L2 code too related to /
> coupled with L3 code, which makes the logic complex.

OK, I will give it a try. But we need to keep the possibility to
initiate and terminate the L2 connection from L3.

In the on demand scenario i mentioned, the L2 should be connected when
the first L3 logical channel goes up and needs to be disconnected, when
the last L3 logical channel on an interface is cleared.

> 
>> o add patch to fix lapb_connect_request() for DCE
>> o add patch to handle carrier loss correctly in lapb
>> o drop patch for x25_neighbour param handling
>>   this may need fixes/cleanup and will be resubmitted later.
>> 
>> Changes to v1:
>> o fix 'subject_prefix' and 'checkpatch' warnings
>> 
>> ---
>> 
>> Martin Schiller (6):
>>   net/x25: handle additional netdev events
>>   net/lapb: fix lapb_connect_request() for DCE
>>   net/lapb: handle carrier loss correctly
>>   net/lapb: fix t1 timer handling for DCE
>>   net/x25: fix restart request/confirm handling
>>   net/x25: remove x25_kill_by_device()
