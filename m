Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602755;
	b=WrghRngdvFuM4c4K3dMIfLxjhTL6PXhwF2Qo1hLhEj6/ckk0FwT1wINGTXyhukcZaQBy
	 iXhdWwOaE8gO7xEdlNOlKuUtYffFUfMKmtlIpARaZXVdk8CvIQpFVTjw9FFpgbBbtF+3c
	 tmj9JQ0PVv1TLyDLFdBYETuWhbWT3jncbSwv+RS8rCi1lIlH9maFq5uPmgSYtcoPZaKF5
	 MP82ElWkmqxuzQzZGHM4v5qMINjbSmgU66KoIa8j85Dx2abbHRUHoXWILaZW87UiNsuYF
	 xq/ooUOt93FIKwZHpPm7wmaA/w8FgHPmvwHnN/SiANtNez2nRuS1N3nTt7rYbq/mOKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602755;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=Z58PHH26Cd/VL7PAOM+Xxh8hOf8VnRk32CR2MEiIXSY=;
	b=rz6W+if6hBPjS+fSZSVTEN7OpFYNnIbviLQ5d12ztxuMqFE/n4pl5K2XWWnxaISZCMg8
	 w7sD9R45etWTot9DvrvdODvFu7QS8Zi+s7wb0Llfb6QKCMXrfzlCp9D63I6fszw5gw/qn
	 vF3Pdv2EpqiEdnUsaOdKMPo0HYNG/P+M5PCIHWcqFymJ4LDEzoiT06jzrgjVJDKz3+rHn
	 c9hDclt78JIgjxlo6lcV1RJNomU3fIqeMtIiT8DVHoMzWedXCv9BtLrfdAS70xPqwwTjf
	 MUKNntb+15tg1u+z3gTsokbkxAYor0aFLsxDTRGN0JP74aL0o9OKE9iXla7K47C6wjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=f3lix.dev@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=W7JT5TbJ;
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB86E606A339
	for <linux-x25@vger.kernel.org>; Wed, 25 Nov 2026 10:32:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB86E606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=W7JT5TbJ
DKIM2-Signature:  i=1; m=1; t=1795602752;
 mf=PGYzbGl4LmRldkBnbXguZGU+;
 rt=PGxpbnV4LXgyNUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:auiVLwqD2EvLmK5rqzIcEUHHxAY0
   bH0XeMM9wrhuM093P718hnFIAytNMHi9Yl2N2aRALY9IBI+b1vwOVB7X1l4txo73G3ZQDEaGdEk
   zOg4Z37zVS/5tQl5/+zgzjaF0RPvGKBBZ10ynfppBP5ggryiP0Wx9Ecfk48JIqJyEEPi4ThqhqU
   CzaeYdhNRppAtxNF5/9Wn5oOKILE+9P+J9EoNTZ39i3EAgWrfTcncxOJHzKg8OKcZDVVK8/kn3F
   66ic8vZ+m6wmU+xoBkrVJKaszHaReSnXdzPUuGkRUCNglb5nTgE3G2PtqMzI7b9rZxEeS4kY0EZ
   uA2B1EZmUONvLg==;
Message-Instance:  m=1;
 h=sha256:
   TcOTmVdqB5f0E/DBY16Wv+Y/voMgyb19jMV0O+WtxZ0=:
   lmQazu1c6YkVw2zbCt7xacH+aCznnqsM98FNKO4qQE4=,
  sha512:
   ut1TrjFK0Lca8m5f3DV3RADWqfLnLwfZbkwMb130OOy3aeJAuKLtYSovxHvVzNFOL1NZMyWhNFUEbkS6220V+A==:
   6QygDQJndhW1pUNDcUxDSsrcLfPrBkU+cXbJoTH0Og0hXUe8GrPzkxwpBs2X/urV+LT0cMtcT0pTp2/MK9Fycw==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795602719; x=1796207519; i=f3lix.dev@gmx.de;
	bh=Z58PHH26Cd/VL7PAOM+Xxh8hOf8VnRk32CR2MEiIXSY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=W7JT5TbJiiiL5XNnfmlM0nMUV00AziaBkGKpcijNsdzFVLLUeOPs2MoAkZWKRUdn
	 CuZZYebV7PGGe6EXkRyMExCxfkMRtRPpzfRLuKk9cuFYz8QSqsPjjtodQYFtUIO2y
	 IIhcLoC2ZpE0sIh05CVXLXRn+simMtUcH7/zPZSR1xZ6bChGTOFfMfgec0h1+74BD
	 Apb/y4O9ob+82jTtR6z1gkYLd7bsHBZgrdZENHw2k7DrsqM30Wz6tXs1diWa13ZpQ
	 ZbzG6daIPqiprqu49XD/SHkNu1BIU4agFpX6fuFYfvLe1K4EOVWMf+tksCDp6dovR
	 Gd4u+yd7jz84ocVmvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzyP-1y630K2ket-00ocif; Wed, 25
 Nov 2026 11:31:59 +0100
From: Felix Hoffmann <f3lix.dev@gmx.de>
To: linux-x25@vger.kernel.org,
	Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net v3] net: x25: shut down T20 timer before freeing neighbour
Date: Wed, 25 Nov 2026 11:31:53 +0100
Message-ID: <20261125103153.53012-1-f3lix.dev@gmx.de>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bndw/HGosKB4JVpPJgzwJs0BpY58mkaamq1LH0wKOURUHwbhRZL
 PJiXLgdoglIf0I6s4K3+BlfCRk1gYcuNbInZ8J2hIMTBpMeRI7TgMhl5lwiHm6aMfD7etZj
 /jUrr5I/YZMvujAumY/USk8CR9QgPbMXeRUk9uAvig5mFc3mknHrVIg+vFjcK2jMrXbBRZd
 XmoqdxFSWEML+kAEZwvvg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:47Q5vpdwIcg=;sTJf9aKkVa7vNWb53bBfZF5n0VM
 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
 v+ERzQDH6URJA=

x25_link_terminated() cancels the T20 restart timer with
timer_delete(). If the callback is already running on another CPU, the
cancel does not wait. The callback can then rearm the timer before
x25_link_device_down() removes the neighbour and drops its last
reference. This frees the neighbour while its embedded timer is active,
leading to a use-after-free on expiry.

Shut the timer down synchronously in __x25_remove_neigh() before
dropping the list-owned reference. timer_shutdown_sync() also prevents
the callback's unconditional rearm. The callback does not acquire
x25_neigh_list_lock, so it is safe to wait while neighbour removal keeps
the list protected.

Purge queued frames when the last neighbour reference is dropped. A
socket can take a reference before list removal and queue a frame after
the list-owned reference is gone, so purging during list removal is too
early. Purging at the final put also restores the cleanup removed by
commit 7eed751b3b2a ("net/x25: handle additional netdev events").

This issue was found while auditing protocol timer teardown paths for
callbacks that can rearm themselves after a non-synchronous timer
deletion. It was reproduced on a two-CPU KASAN kernel with timer
debugobjects and lockdep by delaying x25_t20timer_expiry() and deleting
the backing veth after the callback started. Timer debugobjects reported
an active timer being freed; with timer debugobjects disabled, KASAN
reported a slab use-after-free write in __run_timer_base().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
=2D--
Changes since v2:
- move the queue purge to the final neighbour put;
- document why __x25_remove_neigh() shuts down the timer;
- describe how the issue was found and reproduced in the commit message;
- drop Martin's Acked-by pending another review.

Tested with a two-CPU KASAN, timer debugobjects and lockdep kernel using
a deterministic callback/teardown race and a test-only one-second delay
in x25_t20timer_expiry(). All 10 timer callbacks completed without a
KASAN, debugobjects, lockdep, warning, oops, or panic report.

Build-tested the complete instrumented kernel and the X.25 objects with
W=3D1 under allmodconfig and allyesconfig.

The reproducer is available privately on request.

 include/net/x25.h  | 4 +++-
 net/x25/x25_link.c | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index 414f3fd99345..28cc36ff48b5 100644
=2D-- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -246,8 +246,10 @@ static __inline__ void x25_neigh_hold(struct x25_neig=
h *nb)
=20
 static __inline__ void x25_neigh_put(struct x25_neigh *nb)
 {
-	if (refcount_dec_and_test(&nb->refcnt))
+	if (refcount_dec_and_test(&nb->refcnt)) {
+		skb_queue_purge(&nb->queue);
 		kfree(nb);
+	}
 }
=20
 /* x25_out.c */
diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index d1e8cd81c214..2ef759832e10 100644
=2D-- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -294,11 +294,14 @@ void x25_link_device_up(struct net_device *dev)
  *	@nb: - neigh to remove
  *
  *	Remove neighbour from x25_neigh_list. If it was there.
+ *	Shut down the T20 timer before dropping the list reference so its
+ *	callback cannot rearm the timer after the neighbour is freed.
  *	Caller must hold x25_neigh_list_lock.
  */
 static void __x25_remove_neigh(struct x25_neigh *nb)
 {
 	if (nb->node.next) {
+		timer_shutdown_sync(&nb->t20timer);
 		list_del(&nb->node);
 		x25_neigh_put(nb);
 	}
=2D-=20
2.43.0

