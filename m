From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v2 17/17] net: Kill MSG_SENDPAGE_NOTLAST
Date: Tue, 20 Jun 2023 08:59:18 -0400
Message-ID: <6491a2a6f1488_3bcfec294d7@willemb.c.googlers.com.notmuch>
References: <648f36d02fe6e_33cfbc2944f@willemb.c.googlers.com.notmuch>
 <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-18-dhowells@redhat.com>
 <784658.1687176327@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687265960; x=1689857960;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4RvNVFujZzQ9FH/nRDQhxgK8HOnuVe0ilksjI7/FigQ=;
        b=V7CBqsvwa7HO9941Gx9rU48fbSNnkTARJq3hU0s4FJKqNq7uyQJvuWMi48BFYirjd9
         Z+CSYTenkWtjPExrbuK55Lr4LajYIvMVcZS1i2H4hkmnnVf92/3eU5+256AdSIU7TTh1
         xwVepNxy0+wSCXEIn2FLnq5fwolgWObqyrXGJD4a4dArZIDrRTCCQbOXeliLMdRNukOE
         bfBqEL3D5v18ty2Fda4DTUDINVko/+/f9bRuKWlc9As/MXSXKCsqRSAvjLHgGSN+PYBz
         OhKP930iRzIK8HICV0ZdtEG/GKM89Wb5av0m6K808diQPwrVMMP/ZUSrK2PjzRbzzuKs
         Xiqw==
In-Reply-To: <784658.1687176327@warthog.procyon.org.uk>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: dhowells@redhat.com, netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, dccp@vger.kernel.org, linux-afs@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-hams@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-rdma@vger.kernel.org, linux-sctp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-x25@vger.kernel.org, mptcp@lists.linux.de

David Howells wrote:
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Is it intentional to add MSG_MORE here in this patch?
> > 
> > I do see that patch 3 removes this branch:
> 
> Yeah.  I think I may have tcp_bpf a bit wrong with regard to handling
> MSG_MORE.
> 
> How about the attached version of tcp_bpf_push()?
> 
> I wonder if it's save to move the setting of MSG_SENDPAGE_NOPOLICY out of the
> loop as I've done here.  The caller holds the socket lock.
> 
> Also, I'm not sure whether to take account of apply/apply_bytes when setting
> MSG_MORE mid-message, or whether to just go on whether we've reached
> sge->length yet.  (I'm not sure exactly how tcp_bpf works).

I'm not very familiar with it either.

Instead of inferring whether MSG_MORE is safe to set, as below, sufficient to
rely on the caller to pass it when appropriate?

size = min(apply_bytes, sge->length). I doubt that size < apply_bytes is
ever intended.

And instead of this former branch

                if (flags & MSG_SENDPAGE_NOTLAST)
                        msghdr.msg_flags |= MSG_MORE;

update any caller to pass MSG_MORE instead of MSG_SENDPAGE_NOTLAST, if not yet
done so.

> 		msghdr.msg_flags = flags;
> 
> 		/* Determine if we need to set MSG_MORE. */
> 		if (!(msghdr.msg_flags & MSG_MORE)) {
> 			if (apply && size < apply_bytes)
> 				msghdr.msg_flags |= MSG_MORE;
> 			else if (!apply && size < sge->length &&
> 				 msg->sg.start != msg->sg.end)
> 				msghdr.msg_flags |= MSG_MORE;
> 		}
