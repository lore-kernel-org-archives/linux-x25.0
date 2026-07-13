Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F70434AB01
	for <linux-x25@vger.kernel.org>; Mon, 13 Jul 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783939677; cv=none; b=fZM2/pgW+8vs102g2kI0UlXxsl6QFsUqCy7KYQqc6EPHCmYn9P2C2Cc4Z4s3DgF8GdlJ3f5Qw2wDhVuM35UFWQurj9m80jprKWcSDnGT5ayqLB2gMOhX/iRANdH9JJK5he64lqTNSzF+Gfsr7cf60G/o5sgvKqy+3tXpGYVak+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783939677; c=relaxed/simple;
	bh=GxG/GDWpn5mwK1tIal/l0Dw5POK+wIXBW12wM/0SicE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dg+rhR361aM+gCHTF49o8fBZ3LmO/jlJkGthbujFC8ongWizs8RX+EysMYupTofiGju4pNhVT0Okps+QCakjeU/KroPooBuTO6EfFD9vFiZs1mQvSM+oMOLPRXS6CHgiOrVBe9trc0Z6ywX6BsYh6aS+emtBOTZ4KvDWLaGwrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=SCNJLHdV; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="SCNJLHdV"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-92e5cb052edso225231485a.2
        for <linux-x25@vger.kernel.org>; Mon, 13 Jul 2026 03:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1783939674; x=1784544474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=djDZZW+WjRlIj682sN8PrAtMnjaRhZOc5mbUij8u74g=;
        b=SCNJLHdVIYR2vI17FYhRc6vMgRd72AMHsMdRQ2KdsC2Klv15BaH19iXc/C0zJDHJnV
         13LKalp32u9aLgo83/OlgzCrRH/y2bKncA2TqrT72u793a//UnkIHQx3YYlWvvZolQRL
         YetGEv/2CoaxkYzO2UN+cEzHndQhLyywNBYIppkE7OwEk9LSiUaPMhDjkiTUM6oQwgib
         Xv/jYw5nBqXpfRNxW4Ec/C24bSerdnlm/00lkVWCtAziw6f/hQiwef98V8eGi8e1E80x
         V+Qik5b7VOgrVcZoo0TEsScFDeedDSBLp83T5XegPuLFBIMbJkBIjmJO3s5qlOoTcb7j
         /bDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783939674; x=1784544474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=djDZZW+WjRlIj682sN8PrAtMnjaRhZOc5mbUij8u74g=;
        b=H+EXMVQXj6t/NeodCF4/IsSfW8V6emyW5TdizlPmMUnD8/s1Ud830d/YNvCXfmZBpD
         EHVsO4M4qvCogO17bTAdnx3F0lCkj1C65R1KgMM3MMng/dvnWcIkoL3Bl/6shI7Pnh80
         M/58QebZirq+Ov3Oi0EeILgSbHtMezLBo/FJmdN8qaepwdOjmtUy2ipmGZzxIkFLaWFB
         jfKruif2pNz5Q9HLV08TvAyMktIbwt6v2EotEqSbkLsuEUwncwrepX2LaBprhIl69+qe
         ENphXpZQDZJcAUi1RIvqhfi0tJH4RdPgSJXnHIOsDjLEFueAAp3SbbhM5XTApIWOUzd1
         pqdA==
X-Forwarded-Encrypted: i=1; AHgh+RpzvAQ7VFXAdTbiNtsWYFzZwao3bl2QPNaaMN1PqKbYcFR54xO1D9/6oSjHejNJ5bVE/fqEpYWv088=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+k2Wo7qfb7fNzXaodoKdp84g+Ifl3W8diCP/MTYPk37maIVDj
	v0zW+B+W33gwKLbg/omyQKadgdRRdHs4AzPu8W4FnQnyikpO8Vp2VyzFIy9wIcUO10g=
X-Gm-Gg: AfdE7cl0Oi3V0aEQIQC2lVHT0i9eysjXvZezLTQr7MFChV3OCiYZzLQx+7N2Z12jq2M
	u2P5iKibWwBDKxoxpLH6JZkcnUQNVq0Muu4p875Dc+lirJU01jtaSRfpAFeIMjimdEQvgm7MFU6
	7awtb8v1Crq+afkTc2vqhjFsV2VPc2eFe7fQJ1Hd38eDOitI//QzL5jdvT9JdgkfJLUEyd5OYYT
	nnMvQRa8rcPRUKnqTj0LGBU1AwlDRYNio6gqoWBOa/CWWd8hGHrTN4cvnb+Cwc+Mb1/njCAqcb7
	pO/o7mUhVLow51Bvh2IF1+2Gu5whYdjoQvUesC4z7UVB07RIMk+L4e40Iz6hI4CMYkmiHjmMJce
	zFammifqbhYVW5FhaNQTwJ2JRJ/Yku+xV0OVZ7XTNXegZleQKp0Bk1CfHTqIYoPxTKETcz3Rqdr
	+dIgmy6Y7AAv/A1/XjWA==
X-Received: by 2002:a05:620a:25d1:b0:92e:71bb:d1ac with SMTP id af79cd13be357-92ef2aeb554mr848155785a.19.1783939674393;
        Mon, 13 Jul 2026 03:47:54 -0700 (PDT)
Received: from localhost ([146.190.222.192])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-92ee59223e7sm1031429685a.0.2026.07.13.03.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2026 03:47:54 -0700 (PDT)
From: David Lee <david.lee@trailofbits.com>
To: Martin Schiller <ms@dev.tdt.de>
Cc: David Lee <david.lee@trailofbits.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
	linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
Date: Mon, 13 Jul 2026 10:47:50 +0000
Message-ID: <20260713104752.241175-1-david.lee@trailofbits.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x25_kill_by_neigh() walks the global X.25 socket list looking for sockets
attached to a terminating neighbour. x25_list_lock protects list membership
while the lookup is in progress, but it does not pin a socket's lifetime
after the lock is dropped.

The function currently drops x25_list_lock before calling lock_sock(s). A
concurrent close can run x25_release(), remove the same socket from
x25_list, and drop the last socket reference in that window. The neighbour
teardown path can then lock or inspect a freed struct sock/struct x25_sock.

Take sock_hold(s) while x25_list_lock still proves that the list entry is
live, then drop the temporary reference after the socket has been locked,
rechecked, and released. Recheck x25_sk(s)->neighbour after lock_sock(),
because another path may have disconnected the socket before this path
acquired the socket lock. Restart the list walk after each disconnect
because the list lock was dropped and the previous iterator state may no
longer be valid.

A QEMU/KASAN run against origin/master reproduced a slab-use-after-free in
x25_kill_by_neigh().

Fixes: 7781607938c8 ("net/x25: Fix null-ptr-deref caused by x25_disconnect")
Cc: stable@vger.kernel.org
Signed-off-by: David Lee <david.lee@trailofbits.com>
Assisted-by: Codex:gpt-5.5
---
Trail of Bits has a reproducer that triggers kernel panic demonstrating the bug, and can share it if needed.

net/x25/af_x25.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index c31d2af5dd22..8aae9273b7c1 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -1768,15 +1768,19 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
 {
 	struct sock *s;
 
+again:
 	write_lock_bh(&x25_list_lock);
 
 	sk_for_each(s, &x25_list) {
 		if (x25_sk(s)->neighbour == nb) {
+			sock_hold(s);
 			write_unlock_bh(&x25_list_lock);
 			lock_sock(s);
-			x25_disconnect(s, ENETUNREACH, 0, 0);
+			if (x25_sk(s)->neighbour == nb)
+				x25_disconnect(s, ENETUNREACH, 0, 0);
 			release_sock(s);
-			write_lock_bh(&x25_list_lock);
+			sock_put(s);
+			goto again;
 		}
 	}
 	write_unlock_bh(&x25_list_lock);
