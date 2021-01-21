From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net v4] net: lapb: Add locking to the lapb module
Date: Wed, 20 Jan 2021 22:00:32 -0800
Message-ID: <CAJht_ENjV3k_d7TyeJmKopSPoVeGZb0s5PnkTeX_2hCOXNsWwg@mail.gmail.com>
References: <20210120102837.23663-1-xie.he.0141@gmail.com> <CAJht_EOdpq5wQfcFROpx587kCZ9dGRz6kesyPVhgZyKdoqS8Cg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nm/d5EhZ/OB8dy9RYltdCSlYB2STRBBjiHimEPU8NOw=;
        b=oD+OZniXZxdd2Cw+nAnP8VWLSUTfEFYCyR5mej2IGW5/W8u/E8BvWsvX4uEi9N6yjZ
         6FHjvrxSsGGFQpO3qZ8nrIZt1Vhk1j/nlSrqyqMJNB0WmvAdEG2G+ibbcZqQqGQwWm5u
         I+SpRqJLK1bzWHLAuLTqqm4Y4Ho9doYEIX2lSwazWKVoE4qMH9IeVEN5jrfGsYjt/Na9
         yu8GorLbx8AxJR8OZRCXFAbYYpvwhOskya9gKHyhx2LGQq2R4SWtpeM9KQWLnopQ2jFo
         JacczzMS4deT2l/5w/aRjDkn3Fq5QREZr1y0yDQr7sqowxySmefspXy6T7/PtejWQuDc
         awog==
In-Reply-To: <CAJht_EOdpq5wQfcFROpx587kCZ9dGRz6kesyPVhgZyKdoqS8Cg@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Wed, Jan 20, 2021 at 12:42 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> With this patch, there is still a problem that lapb_unregister may run
> concurrently with other LAPB API functions (such as
> lapb_data_received). This other LAPB API function can get the
> lapb->lock after lapb->lock is released by lapb_unregister, and
> continue to do its work. This is not correct.
>
> We can fix this problem by adding a new field "bool stop" to "struct
> lapb_cb" (just like "bool t1timer_stop, t2timer_stop"), and make every
> API function abort whenever it sees lapb->stop == true after getting
> the lock.
>
> Alternatively we can also require the callers (the LAPB drivers) to
> never call lapb_unregister concurrently with other LAPB APIs. They
> should make sure all LAPB API functions are only called after
> lapb_register ends and before lapb_unregister starts. This is a
> reasonable requirement, because if they don't follow this requirement,
> even if we do the fix in the LAPB module (as said above), the LAPB
> driver will still get the "LAPB_BADTOKEN" error from the LAPB module.
> This is not desirable and I think LAPB drivers should avoid this from
> happening.
>
> So I think this problem may not need to be fixed here in the LAPB
> module because the LAPB drivers should deal with this problem anyway.

Never mind, I have sent a v5 to deal with this problem. In v5, I made
lapb_unregister wait for the "lapb" refcnt to drop, so that we can
make sure all other API calls have finished. Please see my v5.
