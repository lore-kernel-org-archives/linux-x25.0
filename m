From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Thu, 30 Jul 2020 01:02:10 -0700
Message-ID: <CAJht_EO1srhh68DifK61+hpY+zBRU8oOAbJOSpjOqePithc7gw@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=XCmfqFtBUrWLGb0HRDwnKJuQyG0oIwWAg+A2BuLLHlk=;
        b=Ni9dtpixzC9T0JSf1dz8WSqnJqMFFOr6aMpkKq7RUF8VMgW6JliqG5FYvO+SjUr0RC
         jrgYAaQ2ukMMAjW34DThgLXD+Q3NhOfu7tt0H6kG5lCdNjEqU2yBUkxbEp7xBGE61hQ8
         Q51KOI1vwwm/fFJwiOdcDWp6ssn2nut+QzTXRuny6Vy0kReeTK/tw8EdBqq+dw6OSzXj
         BDT2LQBtrxDO6psEf8/6zRasJlWUlVvqw3JKT3gmes8ZViJ+2puSPCRSGkXfVMoO76J/
         xPp2dxWO/fW345mYWUygzMqthWQQNz9E/loJYeGFZzh/xHyAVWGITVnviouF0XVMGPo+
         q4Vg==
In-Reply-To: <20200730073702.16887-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

Hi Martin,

I'm currently working on a plan to make all X.25 drivers (lapbether.c,
x25_asy.c, hdlc_x25.c) to set dev->hard_header_len /
dev->needed_headroom correctly. So that upper layers no longer need to
guess how much headroom a X.25 device needs with a constant value (as
they currently do).

After studying af_packet.c, I found that X.25 drivers needed to set
needed_headroom to reserve the headroom instead of using
hard_header_len. Because hard_header_len should be the length of the
header that would be created by dev_hard_header, and in this case it
should be 0, according to the logic of af_packet.c.

So my first step is to fix the settings in lapbether.c. Could you
review this patch and extend your support via a "Reviewed-by" tag? If
this can be fixed, I'll go on and fix other X.25 drivers. Thanks!

It's very hard to find reviewers for X.25 code because it is
relatively unmaintained by people. I hope I can do some of the
maintenance work. I greatly appreciate your support!
