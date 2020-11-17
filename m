From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v2 4/6] net/x25: support NETDEV_CHANGE notifier
Date: Tue, 17 Nov 2020 13:30:24 +0100
Message-ID: <93e2a7226531ce6832241be1c4296b9d@dev.tdt.de>
References: <20201116135522.21791-1-ms@dev.tdt.de>
 <20201116135522.21791-5-ms@dev.tdt.de>
 <CAJht_ENE5fGr-rgOd-5Tk_g5RJibaWBn_ey5Avo-2R2opMGcDA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_ENE5fGr-rgOd-5Tk_g5RJibaWBn_ey5Avo-2R2opMGcDA@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-17 12:41, Xie He wrote:
> On Mon, Nov 16, 2020 at 6:00 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> This makes it possible to handle carrier lost and detection.
>> In case of carrier lost, we shutdown layer 3 and flush all sessions.
>> 
>> @@ -275,6 +275,19 @@ static int x25_device_event(struct notifier_block 
>> *this, unsigned long event,
>>                                  dev->name);
>>                         x25_link_device_remove(dev);
>>                         break;
>> +               case NETDEV_CHANGE:
>> +                       pr_debug("X.25: got event NETDEV_CHANGE for 
>> device: %s\n",
>> +                                dev->name);
>> +                       if (!netif_carrier_ok(dev)) {
>> +                               pr_debug("X.25: Carrier lost -> set 
>> link state down: %s\n",
>> +                                        dev->name);
>> +                               nb = x25_get_neigh(dev);
>> +                               if (nb) {
>> +                                       x25_link_terminated(nb);
>> +                                       x25_neigh_put(nb);
>> +                               }
>> +                       }
>> +                       break;
>>                 }
>>         }
> 
> I think L2 will notify L3 if the L2 connection is terminated. Is this
> patch necessary?

Hmm... well I guess you're right. Admittedly, these patches were made
about 7 - 8 years ago and I have to keep thinking about them.
But I can't think of any situation where this patch should be necessary
at the moment.

I will drop this patch from the patch-set.
