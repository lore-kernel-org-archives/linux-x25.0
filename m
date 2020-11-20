From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4 2/5] net/lapb: support netdev events
Date: Fri, 20 Nov 2020 15:50:31 -0800
Message-ID: <CAJht_EP_oqCDs6mMThBZNtz4sgpbyQgMhKkHeqfS_7JmfEzfQg@mail.gmail.com>
References: <20201120054036.15199-1-ms@dev.tdt.de> <20201120054036.15199-3-ms@dev.tdt.de>
 <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x+VRrY9R8Fek/ma6fK+h1GJxZ+01lLXYDncUiaHc+18=;
        b=uX7vzR+xT2SS3BLynmzaH8E5JPpSnpNOZwUopYees7e5PjrCTSYxuhGmlluTYPcm8l
         kL9ENaX/79ZoJKfrA/zRZXTxDQ6fCzWn6rG01DvrxL6kZSrddwvm4r35IjeSzp7w94/0
         4LQDU75uXPBsWp/Pvqj/xw2HKkdoEMdOa1eRlby7tUOd2f6UPxvGX/DzGKU2uEUwRqgx
         RiBflxOwCkb/pL22z9nyeBixGBlS0obVLtejJlu3fNzvAjhrSZkGAWcqOg+qDvq21194
         jYM0qmcZnVcZyf35QN/0wbmMHUhEpz8MonuZY+1SkIsPwOw4e7rCXDXMbkvRVqdcPRQq
         L66w==
In-Reply-To: <CAJht_EONd3+S12upVPk2K3PWvzMLdE3BkzY_7c5gA493NHcGnA@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Fri, Nov 20, 2020 at 3:11 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> Should we also handle the NETDEV_UP event here? In previous versions
> of this patch series you seemed to want to establish the L2 connection
> on device-up. But in this patch, you didn't handle NETDEV_UP.
>
> Maybe on device-up, we need to check if the carrier is up, and if it
> is, we do the same thing as we do on carrier-up.

Are the device up/down status and the carrier up/down status
independent of each other? If they are, on device-up or carrier-up, we
only need to try establishing the L2 connection if we see both are up.

On NETDEV_GOING_DOWN, we can also check the carrier status first and
if it is down, we don't need to call lapb_disconnect_request.
