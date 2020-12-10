From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v7 4/5] net/x25: fix restart request/confirm
 handling
Date: Thu, 10 Dec 2020 07:27:17 +0100
Message-ID: <458f89938c565b82fe30087fb33602b9@dev.tdt.de>
References: <20201126063557.1283-1-ms@dev.tdt.de>
 <20201126063557.1283-5-ms@dev.tdt.de>
 <CAJht_EMZqcPdE5n3Vp+jJa1sVk9+vbwd-Gbi8Xqy19bEdbNNuA@mail.gmail.com>
 <CAJht_ENukJrnh6m8FLrHBwnKKyZpzk6uGWhS4_eUCyDzrCG3eA@mail.gmail.com>
 <3e314d2786857cbd5aaee8b83a0e6daa@dev.tdt.de>
 <CAJht_ENOhnS7A6997CAP5qhn10NMYSVD3xOxcbPGQFLGb8z_Sg@mail.gmail.com>
 <CAJht_EPj-4bv6D=Ojz5KCbk0NTVfjRyEA3NmMw7etxrq8GKu8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJht_EPj-4bv6D=Ojz5KCbk0NTVfjRyEA3NmMw7etxrq8GKu8Q@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-12-09 23:11, Xie He wrote:
> On Wed, Dec 9, 2020 at 1:47 AM Xie He <xie.he.0141@gmail.com> wrote:
>> 
>> On Wed, Dec 9, 2020 at 1:41 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> >
>> > Right.
>> > By the way: A "Restart Collision" is in practice a very common event to
>> > establish the Layer 3.
>> 
>> Oh, I see. Thanks!
> 
> Hi Martin,
> 
> When you submit future patch series, can you try ensuring the code to
> be in a completely working state after each patch in the series? This
> makes reviewing the patches easier. After the patches get applied,
> this also makes tracing bugs (for example, with "git bisect") through
> the commit history easier.

Well I thought that's what patch series are for:
Send patches that belong together and should be applied together.

Of course I will try to make each patch work on its own, but this is not
always possible with major changes or ends up in monster patches.
And nobody wants that.

Martin
