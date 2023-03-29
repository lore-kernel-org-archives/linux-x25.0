From: David Howells <dhowells@redhat.com>
Subject: Re: [RFC PATCH v2 48/48] sock: Remove ->sendpage*() in favour of
 sendmsg(MSG_SPLICE_PAGES)
Date: Wed, 29 Mar 2023 15:39:33 +0100
Message-ID: <518631.1680100773@warthog.procyon.org.uk>
References: <e128356a-f56f-4c02-7437-dfea38e4194b@suse.de>
 <20230329141354.516864-1-dhowells@redhat.com>
 <20230329141354.516864-49-dhowells@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 553D741D25
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E40AA4000B
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3771884153
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 74CEC8414E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680100785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eOGvCBK3xTc7UhN8iQW8f99rBt5fCj0lar0/GGKSAUo=;
 b=I7DsYnxIXi+N95JxEr8u3mTDsEOO3Rl0GZAt2maRaaN0hsdWK0xUa7V6pfebfrJYdZhYdN
 bDX2gKAThIpA9TbaQAw78yN0rmH+SuZcOynknYVd4L3pGUxJoVVAGJYJ2eQLKYj202wOZi
 DV2odxcOIVHprMQ3Mqw2nfO/NOT6REU=
In-Reply-To: <e128356a-f56f-4c02-7437-dfea38e4194b@suse.de>
Content-ID: <518630.1680100773.1@warthog.procyon.org.uk>
List-Id: <linux-x25.vger.kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-doc@vger.kernel.org, virtualization@lists.linux-foundation.org, David Howells <dhowells@redhat.com>, linux-mm@kvack.org, linux-sctp@vger.kernel.org, linux-afs@lists.infradead.org, rds-devel@oss.oracle.com, linux-x25@vger.kernel.org, dccp@vger.kernel.org, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, Al Viro <viro@zeniv.linux.org.uk>, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, Eric Dumazet <edumazet@google.com>, linux-kernel@vger.kernel.org, Chuck Lever III <chuck.>

Hannes Reinecke <hare@suse.de> wrote:

> > [!] Note: This is a work in progress.  At the moment, some things won't
> >      build if this patch is applied.  nvme, kcm, smc, tls.

Actually, that needs updating.  nvme and smc now build.

> Weelll ... what happens to consumers of kernel_sendpage()?
> (Let's call them nvme ...)
> Should they be moved over, too?

Patch 42 should address NVMe, I think.  I can't test it, though, as I don't
have hardware.

There should be no callers of kernel_sendmsg() by the end of this patchset,
and the only remaining implementors of sendpage are Chelsio-TLS, AF_TLS and
AF_KCM, which as stated in the cover, aren't yet converted and won't build.

> Or what is the general consensus here?
> 
> (And what do we do with TLS? It does have a ->sendpage() version, too ...)

I know.  There are three things left that I need to tackle, but I'd like to
get opinions on some of the other bits and I might need some help with AF_TLS
and AF_KCM.

That said, should I just remove tls_sw_do_sendpage() since presumably the data
is going to get copied(?) and encrypted and the source pages aren't going to
be held onto?

David
