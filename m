Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760902;
	b=SSzg9nFZ4omAkuqpX87AHAlQsn0paxeQyfXmYnjdnQGF0UA/Hhu4tFlIBRNTZWXlZWMr
	 Ia2+AsZ8jhacKZ52sRq2rcs5dHnW3kWwCCTHASsmuDddo5YBOK4elpwC6+yhbnsIjw7WE
	 pf7Zg/zrD0BMonmphuMOtnrvYhUQ2F9ZcJzxkuDIeixhgErjVwL3fsveUQbbZQdJdxMl/
	 1elZtGsWS77FzgAy+dWQM//5/2TQjN5ICCzEA1JYVfNei+lAezy/Hiph+qa0wupa6vDkw
	 nP+bXhqBIIzsCsTjDdvNdAUlPSqgzvwfN8vHs7GT+IZ0yvOx84WA1QWJdMju0tW3LuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760902;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Spam-Status:
	 X-Spam-Checker-Version:X-purgate-ID:X-purgate-type:X-purgate;
	bh=UodHLPDqWjBL7Xv1697eseoClJEzyLl8KwjaduFiolc=;
	b=h853b2kujyGnfHWeBfc150SbdKXMgt7QZ8Ne9kK/9uksk3XPSZ3pIQgj1tj4w4zNamTR
	 CEX2EPEG1C7kjeF8JyS1R88bgqkRg2I9UM8lG4fs310hBRyjftu+W7vvAG79PwTBewnE4
	 ASfKXT1fMqGaA+pHLZHeUHD+7Cx/y87KZQQ6YLpgVBxJ9Mn9be4+fpNYOq8mZdriz1IbS
	 eg1tyT6RcB+xJUhqAkCKE1NhhlkReYcjFFjbLXxH+hyqByj6RTTa5EBXP5xODjhVKBalD
	 b0p6cXq8JUBbefUyy0KH5tAxcwblCp/wGGwv72PNf42BEZQtsw6cdIPLA/3XadzXF5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=lgIsrbLJ;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45046606A31C;
	Fri, 27 Nov 2026 06:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45046606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=lgIsrbLJ
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68051b93b8=ms@dev.tdt.de>)
	id 1xWpRN-00179x-5w; Fri, 27 Nov 2026 07:28:13 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xWpRM-0022Ix-Ct; Fri, 27 Nov 2026 07:28:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795760891;
	bh=UodHLPDqWjBL7Xv1697eseoClJEzyLl8KwjaduFiolc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lgIsrbLJuwMf7J8Ng+P+Z3R+0D9YXlnnoy9jRMrpurv7bKG2by45XNubd0VaQVkEs
	 PJRNkxiEABuBhlz5FkQ05W8N3IS8jlNLcyQmtPSzTeEdC/jNBYpzZ+/y7k0nIFTjyI
	 aIVm3DTn5RpSCj1RE/zeFOTt9VxgaIgTumIw6BoDxUp/xRG/ahRueKuiFCcNbU0jHb
	 q1t4pyVa53hjLFk1auBFNkuTFqaXqmwPa0i6XL/UO0GkHitGjTwE7z3TAeNYGrooeT
	 B/tMthVMxYJVe6VLxYDqjB7vgINJP7VQexo3GnEhHzkP6sKv9cJpBxU87fLYKLSLBo
	 JkGnqp97rAc0w==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 98FBA240047;
	Fri, 27 Nov 2026 07:28:11 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 77858240046;
	Fri, 27 Nov 2026 07:28:11 +0100 (CET)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 4A47E2B005;
	Fri, 27 Nov 2026 07:28:11 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
Date: Fri, 27 Nov 2026 07:28:06 +0100 (CET)
Subject: [PATCH net v2 2/2] net/x25: re-check x25->neighbour after
 re-acquiring the socket lock
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261127-x25-kill-by-neigh-v2-2-c7cdcc9f1320@dev.tdt.de>
References: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
In-Reply-To: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Shuai Liu <847807867@qq.com>,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795760890; l=3385;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=NhCnx1iujnHfHOjcrIBGrjUBCnyPXbrReOsT71K+PBo=;
 b=WtFlzyOQ7J/saPKTkkiUOW0hJZ+7RFgjDuIzrNYtNUCgIxl9NVzFr9fmbZoM5ElVTMzuubxhT
 uyH9GXKNM0RBZddeWIcLCElz4Tk2jqWKb9su8cSzfENCVAdBgTsRDAH
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate-ID: 151534::1795760893-5BC12D96-86073EB3/0/0
X-purgate-type: clean
X-purgate: clean

x25_sendmsg(), x25_output() and x25_recvmsg() release the socket lock
while they wait for memory or data, and use x25->neighbour once they
own the socket again. The call may have been cleared in the meantime:
x25_disconnect() drops the neighbour reference and sets x25->neighbour
to NULL, for example when a CLEAR REQUEST from the peer or a link
failure is processed in softirq context while the socket is not owned.

sock_alloc_send_skb() only notices this if the disconnect happened
before its error checks. A disconnect during the allocation, or before
lock_sock() returns, leads to a NULL pointer dereference when
x25_sendmsg() builds the packet header or in the fragmentation loop of
x25_output(). In x25_recvmsg(), x25_disconnect() leaves x25->condition
alone, so if the receiver was busy, x25_check_rbuf() sends an RR
through x25_write_internal(), which dereferences x25->neighbour too.

Re-check x25->neighbour after lock_sock(): fail with -ENOTCONN in
x25_sendmsg() and x25_output(), and skip x25_check_rbuf() in
x25_recvmsg(), which still returns the data it has dequeued. Fragments
already queued by x25_output() have been purged by x25_disconnect() at
that point.

The x25_sendmsg() and x25_output() cases were also pointed out by the
netdev AI review of an earlier version of the x25_kill_by_neigh() fix.
Krystian Kaniewski found the x25_recvmsg() case by code inspection.

Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconnect")
Reported-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Closes: https://lore.kernel.org/all/02419845-bab8-4e36-9a98-6830761da1b9@gmail.com/
Link: https://lore.kernel.org/all/179121364205.434549.10310203820251738113@kernel.org/
Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/x25/af_x25.c  | 10 +++++++++-
 net/x25/x25_out.c |  6 ++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index a5d3a86918a0f4f337af4566dde4b43a907d1b49..ce22fd657caa911ab79ba510df29ccd1185ce25d 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1212,6 +1212,12 @@ static int x25_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
 	lock_sock(sk);
 	if (!skb)
 		goto out;
+
+	/* The call may have been cleared while the socket was unlocked */
+	rc = -ENOTCONN;
+	if (!x25->neighbour)
+		goto out_kfree_skb;
+
 	X25_SKB_CB(skb)->flags = msg->msg_flags;
 
 	skb_reserve(skb, X25_MAX_L2_LEN + X25_EXT_MIN_LEN);
@@ -1397,7 +1403,9 @@ static int x25_recvmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		msg->msg_namelen = sizeof(*sx25);
 	}
 
-	x25_check_rbuf(sk);
+	/* The call may have been cleared while the socket was unlocked */
+	if (x25->neighbour)
+		x25_check_rbuf(sk);
 	rc = copied;
 out_free_dgram:
 	skb_free_datagram(sk, skb);
diff --git a/net/x25/x25_out.c b/net/x25/x25_out.c
index f710d015fcc2ffd6a6922a0c29876bb248125666..89858a3fdf428b3eae5f9c8ba54fee82f73fd0d9 100644
--- a/net/x25/x25_out.c
+++ b/net/x25/x25_out.c
@@ -78,6 +78,12 @@ int x25_output(struct sock *sk, struct sk_buff *skb)
 				return err;
 			}
 
+			/* The call may have been cleared while unlocked */
+			if (!x25->neighbour) {
+				kfree_skb(skbn);
+				return -ENOTCONN;
+			}
+
 			skb_reserve(skbn, frontlen);
 
 			len = max_len > skb->len ? skb->len : max_len;

-- 
2.47.3

