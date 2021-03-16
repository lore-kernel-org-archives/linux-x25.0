From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: lapbether: Prevent racing when checking whether
 the netif is running
Date: Tue, 16 Mar 2021 08:54:58 -0700
Message-ID: <CAJht_EOLKSv=0A86GafDWTG1sEFNJCmFBH5QsdOtx28GzPL_pQ@mail.gmail.com>
References: <20210311072311.2969-1-xie.he.0141@gmail.com> <CAJht_ENT6E4pekdTJ8YKntKdH94e-1H6Tf6iBr-=Vbxj5rCs+A@mail.gmail.com>
 <111a4642c8ae3c9e0d9f271fe7c54e86@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CBzNMbocqQsxjfYGQ1EhaQ7uFSjRE7ceXnc5NaxO654=;
        b=dzYeJ1wT59wMMvs2pHK2ATQt++uhGR6mEwuyp6H838gqPrjAtdIn8X+UFolhukHeA8
         caizWrUGEZqOdTqUFiWzGujq+dB3/3hDN0NoJcoinZxQTWZ4os+Akv36qyhFVSjtsLU2
         H74inxcj/t1xEgHW+m3dduB4p+HWhaNA/P2am3AE7Wi/6Vl7MbN7EgXl41+y5r/Yo1E5
         FH+TxtBOEvAe4mWVrhkkYj/LR2mS8C5yn5yh9KYsBvaFN5/occy7WT36l3e/9dSmk/sx
         PpIBuz4gsWUext5EBRiig+47KKa/slOpmtyOHKmye6pvASAljooIt/epYNza3H609FHO
         FZDg==
In-Reply-To: <111a4642c8ae3c9e0d9f271fe7c54e86@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Mar 16, 2021 at 8:17 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> On 2021-03-14 02:59, Xie He wrote:
> > Hi Martin,
> >
> > Could you ack? Thanks!
>
> Acked-by: Martin Schiller <ms@dev.tdt.de>

Thank you!!
