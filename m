From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: rework SIOCGSTAMP ioctl handling
Date: Thu, 30 Aug 2018 16:09:31 -0400
Message-ID: <CAF=yD-J7-GumUmonrZt7s44e3bsjY2DCD6ZpmhtCx6FOBV5BNA@mail.gmail.com>
References: <20180829130308.3504560-1-arnd@arndb.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CCY71oDba5HfDH1IH+EInLZWKOqhzUa8I+3WpzhWLg8=;
        b=RNyR9KwmkOkwufC92/PUcVJvYMEoC/GfoMe4YbEtWDznIYGl5ACD2Mclt0I9D5focF
         o4a459FnkNUg2xGQqI3hHxz7yz7hUSC0pPINYV1AMNTZF/c/r/N/bgKcL6hTnlyFSs3o
         KGL3dxOX/wDL3CcsRtaz2XZGT3sJznP5C7Tet61otuAQ2tzxg5cNE+SqJDRuUtxdgfm1
         wMehmjlWCHaP+NSPi/3bhMg2AjHDhR28xIhe+XwxPa9TW/BRtDMnexjt2hPQE6hBtwPH
         +MACW+95qLGFDzoXp0EMc9Ta5/I22wta0q+kFMOm63sE0/JqwApivXeJp+J9SzLl4xL6
         tsGg==
In-Reply-To: <20180829130308.3504560-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Network Development <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, linux-arch@vger.kernel.org, y2038 Mailman List <y2038@lists.linaro.org>, Eric Dumazet <edumazet@google.com>, Willem de Bruijn <willemb@google.com>, LKML <linux-kernel@vger.kernel.org>, linux-hams@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-sctp@vger.kernel.org, linux-x25@vger.kernel.org

On Wed, Aug 29, 2018 at 9:05 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The SIOCGSTAMP/SIOCGSTAMPNS ioctl commands are implemented by many
> socket protocol handlers, and all of those end up calling the same
> sock_get_timestamp()/sock_get_timestampns() helper functions, which
> results in a lot of duplicate code.
>
> With the introduction of 64-bit time_t on 32-bit architectures, this
> gets worse, as we then need four different ioctl commands in each
> socket protocol implementation.
>
> To simplify that, let's add a new .gettstamp() operation in
> struct proto_ops, and move ioctl implementation into the common
> sock_ioctl()/compat_sock_ioctl_trans() functions that these all go
> through.
>
> We can reuse the sock_get_timestamp() implementation, but generalize
> it so it can deal with both native and compat mode, as well as
> timeval and timespec structures.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

This also will simplify fixing a recently reported race condition with
sock_get_timestamp [1]. That calls sock_enable_timestamp, which
modifies sk->sk_flags, without taking the socket lock. Currently some
callers of sock_get_timestamp hold the lock (ax25, netrom, qrtr), many
don't. See also how this patch removes the lock_sock in the netrom
case. Moving the call to sock_gettstamp outside the protocol handlers
will allow taking the lock inside the function.

If this is the only valid implementation of .gettstamp, the indirect
call could be avoided in favor of a simple branch.

Thanks,

Acked-by: Willem de Bruijn <willemb@google.com>

[1] http://lkml.kernel.org/r/20180518080308.GA28587@dragonet.kaist.ac.kr
