From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v2 3/6] net/x25: replace x25_kill_by_device with
 x25_kill_by_neigh
Date: Wed, 18 Nov 2020 09:28:32 +0100
Message-ID: <352e0095deb8f1f3b08e335942eabac2@dev.tdt.de>
References: <20201116135522.21791-1-ms@dev.tdt.de>
 <20201116135522.21791-4-ms@dev.tdt.de>
 <CAJht_EN0fhD08+wH5kSBWvciHU7uM7iKJu_UcEXwZBKssuqNVw@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJht_EN0fhD08+wH5kSBWvciHU7uM7iKJu_UcEXwZBKssuqNVw@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-17 20:50, Xie He wrote:
> On Mon, Nov 16, 2020 at 6:00 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> Remove unnecessary function x25_kill_by_device.
> 
>> -/*
>> - *     Kill all bound sockets on a dropped device.
>> - */
>> -static void x25_kill_by_device(struct net_device *dev)
>> -{
>> -       struct sock *s;
>> -
>> -       write_lock_bh(&x25_list_lock);
>> -
>> -       sk_for_each(s, &x25_list)
>> -               if (x25_sk(s)->neighbour && x25_sk(s)->neighbour->dev 
>> == dev)
>> -                       x25_disconnect(s, ENETUNREACH, 0, 0);
>> -
>> -       write_unlock_bh(&x25_list_lock);
>> -}
>> -
>>  /*
>>   *     Handle device status changes.
>>   */
>> @@ -273,7 +257,11 @@ static int x25_device_event(struct notifier_block 
>> *this, unsigned long event,
>>                 case NETDEV_DOWN:
>>                         pr_debug("X.25: got event NETDEV_DOWN for 
>> device: %s\n",
>>                                  dev->name);
>> -                       x25_kill_by_device(dev);
>> +                       nb = x25_get_neigh(dev);
>> +                       if (nb) {
>> +                               x25_kill_by_neigh(nb);
>> +                               x25_neigh_put(nb);
>> +                       }
>>                         x25_route_device_down(dev);
>>                         x25_link_device_down(dev);
>>                         break;
> 
> This patch might not be entirely necessary. x25_kill_by_neigh and
> x25_kill_by_device are just two helper functions. One function takes
> nb as the argument and the other one takes dev as the argument. But
> they do almost the same things. It doesn't harm to keep both. In C++
> we often have different functions with the same name doing almost the
> same things.
> 

Well I don't like to have 2 functions doing the same thing.
But after another look at this code, I've found that I also need to
remove the call to x25_clear_forward_by_dev() in the function
x25_route_device_down(). Otherwise, it will be called twice.

> The original code also seems to be a little more efficient than the new 
> code.

The only difference would be the x25_get_neigh() and x25_neigh_put()
calls. That shouldn't cost to much.
