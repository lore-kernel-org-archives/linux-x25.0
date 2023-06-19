From: David Howells <dhowells@redhat.com>
Subject: Re: [PATCH net-next v2 17/17] net: Kill MSG_SENDPAGE_NOTLAST
Date: Mon, 19 Jun 2023 13:05:27 +0100
Message-ID: <784658.1687176327@warthog.procyon.org.uk>
References: <648f36d02fe6e_33cfbc2944f@willemb.c.googlers.com.notmuch>
 <20230617121146.716077-1-dhowells@redhat.com>
 <20230617121146.716077-18-dhowells@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D1DCC60A6F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 67FA7606B0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9A07760760
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 59906606B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687176342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=flv0m9IzvhIUpKnDIyrInh56vnSxXK9hbzXv0isFig8=;
 b=hnUetV29Dp1W/zpW3Yl5j5V1qiOL0PuvKfWbjW+/Y45dheY3YfE6x8eHoT5F07QrrWvRzQ
 DaXdCLnO8Xwe9tvzxtXtpL9O0n4sLRvf/sqR1KkR/qQea5tAFRpiDS2oUKIznpFUcPs5Og
 nWTlCXczkf/fPF88j/9jiSNVeRUj9TA=
In-Reply-To: <648f36d02fe6e_33cfbc2944f@willemb.c.googlers.com.notmuch>
Content-ID: <784657.1687176327.1@warthog.procyon.org.uk>
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
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: linux-doc@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, virtualization@lists.linux-foundation.org, dhowells@redhat.com, linux-mm@kvack.org, Eric Dumazet <edumazet@google.com>, linux-afs@lists.infradead.org, rds-devel@oss.oracle.com, linux-x25@vger.kernel.org, dccp@vger.kernel.org, linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, linux-hams@vger.kernel.org, mptcp@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-sctp@vger.kernel.org, tipc-discussion@lists.sourceforge.net, linux-crypto@vger.kernel.org, bpf@vger.kernel.org, linux-wpan@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Is it intentional to add MSG_MORE here in this patch?
> 
> I do see that patch 3 removes this branch:

Yeah.  I think I may have tcp_bpf a bit wrong with regard to handling
MSG_MORE.

How about the attached version of tcp_bpf_push()?

I wonder if it's save to move the setting of MSG_SENDPAGE_NOPOLICY out of the
loop as I've done here.  The caller holds the socket lock.

Also, I'm not sure whether to take account of apply/apply_bytes when setting
MSG_MORE mid-message, or whether to just go on whether we've reached
sge->length yet.  (I'm not sure exactly how tcp_bpf works).

David
---

static int tcp_bpf_push(struct sock *sk, struct sk_msg *msg, u32 apply_bytes,
			int flags, bool uncharge)
{
	bool apply = apply_bytes;
	struct scatterlist *sge;
	struct page *page;
	int size, ret = 0;
	u32 off;

	flags |= MSG_SPLICE_PAGES;
	if (tls_sw_has_ctx_tx(sk))
		msghdr.msg_flags |= MSG_SENDPAGE_NOPOLICY;

	while (1) {
		struct msghdr msghdr = {};
		struct bio_vec bvec;

		sge = sk_msg_elem(msg, msg->sg.start);
		size = (apply && apply_bytes < sge->length) ?
			apply_bytes : sge->length;
		off  = sge->offset;
		page = sg_page(sge);

		tcp_rate_check_app_limited(sk);
retry:
		msghdr.msg_flags = flags;

		/* Determine if we need to set MSG_MORE. */
		if (!(msghdr.msg_flags & MSG_MORE)) {
			if (apply && size < apply_bytes)
				msghdr.msg_flags |= MSG_MORE;
			else if (!apply && size < sge->length &&
				 msg->sg.start != msg->sg.end)
				msghdr.msg_flags |= MSG_MORE;
		}

		bvec_set_page(&bvec, page, size, off);
		iov_iter_bvec(&msghdr.msg_iter, ITER_SOURCE, &bvec, 1, size);
		ret = tcp_sendmsg_locked(sk, &msghdr, size);
		if (ret <= 0)
			return ret;

		if (apply)
			apply_bytes -= ret;
		msg->sg.size -= ret;
		sge->offset += ret;
		sge->length -= ret;
		if (uncharge)
			sk_mem_uncharge(sk, ret);
		if (ret != size) {
			size -= ret;
			off  += ret;
			goto retry;
		}
		if (!sge->length) {
			put_page(page);
			sk_msg_iter_next(msg, start);
			sg_init_table(sge, 1);
			if (msg->sg.start == msg->sg.end)
				break;
		}
		if (apply && !apply_bytes)
			break;
	}

	return 0;
}
