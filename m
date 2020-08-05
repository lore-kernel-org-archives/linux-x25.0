From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [net v3] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Wed, 5 Aug 2020 11:33:10 +0200
Message-ID: <CA+FuTSf2r1eFoFHov-cGDG=5iLAUGt+Jv7Aok7EFrVo8UqkJog@mail.gmail.com>
References: <20200802195046.402539-1-xie.he.0141@gmail.com>
 <d02996f90f64d55d5c5e349560bfde46@dev.tdt.de> <CAJht_ENuzbyYesYtP0703xgRwRBTY9SySe3oXLEtkyL_H_yTSQ@mail.gmail.com>
 <9975370f14b8ddeafc8dec7bc6c0878a@dev.tdt.de> <CAJht_EMf5i1qykEP6sZjLBcPAN9u9oQoZ34dfJ68Z5XL6rKuDQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zv3njctJm6+JcXZYqCty4/Sd4dBn0kL3k7iTzjdDtfw=;
        b=oenfg43n0bbPqzDbC7M2gy1BFz6L4j5HVCwHLtU/Pd/u1lL9Q8XQe9N2tV7UufJLBo
         MATyUl4G6KT941Gq5GWK1IRQAUrFB+lObmZPz6DsWSFZIk98PEkOpyS44op89AjF0Yhc
         /nCPtftT2HFYYw1+IL9n60Qm0Rse1uvZQdFsSt1qycaGxhSvOLb2GrZKd3IQdGpnbER7
         55M2mlDFMUTcf3/1WW8TpGa8ffoPYhK6NHu8G+w75fYXZQNHZYmxpY7ENGI8aJd1IqbQ
         COcN6TjLK7eeGurWWCYgSthmkkpR2GYKwx/B6sEXmj3k30YgV+xNiFNNEZmqWstxYnmp
         HSoQ==
In-Reply-To: <CAJht_EMf5i1qykEP6sZjLBcPAN9u9oQoZ34dfJ68Z5XL6rKuDQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Brian Norris <briannorris@chromium.org>, netdev-owner@vger.kernel.org

On Wed, Aug 5, 2020 at 10:57 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Tue, Aug 4, 2020 at 10:23 PM Martin Schiller <ms@dev.tdt.de> wrote:
> >
> > > Adding skb_cow before these skb_push calls would indeed help
> > > preventing kernel panics, but that might not be the essential issue
> > > here, and it might also prevent us from discovering the real issue. (I
> > > guess this is also the reason skb_cow is not included in skb_push
> > > itself.)
> >
> > Well, you are right that the panic is "useful" to discover the real
> > problem. But on the other hand, if it is possible to prevent a panic, I
> > think we should do so. Maybe with adding a warning, when skb_cow() needs
> > to reallocate memory.
> >
> > But this is getting a little bit off topic. For this patch I can say:
> >
> > LGTM.
> >
> > Reviewed-by: Martin Schiller <ms@dev.tdt.de>
>
> Thank you so much!
>
> Yes, it might be better to use skb_cow with a warning so that we can
> prevent kernel panic while still being able to discover the problem.

Let's not add defenses to work around possibly buggy code. In the long
run that reduces code quality. Instead, fix bugs at the source.
