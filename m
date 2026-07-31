Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B784519A3;
	Fri, 31 Jul 2026 17:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785519618; cv=none; b=e53riRShKSfMKk6HRO4wKoLdULWjxYqzsdcCDynfg0lqLYahBw5fPwxKXV2q3rM5nfIANf/NV1pFx0t0pF8xkgNTr+SHMnDzTGzBmVkuMS/BDDLp8dASriEBfro1Fk38LUztYWViCc0FWU4Oi/0rP3wfRIxhA6TjUlbymUiPFiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785519618; c=relaxed/simple;
	bh=GYD8YmwCtARWmCshZxJv/QR9f/dT9oxVkiIzb4gIbdM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DiREGEeCKn1h4pakNJErqt+HBmXEfrzZPyEHBO5twGLU+9Vd3OixgsryINrKRbXcILMNiha+pGMiHhA7SmMxMu6zwooWN0o9pmkWOBci/QvGJ2oWpNzHVghf5YETLR6CeyKDYHUeBZ3H7jCRpo+fjjx2/eFhVO1sWCju7TMRSaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b=TUsHZnhJ; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=f3lix.dev@gmx.de header.b="TUsHZnhJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1785519607; x=1786124407; i=f3lix.dev@gmx.de;
	bh=xmX2h8fxZAD9rSk8/KAaDLJZxlY4K6Bl5kad0J6MvLI=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TUsHZnhJe+lshIXw9crIawuSLvR/HCao3/KHrlVgXh8eRgIZJeXmywd3ugT99kUl
	 2XVs+9gGMXLOrCyK8ooy8hVP3giFbNJsSbgw6o8cHFIXR6KF/3jBitisntURtpVUu
	 dcmMwp/mVtWnIeAtL6OWuNuZ8gcKFzSRlDBfOWSptIz64TSh62daco1MIAe69Piy0
	 gSI3t8iTb53p6KJexjxC3TGCazUpsq82+Huj4ZS4li9xgBKgKiDaGNFYam/7GjF7X
	 pkt6f3Qun0ZFlDRrW6k8vXDieXDh/6vqKtTcjUhD04O05JG2tTFcoAnSvzBGcHs5B
	 JnUvV74c82ou8GlRbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1wiA6F2nEa-00Erl6; Fri, 31
 Jul 2026 19:40:07 +0200
From: Felix Hoffmann <f3lix.dev@gmx.de>
To: linux-x25@vger.kernel.org,
	Martin Schiller <ms@dev.tdt.de>
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: x25: shut down T20 timer before freeing neighbour
Date: Fri, 31 Jul 2026 19:39:55 +0200
Message-ID: <20260731173955.1601698-1-f3lix.dev@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:n5ItcwhI9Y7gQRutoKtK5OpAtEaotSGsFCnhvIXA21U/IIq0Ty+
 Yb9Cy0dg5MyRGIUxsdYpnCAMfUTR689xM/g+sPsazrrGKQhLQLwgVgkjjPca8kXTYXS3Mo1
 prBUoebtcd5b3BEp5ui12WWyzXQcaZ1j3wELlgJ7Y6HTe+jesvkIVTZ/9Fqy5XeKmEMSRJs
 +jO2KF5HvSvqur/mpnKCg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:TO/Sxuz2mc4=;rzt9JLT1su7WFtDiXmJq85p4sdE
 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
 q4YPNtONLqpq92Qw==

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
=2D--
Tested with a two-vCPU KASAN, timer debugobjects and lockdep kernel using
a deterministic callback/teardown race. All 10 timer callbacks completed
without a KASAN, debugobjects, lockdep, warning, oops, or panic report.

Build-tested with W=3D1 under allmodconfig and allyesconfig.

The reproducer is available privately on request.

 net/x25/x25_link.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index d1e8cd81c214..876333cb16ae 100644
=2D-- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -298,6 +298,9 @@ void x25_link_device_up(struct net_device *dev)
  */
 static void __x25_remove_neigh(struct x25_neigh *nb)
 {
+	timer_shutdown_sync(&nb->t20timer);
+	skb_queue_purge(&nb->queue);
+
 	if (nb->node.next) {
 		list_del(&nb->node);
 		x25_neigh_put(nb);
=2D-=20
2.43.0
