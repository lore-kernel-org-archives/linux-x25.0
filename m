From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next] net: x25: Fix handling of Restart Request and
 Restart Confirmation
Date: Wed, 09 Dec 2020 11:31:54 +0100
Message-ID: <dde53213f7e297690e054d01d815957f@dev.tdt.de>
References: <20201209081604.464084-1-xie.he.0141@gmail.com>
 <7aed2f12bd42013e2d975280a3242136@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7aed2f12bd42013e2d975280a3242136@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-12-09 10:52, Martin Schiller wrote:
> On 2020-12-09 09:16, Xie He wrote:
>> 1. When the x25 module gets loaded, layer 2 may already be running and
>> connected. In this case, although we are in X25_LINK_STATE_0, we still
>> need to handle the Restart Request received, rather than ignore it.
> 
> Hmm... I've never loaded the X.25 module after the interface is UP, but
> in this case we really have to fix it.
> 

This seems to be a regression caused by moving the Layer2 link handling
into the lapb driver, which wasn't intended in my original patchset.

I also have another patch on my todo list which aims orphan packet
handling in the x25_receive_data() function. Maybe it is better to catch
the whole thing there.

>> 
>> 2. When we are in X25_LINK_STATE_2, we have already sent a Restart 
>> Request
>> and is waiting for the Restart Confirmation with t20timer. t20timer 
>> will
>> restart itself repeatedly forever so it will always be there, as long 
>> as we
>> are in State 2. So we don't need to check x25_t20timer_pending again.
> 
> Yeah, you're right, we can actually leave that out.
> 
> Acked-by: Martin Schiller <ms@dev.tdt.de>
