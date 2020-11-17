From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v2 5/6] net/lapb: support netdev events
Date: Tue, 17 Nov 2020 03:32:42 -0800
Message-ID: <CAJht_EPN=hXsGLsCSxj1bB8yTYNOe=yUzwtrtnMzSybiWhL-9Q@mail.gmail.com>
References: <20201116135522.21791-1-ms@dev.tdt.de> <20201116135522.21791-6-ms@dev.tdt.de>
 <CAJht_EM-ic4-jtN7e9F6zcJgG3OTw_ePXiiH1i54M+Sc8zq6bg@mail.gmail.com> <f3ab8d522b2bcd96506352656a1ef513@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=72x/SS97yDfmKLyCblUhiX5oYip81rPZoaO4o1zpdcE=;
        b=QYCtPyfG2qFh0OJrrWVRwzza/HzYapdghDvIWgBjSs0tzC2P/Tjvz6lhf/Z5H8UVSK
         TAZgqLInQcOla/xUWe6c8BCbJ5jBp2Nna9sG9Z9Oz5yHFe2yBhsJPUXqF284+pAr6ZBb
         zEp1HcXR5ioGnQmHofxF9N00KelVB/bHkqYlZ8vMSQqKj0IwF75tUU1EK0Kb7bBKrTh0
         KtXIkhi3h0j97ExIE2xTdjeOMbsha/AdmzMsCOVhY1dmourL2tMX/1mtqyOuarCCZdTQ
         SEgTW0lEhMipPMZIHcWLmlWj8rW7bGvuLDqF2Nq0XRFXiOmPxto83LzA15a94H5Rr/Ov
         r10A==
In-Reply-To: <f3ab8d522b2bcd96506352656a1ef513@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Nov 17, 2020 at 1:53 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> On 2020-11-16 21:16, Xie He wrote:
> > Do you mean we will now automatically establish LAPB connections
> > without upper layers instructing us to do so?
>
> Yes, as soon as the physical link is established, the L2 and also the
> L3 layer (restart handshake) is established.

I see. Looking at your code in Patch 1 and this patch, I see after the
device goes up, L3 code will instruct L2 to establish the connection,
and before the device goes down, L3 will instruct L2 to terminate the
connection. But if there is a carrier up/down event, L2 will
automatically handle this without being instructed by L3, and it will
establish the connection automatically when the carrier goes up. L2
will notify L3 on any L2 link status change.

Is this right? I think for a DCE, it doesn't need to initiate the L2
connection on device-up. It just needs to wait for a connection to
come. But L3 seems to be still instructing it to initiate the L2
connection. This seems to be a problem.

It feels unclean to me that the L2 connection will sometimes be
initiated by L3 and sometimes by L2 itself. Can we make L2 connections
always be initiated by L2 itself? If L3 needs to do something after L2
links up, L2 will notify it anyway.

> In this context I also noticed that I should add another patch to this
> patch-set to correct the restart handling.

Do you mean you will add code to let L3 restart any L3 connections
previously abnormally terminated after L2 link up?

> As already mentioned I have a stack of fixes and extensions lying around
> that I would like to get upstream.

Please do so! Thanks!

I previously found a locking problem in X.25 code and tried to address it in:
https://patchwork.kernel.org/project/netdevbpf/patch/20201114103625.323919-1-xie.he.0141@gmail.com/
But later I found I needed to fix more code than I previously thought.
Do you already have a fix for this problem?

> > If that is the case, is the one-byte header for instructing the LAPB
> > layer to connect / disconnect no longer needed?
>
> The one-byte header is still needed to signal the status of the LAPB
> connection to the upper layer.
