From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v2 5/6] net/lapb: support netdev events
Date: Tue, 17 Nov 2020 14:26:22 +0100
Message-ID: <c0c2cedad399b12d152d2610748985fc@dev.tdt.de>
References: <20201116135522.21791-1-ms@dev.tdt.de>
 <20201116135522.21791-6-ms@dev.tdt.de>
 <CAJht_EM-ic4-jtN7e9F6zcJgG3OTw_ePXiiH1i54M+Sc8zq6bg@mail.gmail.com>
 <f3ab8d522b2bcd96506352656a1ef513@dev.tdt.de>
 <CAJht_EPN=hXsGLsCSxj1bB8yTYNOe=yUzwtrtnMzSybiWhL-9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <CAJht_EPN=hXsGLsCSxj1bB8yTYNOe=yUzwtrtnMzSybiWhL-9Q@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Xie He <xie.he.0141@gmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 2020-11-17 12:32, Xie He wrote:
> On Tue, Nov 17, 2020 at 1:53 AM Martin Schiller <ms@dev.tdt.de> wrote:
>> 
>> On 2020-11-16 21:16, Xie He wrote:
>> > Do you mean we will now automatically establish LAPB connections
>> > without upper layers instructing us to do so?
>> 
>> Yes, as soon as the physical link is established, the L2 and also the
>> L3 layer (restart handshake) is established.
> 
> I see. Looking at your code in Patch 1 and this patch, I see after the
> device goes up, L3 code will instruct L2 to establish the connection,
> and before the device goes down, L3 will instruct L2 to terminate the
> connection. But if there is a carrier up/down event, L2 will
> automatically handle this without being instructed by L3, and it will
> establish the connection automatically when the carrier goes up. L2
> will notify L3 on any L2 link status change.
> 
> Is this right?

Yes, this is right.

> I think for a DCE, it doesn't need to initiate the L2
> connection on device-up. It just needs to wait for a connection to
> come. But L3 seems to be still instructing it to initiate the L2
> connection. This seems to be a problem.

The "ITU-T Recommendation X.25 (10/96) aka "Blue Book" [1] says under
point 2.4.4.1:
"Either the DTE or the DCE may initiate data link set-up."

Experience shows that there are also DTEs that do not establish a
connection themselves.

That is also the reason why I've added this patch:
https://patchwork.kernel.org/project/netdevbpf/patch/20201116135522.21791-7-ms@dev.tdt.de/

> It feels unclean to me that the L2 connection will sometimes be
> initiated by L3 and sometimes by L2 itself. Can we make L2 connections
> always be initiated by L2 itself? If L3 needs to do something after L2
> links up, L2 will notify it anyway.

My original goal was to change as little as possible of the original
code. And in the original code the NETDEV_UP/NETDEV_DOWN events were/are
handled in L3. But it is of course conceivable to shift this to L2.

But you have to keep in mind that the X.25 L3 stack can also be used
with tap interfaces (e.g. for XOT), where you do not have a L2 at all.

> 
>> In this context I also noticed that I should add another patch to this
>> patch-set to correct the restart handling.
> 
> Do you mean you will add code to let L3 restart any L3 connections
> previously abnormally terminated after L2 link up?

No, I mean the handling of Restart Request and Restart Confirm is buggy
and needs to be fixed also.

> 
>> As already mentioned I have a stack of fixes and extensions lying 
>> around
>> that I would like to get upstream.
> 
> Please do so! Thanks!
> 
> I previously found a locking problem in X.25 code and tried to address 
> it in:
> https://patchwork.kernel.org/project/netdevbpf/patch/20201114103625.323919-1-xie.he.0141@gmail.com/
> But later I found I needed to fix more code than I previously thought.
> Do you already have a fix for this problem?

No, sorry.


[1] https://www.itu.int/rec/T-REC-X.25-199610-I/
