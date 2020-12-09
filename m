From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next] net: x25: Fix handling of Restart Request and
 Restart Confirmation
Date: Wed, 9 Dec 2020 12:16:35 -0800
Message-ID: <CAJht_EPk4uzA+QeL0_nHBhNoaro48ieF1vTwxQihk5_D66GTEA@mail.gmail.com>
References: <20201209081604.464084-1-xie.he.0141@gmail.com>
 <7aed2f12bd42013e2d975280a3242136@dev.tdt.de> <dde53213f7e297690e054d01d815957f@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Gb52rLFb1PoO6DXkpk5zljkzOIofHR52NXCKENCFa4=;
        b=kehc2ECdte20dcviA2sV5xZ+n4UnvafAMyDlCabErXP1uJWSICsH9t++c5icoDpNi9
         6rZYh6ltHdQLf9Z6mllOQPSis08jMwvjqG0QjbvByKrqo8TcDZJ2XNbLtGNS5cQnniRi
         /atttUalbx6kjjwpQN4oePMgYOjEd5LpRKl84ht2vGfJJ5dRs3s4I1HeEXpdw+EHzWqR
         qfGOGSILO+68813rMDjYYMziIlDf1u0T83ZarRi9dGEGvbAyn4yPvbt9aYo33trQtowm
         VSo+R5xDwBzItoPz4G+0/LJYePQjW0TSk1d6RZN9khZD2/LOySBAAsbbRWiL5JwscLpM
         cJKw==
In-Reply-To: <dde53213f7e297690e054d01d815957f@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 9, 2020 at 2:31 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> >> 1. When the x25 module gets loaded, layer 2 may already be running and
> >> connected. In this case, although we are in X25_LINK_STATE_0, we still
> >> need to handle the Restart Request received, rather than ignore it.
> >
> > Hmm... I've never loaded the X.25 module after the interface is UP, but
> > in this case we really have to fix it.
> >
>
> This seems to be a regression caused by moving the Layer2 link handling
> into the lapb driver, which wasn't intended in my original patchset.
>
> I also have another patch on my todo list which aims orphan packet
> handling in the x25_receive_data() function. Maybe it is better to catch
> the whole thing there.

OK..

Currently it's not clear to me what your future patches would be.
Maybe we can first have this patch applied? Because based on the
current code I think this patch is necessary. When you are ready to
submit your patches, you can replace my code and we can discuss
further.
