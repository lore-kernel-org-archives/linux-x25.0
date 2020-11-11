From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [RESEND PATCH v2] net/x25: Fix null-ptr-deref in x25_connect
Date: Wed, 11 Nov 2020 03:38:05 -0800
Message-ID: <20201111113805.44617-1-xie.he.0141@gmail.com>
References: <20201109065449.9014-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gZypMvFGW5/pMKgzZVWPRnEirLifs50mu6u8h37HDmI=;
        b=UnTeNA+PLFAXevIi/ssqDSio4u1I91tlJqiYr86WRheEHgdSi1G9D5JAIWe7fSq7KS
         WGumDuvL39rilD2D9i8ViMAyl3L5nWaOpygSnex2HRvvsw3y9Y6ZplBD0FZPzOW/a8m1
         6R4hT5U9Z9mTGkp/DB0vHNnwieO/dy7qu6bt+5f/MWc2q2k0/NBDXIHrGyaY8zc9Zoys
         CCYsYqOl+us1cqiYQ6Q4B2M8sudiVVdr/ka/WQanLqSiRbwftnQLTlx++Gd8iZI51/Ew
         KYXKh2n4YAFj6oXFGrOkAYl9UubhonkSvVH3wva3UFOSScD2Iq+VaHEvB3RZyI+NJcmm
         37Rw==
In-Reply-To: <20201109065449.9014-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, edumazet@google.com, xiyuyang19@fudan.edu.cn, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

> This fixes a regression for blocking connects introduced by commit
> 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconnect").

> The x25->neighbour is already set to "NULL" by x25_disconnect() now,
> while a blocking connect is waiting in
> x25_wait_for_connection_establishment(). Therefore x25->neighbour must
> not be accessed here again and x25->state is also already set to
> X25_STATE_0 by x25_disconnect().

> Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconnect")
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Oh. Sorry, I didn't see your patch. I just submitted another patch to fix
the same problem.

I also found another problem introduced by the same regression commit,
which I was also trying to fix in my patch.

See:
http://patchwork.ozlabs.org/project/netdev/patch/20201111100424.3989-1-xie.he.0141@gmail.com/

