Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513177;
	b=rt4+cuOyqvSr3e2gDLl3CZiv0HyLviXnnJwcJmbvQU5x2mVtqu1vzOXAFjg7WGyYbgIA
	 pW7gJUExxB4E3J7R7hM1XnJT472krG+huUrVGhNZ6+g4mXWVnOhShGjyB0Gbave4bw1cB
	 s+vJgUVihFHyY6kPFFx+v0UK55rANM6RKGz19nQblJU19OrH0RBKCQSaT8WFR8URpqDGt
	 oZocG5tyDT07x40vmWl98qArvOFnwJM5BeWvnJcJBoLuZN2fK1euqrehwhawhKgkZtH5a
	 5giWDQLAHScKS+/V5g/TcBa1Od7nv85/LIFDF0HU/Gh+rJ2IlnL0qDGno5RMWotDR7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513177;
	h=DMARC-Filter:DKIM2-Signature:Message-Instance:DKIM-Signature:
	 X-UI-Sender-Class:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-Provags-ID:
	 X-Spam-Flag:UI-OutboundReport;
	bh=Y9hLNvnj5t8dcfg9UUsbVfyqgtilHMmSoNdq8ajUf10=;
	b=V2M9zBlzxtEuTAHbB2p57ZkKRxOqWUJ3GhNsdSzblj27b3TDXZujtBmeAmFRC7Ri7E6d
	 LAPrPyY0yDMYEBZMNzkoSaiZxSY/dZ541fKofKYO+eVvtWjBigh59bkhABnCYZc5qIwSH
	 0yR0au4/UGV+K6QrqrwO7IYHJxZdakZMicOqT2JI/xgZeM0MG9BGV1rrkkrOsdrNvxUxB
	 7iY4yqXBJFrSdmSRwYVQJOiAHjmOFGbargoBzRHI0k0ZTRANqQ8WxwmTeZofBZjgjmd1L
	 a1aZ8E1JD1e7AdAYPMU5LG5JW0jrBSkCeh3CqgIK0PUfwYK76evXCJUn8mxj0QlFCjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmx.de;
	spf=pass smtp.mailfrom=gmx.de;
	dkim=pass header.d=gmx.de header.i=f3lix.dev@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="gVZpXSd/";
	arc=none smtp.remote-ip=212.227.15.19
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31575606A338
	for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 09:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31575606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=gVZpXSd/
DKIM2-Signature:  i=1; m=1; t=1795513174;
 mf=PGYzbGl4LmRldkBnbXguZGU+;
 rt=PGxpbnV4LXgyNUB2Z2VyLmtlcm5lbC5vcmc+;
 d=gmx.de;
 s=s31663417:rsa-sha256:rfb/NPMZuQdmSNi5Hl1M/nxjBXVM
   uj4BPh8jwVDml5NkBr18Wv/R+Udud51tF9l3mabJj/2C0aSiZRqqoQT36vjipoc+5Z4+dTP4Qqg
   xhHZstffsm+awQOmL3e3Uqr2EwfCgv/Rv23B2hSoX0G9wiw7VxzPHn8VrDefvt01Ty3P6VGevZ1
   KpPw5kIAo2MSKub0lwtaV1rdi4U8CTr5v4zOBF19GKrZFKqnQ6yYp9vQ7vDdIcT0/D6rprlVJ0U
   g5GLlDwwAiJlHHXNqH10/o5xMsFEOYX8BCiKIruX8f4og8+ncjiPOWvID5tJGrLtiaIfJ2TZmX5
   UH71xsGt3E2g6w==;
Message-Instance:  m=1;
 h=sha256:
   ZsRi3WwdBDI2GwfxdfA0xWxOmFEoVkmF856qm3G8qJ4=:
   mp+kwLmBeergVa56IbOSU1QsfAhWwGyHIHhSss1Rm24=,
  sha512:
   vaOPa7o79harAlK7Cih2BxX/JfOMOx+cI5b2VfTMXQkOkZ/3mS4MCHyVKtaNmvzuhPomfUF9jkz+hU14SFQXVw==:
   d3xcGGLimED54m3mkl97qaaVlDOrNnaFCMuVPNazbaYTgr0u7mld693qrHdbqeTFwDyqIzEivkinZApgvzoVtA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1795513170; x=1796117970; i=f3lix.dev@gmx.de;
	bh=Y9hLNvnj5t8dcfg9UUsbVfyqgtilHMmSoNdq8ajUf10=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gVZpXSd/F9xHlnLhvviyIHjJjBGndDb/2JDqok2TK5mAzSDv2tVAFmQl0MuAb1M1
	 NoClZOh8KmeSZ0X2Xa7nW+WbSIDzFtgmD6UaxxinGzjD98Pu3hm79UyVpQbdVM+fy
	 9ICTJ4yQ0kaaeKRkzwNePv16gpK6Y/Xz9yL8U2ky6dwwdx7fPgFBtQdVaqisbHFJh
	 b68p+kNTUo+YURw8KlfVJ2bjra3LMuJSBI9EOH5ljBQAFO1lWnRUhcxXQh2bsozyg
	 jRWTSlkLfF60nSNrZkvw438b4ipANeh4zFySru2LZLKJx71HYWCfvGBNklG9ciB0a
	 HkN7QqTMdI2uqhSbNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N1wlv-1yXP7D2jY9-015Zxg; Tue, 24
 Nov 2026 10:39:30 +0100
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
Subject: [PATCH net v2] net: x25: shut down T20 timer before freeing neighbour
Date: Tue, 24 Nov 2026 10:39:22 +0100
Message-ID: <20261124093922.39573-1-f3lix.dev@gmx.de>
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
X-Provags-ID: V03:K1:qsXB+iWSeAehumpa5RjYQq0JESEh2Y5THpnksBEgNT0KMvn77MP
 oRtVAQjH/gBLXel4YDSFUdhDR0Hz4+9qYreVqYkabn5azBd3UOtqJrtVsmQN8OLv2AGtbjv
 7bnSAeByF3g9uq7YJbRAHI2XRm6T2WlFg2uaG5SXI1r37g6rqJYAw8qT4CMTouOERl7d7AM
 zSROpzSM0BgLcQK6h/Wjg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Pz0/rk5CYZw=;G6lFVjBmFnv4hQryOs36waiziwW
 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
 LHLPn7HOqwS3E=

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

Also purge queued frames before releasing the neighbour, restoring the
cleanup removed by commit 7eed751b3b2a ("net/x25: handle additional
netdev events").

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Felix Hoffmann <f3lix.dev@gmx.de>
Acked-by: Martin Schiller <ms@dev.tdt.de>
=2D--
Tested with a two-vCPU KASAN, timer debugobjects and lockdep kernel using
a deterministic callback/teardown race. All 10 timer callbacks completed
without a KASAN, debugobjects, lockdep, warning, oops, or panic report.

Build-tested with W=3D1 under allmodconfig and allyesconfig.

The reproducer is available privately on request.

 net/x25/x25_link.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index d1e8cd81c2143..b9f290616e3a8 100644
=2D-- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -299,6 +299,8 @@ void x25_link_device_up(struct net_device *dev)
 static void __x25_remove_neigh(struct x25_neigh *nb)
 {
 	if (nb->node.next) {
+		timer_shutdown_sync(&nb->t20timer);
+		skb_queue_purge(&nb->queue);
 		list_del(&nb->node);
 		x25_neigh_put(nb);
 	}
=2D-=20
2.43.0

