From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [net v3] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Tue, 4 Aug 2020 12:20:17 -0700
Message-ID: <CAJht_ENuzbyYesYtP0703xgRwRBTY9SySe3oXLEtkyL_H_yTSQ@mail.gmail.com>
References: <20200802195046.402539-1-xie.he.0141@gmail.com> <d02996f90f64d55d5c5e349560bfde46@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dSFdfyvPC6qN3rDv8TbLIdSVXhfqaFQjHz20FwFT6s4=;
        b=r+ll7PmoizKu9XtmZtkGbq0jNGXN8IMG93WMrz/7IgmKIkrdXI06yIwr33K3Jcfn79
         jh+nwyPHw0AgsBAbvWkVTtlI0F1bMzE+QjGZXtB40gjgnuT40zzUHqPUC2GMHCs4iCfD
         fkTkVfQg2loFF9ElRGanOwxucIZAG0CR8Nf7rfVI7zuBi4Mph5QV51eXSAF46gINmFL8
         bLO06cSdW/HDOOujKoumRS5T7xHAE9kzV/rXqmnmlhYYjDKCKIAUuG7cQX5C6P/nTCJS
         IjW7rhe8W17Wh++0hBPOToL2tFO7pynMD1NgRi4crXwE/LyHFADYbeNbv2VoJBmlLaR2
         MjLA==
In-Reply-To: <d02996f90f64d55d5c5e349560bfde46@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Brian Norris <briannorris@chromium.org>, netdev-owner@vger.kernel.org

On Tue, Aug 4, 2020 at 5:43 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> I'm not an expert in the field, but after reading the commit message and
> the previous comments, I'd say that makes sense.

Thanks!

> Shouldn't this kernel panic be intercepted by a skb_cow() before the
> skb_push() in lapbeth_data_transmit()?

When a skb is passing down a protocol stack for transmission, there
might be several different skb_push calls to prepend different
headers. It would be the best (in terms of performance) if we can
allocate the needed header space in advance, so that we don't need to
reallocate the skb every time a new header needs to be prepended.
Adding skb_cow before these skb_push calls would indeed help
preventing kernel panics, but that might not be the essential issue
here, and it might also prevent us from discovering the real issue. (I
guess this is also the reason skb_cow is not included in skb_push
itself.)
