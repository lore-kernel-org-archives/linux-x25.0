From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next] net: x25: Fix handling of Restart Request and
 Restart Confirmation
Date: Thu, 10 Dec 2020 07:35:23 +0100
Message-ID: <8e15d185cabc9294958b13f5cff389aa@dev.tdt.de>
References: <20201209081604.464084-1-xie.he.0141@gmail.com>
 <7aed2f12bd42013e2d975280a3242136@dev.tdt.de>
 <dde53213f7e297690e054d01d815957f@dev.tdt.de>
 <CAJht_EPk4uzA+QeL0_nHBhNoaro48ieF1vTwxQihk5_D66GTEA@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_EPk4uzA+QeL0_nHBhNoaro48ieF1vTwxQihk5_D66GTEA@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-12-09 21:16, Xie He wrote:
> On Wed, Dec 9, 2020 at 2:31 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> >> 1. When the x25 module gets loaded, layer 2 may already be running and
>> >> connected. In this case, although we are in X25_LINK_STATE_0, we still
>> >> need to handle the Restart Request received, rather than ignore it.
>> >
>> > Hmm... I've never loaded the X.25 module after the interface is UP, but
>> > in this case we really have to fix it.
>> >
>> 
>> This seems to be a regression caused by moving the Layer2 link 
>> handling
>> into the lapb driver, which wasn't intended in my original patchset.
>> 
>> I also have another patch on my todo list which aims orphan packet
>> handling in the x25_receive_data() function. Maybe it is better to 
>> catch
>> the whole thing there.
> 
> OK..
> 
> Currently it's not clear to me what your future patches would be.
> Maybe we can first have this patch applied? Because based on the
> current code I think this patch is necessary. When you are ready to
> submit your patches, you can replace my code and we can discuss
> further.

Yes, that's also the reason why I already acked this patch. We can
solve this later a little bit cleaner if necessary.

My patch that takes care of the orphaned packets in x25_receive_data()
has again a dependency on other patches, especially the patch to
configure the neighbor parameters (DCE/DTE, number of channels etc.),
which I already sent before but still have to revise.

Unfortunately I have only limited time for this topic, so I am not as
fast as some people would wish. Sorry for that.

Martin
