From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: RE: [PATCH net-next v2 17/17] net: Kill MSG_SENDPAGE_NOTLAST
Date: Sun, 18 Jun 2023 12:54:40 -0400
Message-ID: <648f36d02fe6e_33cfbc2944f@willemb.c.googlers.com.notmuch>
References: <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-18-dhowells@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-can-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687107281; x=1689699281;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4sK61SVjYCcgummf/cy7pNsLb9SbPBeqU0f1FYDFMyI=;
        b=rY8QSvEl6p4fIeB+cNXrfBx3Qi8Q0oRZm5VoS2BoCgfjuYRQQUwrdFGEDdU23IrXo0
         chGoGHKPwP0LXmrfTl3qHlcCmo1sRYapzINEnQSow+fzi+pFn5PGiApYOrJ50HKaB68T
         utE+yg2GnzRQ30Bj8a8L69p3c374+UtcDkNfJR34GIn05f0b7+0AmEbyApvKm1DNJWT/
         bJcRj7sz29ir/3TzVW+gzb/qTkz7VnAPSgi9enEEZ3+K74hSxYqhdeSEvqiAsjKKoCqT
         OzoP6N5BMK7b0x2JfdgrfrTiD4DoK57jW0lPFco02d1KYyD6s/pMa/qc2P6IX40592qx
         JtnA==
In-Reply-To: <20230617121146.716077-18-dhowells@redhat.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: David Howells <dhowells@redhat.com>, netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>, Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, dccp@vger.kernel.org, linux-afs@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-hams@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-rdma@vger.kernel.org, linux-sctp@vger.kernel.org, linux-wpan@vger.kernel.org, lin

David Howells wrote:
> Now that ->sendpage() has been removed, MSG_SENDPAGE_NOTLAST can be cleaned
> up.  Things were converted to use MSG_MORE instead, but the protocol
> sendpage stubs still convert MSG_SENDPAGE_NOTLAST to MSG_MORE, which is now
> unnecessary.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: "David S. Miller" <davem@davemloft.net>
> cc: Eric Dumazet <edumazet@google.com>
> cc: Jakub Kicinski <kuba@kernel.org>
> cc: Paolo Abeni <pabeni@redhat.com>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: bpf@vger.kernel.org
> cc: dccp@vger.kernel.org
> cc: linux-afs@lists.infradead.org
> cc: linux-arm-msm@vger.kernel.org
> cc: linux-can@vger.kernel.org
> cc: linux-crypto@vger.kernel.org
> cc: linux-doc@vger.kernel.org
> cc: linux-hams@vger.kernel.org
> cc: linux-perf-users@vger.kernel.org
> cc: linux-rdma@vger.kernel.org
> cc: linux-sctp@vger.kernel.org
> cc: linux-wpan@vger.kernel.org
> cc: linux-x25@vger.kernel.org
> cc: mptcp@lists.linux.dev
> cc: netdev@vger.kernel.org
> cc: rds-devel@oss.oracle.com
> cc: tipc-discussion@lists.sourceforge.net
> cc: virtualization@lists.linux-foundation.org
> ---
>  include/linux/socket.h                         | 4 +---
>  net/ipv4/tcp_bpf.c                             | 4 +++-
>  net/tls/tls_device.c                           | 3 +--
>  net/tls/tls_main.c                             | 2 +-
>  net/tls/tls_sw.c                               | 2 +-
>  tools/perf/trace/beauty/include/linux/socket.h | 1 -
>  tools/perf/trace/beauty/msg_flags.c            | 3 ---
>  7 files changed, 7 insertions(+), 12 deletions(-)
>
 
> @@ -90,7 +90,9 @@ static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
>  {
>  	bool apply = apply_bytes;
>  	struct scatterlist *sge;
> -	struct msghdr msghdr = { .msg_flags = flags | MSG_SPLICE_PAGES, };
> +	struct msghdr msghdr = {
> +		.msg_flags = flags | MSG_SPLICE_PAGES | MSG_MORE,
> +	};
>  	struct page *page;
>  	int size, ret = 0;
>  	u32 off;

Is it intentional to add MSG_MORE here in this patch?

I do see that patch 3 removes this branch:

@@ -111,9 +111,6 @@  static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
 		if (has_tx_ulp)
 			msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;
 
-		if (flags & MSG_SENDPAGE_NOTLAST)
-			msghdr.msg_flags |= MSG_MORE;
-
