From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net v4] net: lapb: Add locking to the lapb module
Date: Wed, 20 Jan 2021 03:27:14 -0800
Message-ID: <CAJht_ENQyZq3wAkNWcoPje5dEjONYHTc-YDD0ebv0c3nf2fLFg@mail.gmail.com>
References: <20210120102837.23663-1-xie.he.0141@gmail.com> <c638797f2e2ed284b39abb165bf73251@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LNgmPmxDTYXqVVuxNtDhauIa5+ndfKYL0tyZwSQ0sU8=;
        b=PAnGRy7z8ipQXt+ToOR3gWdY0oN+BDZ3whhqD00D/9ajZKFgZd9Lq2LldXy+wAiZH+
         0dgGv/BRB63P6gDLn/BQMKH1mURKLnF2U/ku6XrLiDQP25dF9+5JwEcx3GdxYSCYabP+
         FF6AWrTQYR39LIoEMdUF2XSx0DsVcKp3jtAGQ1DIn4EyuQRGkqjGw9TcvzkS/3V5XW/Z
         hinzc/xEzLfEDaXMy4V5vmUkJgAW814QOdYfVOR7zQ8U033gZ9sm+gdmBA4zIn8+1B8d
         qfaqGouDoGj4bRatEbPAOiYh4P3s/pAdza/MtBsXlFPtj2xesQHP1s6Zs7evVWlhWXph
         feVg==
In-Reply-To: <c638797f2e2ed284b39abb165bf73251@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Jan 20, 2021 at 2:58 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Can you please add a Changelog. What was changed in v4?

Sorry, I forgot this. Here is the change log:

--- Changes from v3 to v4 ---

Only lapb_unregister has been changed.

v3 has a problem. When "del_timer_sync(&lapb->t1timer)" is called, if
the t1timer is running, it may restart itself by calling
lapb_start_t1timer. This way, del_timer_sync would not be able to
guarantee the t1timer has been completely stopped.

v4 fixed this problem by first calling lapb_stop_t1timer, making use
of its (new) ability of aborting running timers, and then calling
del_timer_sync to guarantee the t1timer has been stopped.

--- Changes from v2 to v3 ---

Created a new __lapb_disconnect_request function and made it be called
from both lapb_disconnect_request and lapb_device_event. This reduced
redundant code.

--- Changes from v1 to v2 ---

Broke long lines to keep the line lengths within 80 characters.
