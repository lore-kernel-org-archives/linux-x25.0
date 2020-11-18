From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v2 5/6] net/lapb: support netdev events
Date: Wed, 18 Nov 2020 09:49:12 +0100
Message-ID: <c60fe64ff67e244bbe9971cfa08713db@dev.tdt.de>
References: <20201116135522.21791-1-ms@dev.tdt.de>
 <20201116135522.21791-6-ms@dev.tdt.de>
 <CAJht_EM-ic4-jtN7e9F6zcJgG3OTw_ePXiiH1i54M+Sc8zq6bg@mail.gmail.com>
 <f3ab8d522b2bcd96506352656a1ef513@dev.tdt.de>
 <CAJht_EPN=hXsGLsCSxj1bB8yTYNOe=yUzwtrtnMzSybiWhL-9Q@mail.gmail.com>
 <c0c2cedad399b12d152d2610748985fc@dev.tdt.de>
 <CAJht_EO=G94_xoCupr_7Tt_-kjYxZVfs2n4CTa14mXtu7oYMjg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJht_EO=G94_xoCupr_7Tt_-kjYxZVfs2n4CTa14mXtu7oYMjg@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-17 19:28, Xie He wrote:
> On Tue, Nov 17, 2020 at 5:26 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> On 2020-11-17 12:32, Xie He wrote:
>> >
>> > I think for a DCE, it doesn't need to initiate the L2
>> > connection on device-up. It just needs to wait for a connection to
>> > come. But L3 seems to be still instructing it to initiate the L2
>> > connection. This seems to be a problem.
>> 
>> The "ITU-T Recommendation X.25 (10/96) aka "Blue Book" [1] says under
>> point 2.4.4.1:
>> "Either the DTE or the DCE may initiate data link set-up."
>> 
>> Experience shows that there are also DTEs that do not establish a
>> connection themselves.
>> 
>> That is also the reason why I've added this patch:
>> https://patchwork.kernel.org/project/netdevbpf/patch/20201116135522.21791-7-ms@dev.tdt.de/
> 
> Yes, I understand that either the DTE or the DCE *may* initiate the L2
> connection. This is also the way the current code (before this patch
> set) works. But I see both the DTE and the DCE will try to initiate
> the L2 connection after device-up, because according to your 1st
> patch, L3 will always instruct L2 to do this on device-up. However,
> looking at your 6th patch (in the link you gave), you seem to want the
> DCE to wait for a while before initiating the connection by itself. So
> I'm unclear which way you want to go. Making DCE initiate the L2
> connection on device-up, or making DCE wait for a while before
> initiating the L2 connection? I think the second way is more
> reasonable.

Ah, ok. Now I see what you mean.
Yes, we should check the lapb->mode in lapb_connect_request().

>> > It feels unclean to me that the L2 connection will sometimes be
>> > initiated by L3 and sometimes by L2 itself. Can we make L2 connections
>> > always be initiated by L2 itself? If L3 needs to do something after L2
>> > links up, L2 will notify it anyway.
>> 
>> My original goal was to change as little as possible of the original
>> code. And in the original code the NETDEV_UP/NETDEV_DOWN events 
>> were/are
>> handled in L3. But it is of course conceivable to shift this to L2.
> 
> I suggested moving L2 connection handling to L2 because I think having
> both L2 and L3 to handle this makes the logic of the code too complex.
> For example, after a device-up event, L3 will instruct L2 to initiate
> the L2 connection. But L2 code has its own way of initiating
> connections. For a DCE, L2 wants to wait a while before initiating the
> connection. So currently L2 and L3 want to do things differently and
> they are doing things at the same time.
> 
>> But you have to keep in mind that the X.25 L3 stack can also be used
>> with tap interfaces (e.g. for XOT), where you do not have a L2 at all.
> 
> Can we treat XOT the same as LAPB? I think XOT should be considered a
> L2 in this case. So maybe XOT can establish the TCP connection by
> itself without being instructed by L3. I'm not sure if this is
> feasible in practice but it'd be good if it is.
> 
> This also simplifies the L3 code.

I also have a patch here that implements an "on demand" link feature,
which we used for ISDN dialing connections.
As ISDN is de facto dead, this is not relevant anymore. But if we want
such kind of feature, I think we need to stay with the method to control
L2 link state from L3.
