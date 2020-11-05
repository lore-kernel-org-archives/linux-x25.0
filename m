From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next] net: x25_asy: Delete the x25_asy driver
Date: Thu, 5 Nov 2020 12:04:55 -0800
Message-ID: <CAJht_EPP_otbU226Ub5mC_OZPXO4h0O2-URkpsrMBFovcdDHWQ@mail.gmail.com>
References: <20201105073434.429307-1-xie.he.0141@gmail.com> <CAK8P3a2bk9ZpoEvmhDpSv8ByyO-LevmF-W4Or_6RPRtV6gTQ1w@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=seMETD+A0muyA/mqytcvGqhJO4LEpEn0huI9QAUp6i8=;
        b=lQGBVRxreZ2HL1YK7S/KtNHaL6hNDaZW6v2xBDn0Go4RcZCmJfgyyvj9X93ifBZMd/
         DKtcKaPoPcaMdNPP4iak5uVgkbj/sRxVt/vuqY/WPg7gjIdt6UiecV+9SaXp4j8b6i/h
         5IA/8DB4Swijl1UPH2xK8LBZas81eZwQIaAczAaHyRcXjYECzHgmdQD7A61N4DESlMMf
         vPfx5VCX0alnNBnEavDlS+Qggp7QcW4Z+tdtnSii3MGImxv71fTxDTCGHHKcuons+G/r
         toULyUA7KsARE+JT8AzsGrtqJhEDYon05wt9f0as6Yr9JH94s85I5bxHjMNgMEbQ4RYB
         bZDw==
In-Reply-To: <CAK8P3a2bk9ZpoEvmhDpSv8ByyO-LevmF-W4Or_6RPRtV6gTQ1w@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Martin Schiller <ms@dev.tdt.de>, Andrew Hendry <andrew.hendry@gmail.com>, Linux X25 <linux-x25@vger.kernel.org>

On Thu, Nov 5, 2020 at 7:07 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> Adding Martin Schiller and Andrew Hendry, plus the linux-x25 mailing
> list to Cc.

The linux-x25 mail list has stopped working for a long time.

> When I last looked at the wan drivers, I think I concluded
> that this should still be kept around, but I do not remember why.

I think we only decided that X.25 as a whole was still needed. We
didn't decide that this particular driver was necessary.

> Since you did the bugfix mentioned above, do you have an idea
> when it could have last worked? I see it was originally merged in
> linux-2.3.21, and Stephen Hemminger did a cleanup for
> linux-2.6.0-rc3 that he apparently tested but also said "Not sure
> if anyone ever uses this.".

I think this driver never worked. Looking at the original code in
Linux 2.1.31, it already has the problems I fixed in commit
8fdcabeac398.

I guess when people (or bots) say they "tested", they have not
necessarily used this driver to actually try transporting data. They
may just have tested open/close, etc. to confirm that the particular
problem/issue they saw had been fixed.
