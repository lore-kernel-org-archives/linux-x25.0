From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next] net: x25: Fix handling of Restart Request and
 Restart Confirmation
Date: Thu, 10 Dec 2020 01:40:41 -0800
Message-ID: <CAJht_EOD9QbCi=AkPRqoT2Hzweb65OTpxkoCeUNm9WUrnyw_8w@mail.gmail.com>
References: <20201209081604.464084-1-xie.he.0141@gmail.com>
 <7aed2f12bd42013e2d975280a3242136@dev.tdt.de> <dde53213f7e297690e054d01d815957f@dev.tdt.de>
 <CAJht_EPk4uzA+QeL0_nHBhNoaro48ieF1vTwxQihk5_D66GTEA@mail.gmail.com> <8e15d185cabc9294958b13f5cff389aa@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4wACi7c+y84hFlcOFDDjJ1mfg6gJ3+Zeyx/hwXEAMNU=;
        b=hJHsvvU/+uBIFX6TLQB40KT17anRRYSMu4q+h9i6CGgJUtcvGs8/l2Dy+eDmBoEFZ4
         pWKWCQGfBTdhFGKjGBfCHNHX1vgxY59IfxFVg1MHIebHR3SPRvy6Jg5NYUG0MIGYqdFx
         VL+D9RRYsdt0aXZPv1uiKd7o6uVr8rZPxzq+w4t4Nkt0WpHUYxlRWoCDnR0q4k/jJrqz
         DJ74T5HbAPcRjvbcVzQwb4iS5qjIx/F84LFOnCQkHX0noBBjoAKuh7pW1bCmHBV33FGG
         STMKGJbHQ92uZ2qXQ+pXHlwWlKJd/eU/NvvybgpfHU34/GsaervI4S720y1ZY7e1Xw5T
         CWVQ==
In-Reply-To: <8e15d185cabc9294958b13f5cff389aa@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 9, 2020 at 10:35 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Yes, that's also the reason why I already acked this patch. We can
> solve this later a little bit cleaner if necessary.
>
> My patch that takes care of the orphaned packets in x25_receive_data()
> has again a dependency on other patches, especially the patch to
> configure the neighbor parameters (DCE/DTE, number of channels etc.),
> which I already sent before but still have to revise.
>
> Unfortunately I have only limited time for this topic, so I am not as
> fast as some people would wish. Sorry for that.

OK. Thanks! I appreciate your work! Code needs to have specialist
developers like you to keep it alive and evolving.

I understand you have limited time. Please take your time. Thanks!
