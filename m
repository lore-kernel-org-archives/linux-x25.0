From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net/x25: fix restart request/confirm handling
Date: Wed, 9 Dec 2020 01:17:23 -0800
Message-ID: <CAJht_ENukJrnh6m8FLrHBwnKKyZpzk6uGWhS4_eUCyDzrCG3eA@mail.gmail.com>
References: <20201126063557.1283-1-ms@dev.tdt.de> <20201126063557.1283-5-ms@dev.tdt.de>
 <CAJht_EMZqcPdE5n3Vp+jJa1sVk9+vbwd-Gbi8Xqy19bEdbNNuA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i2g8fi2sxo+IYXz2d5FDftsnAsDKdKjxlec5gNvekGY=;
        b=V6/jPHRRgiTymHfuMZyb/AiGMPLMq+CJU0v27LXBnECGFfDkcLWpUWzuJXZptEj92B
         kLleVEeTmpKMCxuM8yxikC5Eb6kxkos7EbpTdLM/aMHiWnydV1WdV3H9pj2LdkMNY5Ma
         OhwXxVniM2lO1tXypIYpCRMTpX7L2uan0DOdds81TrHybMVcOePo1PmZ42e3zjiDM2Oq
         cNjinS5DydvEKhlN03NSvTQ4qFMLilhKTMyuRsjSPY2CvhWqiX5qfOl72dVtMBNpmknx
         CK19ZEaD7LOaGhSoPouHVLzwmbEBJYCrFXA8VXeNfU7dbWsoxEYxYIA+zEFa5DC5LF+Z
         HzOQ==
In-Reply-To: <CAJht_EMZqcPdE5n3Vp+jJa1sVk9+vbwd-Gbi8Xqy19bEdbNNuA@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 9, 2020 at 1:01 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Wed, Nov 25, 2020 at 10:36 PM Martin Schiller <ms@dev.tdt.de> wrote:
> >
> >         switch (nb->state) {
> >         case X25_LINK_STATE_0:
> > -               nb->state = X25_LINK_STATE_2;
> > -               break;
> >         case X25_LINK_STATE_1:
> >                 x25_transmit_restart_request(nb);
> >                 nb->state = X25_LINK_STATE_2;
>
> What is the reason for this change? Originally only the connecting
> side will transmit a Restart Request; the connected side will not and
> will only wait for the Restart Request to come. Now both sides will
> transmit Restart Requests at the same time. I think we should better
> avoid collision situations like this.

Oh. I see. Because in other patches we are giving L2 the ability to
connect by itself, both sides can now appear here to be the
"connected" side. So we can't make the "connected" side wait as we did
before.
