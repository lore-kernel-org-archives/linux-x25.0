From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [net v3] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Wed, 5 Aug 2020 01:57:25 -0700
Message-ID: <CAJht_EMf5i1qykEP6sZjLBcPAN9u9oQoZ34dfJ68Z5XL6rKuDQ@mail.gmail.com>
References: <20200802195046.402539-1-xie.he.0141@gmail.com>
 <d02996f90f64d55d5c5e349560bfde46@dev.tdt.de> <CAJht_ENuzbyYesYtP0703xgRwRBTY9SySe3oXLEtkyL_H_yTSQ@mail.gmail.com>
 <9975370f14b8ddeafc8dec7bc6c0878a@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F2G3w7PdTgr3TT96rVAastMovHHJc9pKaM/XEhVPHIc=;
        b=qjYkgIBsi3VeBxcNODR6vDZxrHBGq6NjsSowDj5uEUYV6aQyVYIAk7vM+6NzQQDjzT
         bL43TetMosI4QztLIdp0e60upbdgIM7BqmBBnTK+dEKqmfFHaWBKQZMJDMxUuHgWFBYL
         EYM3ocF7pw6xS3/g0rzpg4sHywbtF+pqCxsSIuWyisZrjxctfCrC+Ql3KMZz0CCHOD/L
         Jc1kFSwba4BtPxMZ0QDpkPf5qOZIjxbYgj9SsZtc28E6mKoqf+9JwU9uepktmoMtA6q0
         n6FntkDYwfjbTYTzt63cOKUYS2c5QPQh5g4SbJkjftBX8NyH0OVuGUiJgCIAAFIL4iMO
         0qOQ==
In-Reply-To: <9975370f14b8ddeafc8dec7bc6c0878a@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Brian Norris <briannorris@chromium.org>, netdev-owner@vger.kernel.org

On Tue, Aug 4, 2020 at 10:23 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> > Adding skb_cow before these skb_push calls would indeed help
> > preventing kernel panics, but that might not be the essential issue
> > here, and it might also prevent us from discovering the real issue. (I
> > guess this is also the reason skb_cow is not included in skb_push
> > itself.)
>
> Well, you are right that the panic is "useful" to discover the real
> problem. But on the other hand, if it is possible to prevent a panic, I
> think we should do so. Maybe with adding a warning, when skb_cow() needs
> to reallocate memory.
>
> But this is getting a little bit off topic. For this patch I can say:
>
> LGTM.
>
> Reviewed-by: Martin Schiller <ms@dev.tdt.de>

Thank you so much!

Yes, it might be better to use skb_cow with a warning so that we can
prevent kernel panic while still being able to discover the problem.
If we want to do this, there are 2 more places in addition to
lapbeth_data_transmit that need to be guarded with skb_cow:
lapb_send_iframe and lapb_transmit_buffer in net/lapb/lapb_out.c.
Maybe we can address this in a separate patch.
