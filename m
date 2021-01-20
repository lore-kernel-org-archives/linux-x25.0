From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net v4] net: lapb: Add locking to the lapb module
Date: Wed, 20 Jan 2021 12:42:17 -0800
Message-ID: <CAJht_EOdpq5wQfcFROpx587kCZ9dGRz6kesyPVhgZyKdoqS8Cg@mail.gmail.com>
References: <20210120102837.23663-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=l4bZ7k3MLtL4D33E1D9YrozkMl3wQeHdeBeC/C0ogfE=;
        b=EMmI/yHTTV1Mpux7tKIPYfLFSTGkfH72QLHU1dgIqX1Y4igOtMYt0XoxjV37/m82QB
         BWmN+pKbES/bkyzb6tgjhZtElcy1O2JUH/FXnURIcZnrbc+u0sO3jN89LikTF0dg54ro
         IXp8PYLEGDRd1mZHqP109ZYQU7qAltNfcx11QCF5MqLt8Wt9h47lqxB9V/yGzS+WSNFv
         rMAMUGQ8UmnpaZLdwYW7YfsWwZxNSgZ3J0hUcoI9wKvdAOXngrq7kds/abp8Xnud15sZ
         FtjSm1uI/Yp5CIEEifMZLc3dxnHJGZlv8fjXGEe8632+cDpo6bcFSTlAhAURM29vrgu4
         L1rA==
In-Reply-To: <20210120102837.23663-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

With this patch, there is still a problem that lapb_unregister may run
concurrently with other LAPB API functions (such as
lapb_data_received). This other LAPB API function can get the
lapb->lock after lapb->lock is released by lapb_unregister, and
continue to do its work. This is not correct.

We can fix this problem by adding a new field "bool stop" to "struct
lapb_cb" (just like "bool t1timer_stop, t2timer_stop"), and make every
API function abort whenever it sees lapb->stop == true after getting
the lock.

Alternatively we can also require the callers (the LAPB drivers) to
never call lapb_unregister concurrently with other LAPB APIs. They
should make sure all LAPB API functions are only called after
lapb_register ends and before lapb_unregister starts. This is a
reasonable requirement, because if they don't follow this requirement,
even if we do the fix in the LAPB module (as said above), the LAPB
driver will still get the "LAPB_BADTOKEN" error from the LAPB module.
This is not desirable and I think LAPB drivers should avoid this from
happening.

So I think this problem may not need to be fixed here in the LAPB
module because the LAPB drivers should deal with this problem anyway.

Please feel free to share your comment. Thanks!
