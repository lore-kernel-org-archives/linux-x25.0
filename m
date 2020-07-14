From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH] drivers/net/wan/x25_asy: Fix to make it work
Date: Tue, 14 Jul 2020 10:07:10 +0200
Message-ID: <490146353e9225245d8165b6edade1a9@dev.tdt.de>
References: <20200708043754.46554-1-xie.he.0141@gmail.com>
 <20200708.101321.1049330296069021543.davem@davemloft.net>
 <CAJht_EOqgWh0dShG258C3uoYdQga+EUae34tvL9HhqpztAv1PQ@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJht_EOqgWh0dShG258C3uoYdQga+EUae34tvL9HhqpztAv1PQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Shannon Nelson <snelson@pensando.io>, Martin Habets <mhabets@solarflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Linux X25 <linux-x25@vger.kernel.org>

On 2020-07-08 21:04, Xie He wrote:
> From: David Miller <davem@davemloft.net>
> Date: Wed, Jul 8, 2020 at 10:13 AM -0700
>> Something's not right, because I find it hard to believe this has been
>> so fundamentally broken for such a long period of time.
>> 
>> Maybe the drivers all handle things differently, and whilst your 
>> change
>> might fix some drivers, it will break others.
>> 
>> I'm not applying this until this situation is better understood.
> 
> Yes, it was hard for me to believe, too.
> 
> At first when I tried this driver, it was silently not able to 
> establish
> LAPB connections, I found that it was because it was ignoring
> 2-byte frames. I changed it to make 2-byte frames pass. Then I
> encountered kernel panic. I don't know how to solve it, so I looked
> at the way "lapbether" does things and changed this driver according
> to the "lapbether" driver. And it worked.
> 
> The "lapbether" driver and this driver both use the "lapb" module to
> implement the LAPB protocol, so they should implement LAPB-related
> code in the same way.
> 
> This patch only changes this driver and does not affect other drivers.
> 
> I don't know how I can better explain this situation. Please tell me
> anything I can do to help. Thanks!

It really seems very strange that this driver seems to contain such
fundamental errors. I have never used it.

But the explanations and fixes look plausible to me.
