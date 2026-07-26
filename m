Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B24D8308F0A
	for <linux-x25@vger.kernel.org>; Sun, 26 Jul 2026 22:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785103431; cv=none; b=YHb/HoavbSmyPTqABAllWWe/szEzg4rKEEksL6Ajwy3V2vnOm0K/JYKMiY3QCigFmKLu7ARjhMNx80A+ceh870LYNduklwu8umE3uWX0K1CybSwy7xX+Oz3PNoCdDYbmGpeL4P0RibBa+B+3oQK2Ig+jsU3naszrh8pZPxX/7aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785103431; c=relaxed/simple;
	bh=6amu4EHUVZbdF0ec7sOzgmE7XQm5ok1KlRoMrdsQnzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YKw83uLhPNz9Jv4lHMlEyS+jJd/GxctUny/W8fM9O+Sp3pmwl5HuNRwnOd60BuqUPG8hsWsYxweKcgOdqQcavteXv9/n3QxNzTkEqt+5Q6EYmIJC32zoQRscOKzGhCHMtTzN2BT26MNlbG2pazHBWirGwJVk8dC0/jU0WEU9EIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=LjXL58Zy; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="LjXL58Zy"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dcbade417so2176634a91.1
        for <linux-x25@vger.kernel.org>; Sun, 26 Jul 2026 15:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785103429; x=1785708229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fP/H9WRFqoVAFscWOAfedK5w+pV55M+V8lAJJkylO30=;
        b=LjXL58ZyZ3LGdPZJqqLryh1RRPLQU4FqULR9gjxnTscFOL435rI/6Z1Ae8FBJNhTFE
         OuI4LMG6CyHLetPrvgrbAhXDAwaE6DtFDKX45bwyv9MWHtewx1k5ZHxaQc2TuTF1nGFV
         xBMeyXEe6v4STlfTn24V0ayEAhyF9dAd6y4olGfUzMtpz5kDuak4umWOEAUx5XONBRep
         QQwd3Oqa0LqPWddsdUG+unoLSrNQxj/jIpCKWuPXz/QGTHvelnUT1YYjK908S7tc/zPz
         Otlr8aL4xCOFr0MWRpuWYnX2hSeiAR0sJLLI3SciTaXJLiap8yptgE5lUYr/GEXi74d+
         ijVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785103429; x=1785708229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fP/H9WRFqoVAFscWOAfedK5w+pV55M+V8lAJJkylO30=;
        b=FNSetluIPKk5E9KmWc+0PjMo8x2ipsmt+c8lpYSqrBX8v0yfphRuqWYy+fI5ak+OYQ
         43xiKFnk6GqrjsEscglIq6cC21RTyaQrZeoTjbSayt/62PAwzZQz0GsoWvKXERMAdwV/
         MLszkJInS5zTcG6oPipdaxJYpbONDmYlFCs+kVr7hGO264ovK8UIKawpQlRKeaksyncq
         7/ESOE7rT7EgBusimVLMY47gj6gBqYecdaQTY/RkEVr93/tpMI/OhgDYDC17CW1cFUuY
         lgoklQiYmxYI6KvS9U9TLJRChmTid1D5ewOf7EgrMeec1eoELHAjSkLPP52jn3RNInH4
         6neA==
X-Forwarded-Encrypted: i=1; AHgh+RoYUb0h++Vm+bLNgfvjryqBZ7pvFliMBXl/PlVH8RgqLxoitvaIyw6FTGHA8UFXpgOS1Twe29aSuxs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwkqruU1TOMUhVjuLgLLD+iUFva8MM5AVpH0WANjxCO7FInBWx
	sPQ7pOV/emYUkV8NOz/yWobKC9ROtmO64eDu0y2cEuvwFG49pUBY3F31kBCRG7ywN/o/lD6oqJg
	RyNhh7rk=
X-Gm-Gg: AR+sD11wJR/RSv+gbytI0ep6d8gnbzd7fkMzelWLFWFs6cC0GlxT/PDDDFdsjVprmAq
	OulpkFKZLr4EeS/h+cz3iZg8mS29u4gkE2g536dLdmflwMWYEpthhilZSJeV+vQngi+VlJpggKU
	vY6WxOVhx0nAU38LLrbk63kqrOv5yKWask86KWaIYq2ndu7DSFUTnrqeNHLov3s73FVFEyejKuR
	ZpVvsNlGjRRD+B+20mpHqIjcpsZeoR4AUp4e2806qcjkst4SSdh1SFROicqGFXD/ff0jV2TPgdX
	5VNggmBRRtCU0U0p7QUg49Hez6RSZD4jTtcui4Jm7w15e6TaZ1wdJGXKQdyGU7ajx4YvU3MQHfB
	XvMs1/iPK7S9TMX3ZgOypOx0znxdGTzNZfSaaMWzs75oGkI/5mOmJAviUR6Bp5m9QfhqFNPqmgD
	BreECa/I/eO+qJaEQtsumdHqGaXeXmqEj/5Usr39k3nsx56qDoOFjEEEbMjq/xSkf8+Jk1i6I=
X-Received: by 2002:a17:90b:53c8:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-38f294ec506mr6198184a91.15.1785103428989;
        Sun, 26 Jul 2026 15:03:48 -0700 (PDT)
Received: from localhost.localdomain ([125.128.148.126])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f2951eb8dsm2112310a91.13.2026.07.26.15.03.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Jul 2026 15:03:48 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: netdev@vger.kernel.org
Cc: ms@dev.tdt.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	linux-x25@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/x25: fix use-after-free of the socket by its timers
Date: Mon, 27 Jul 2026 07:03:42 +0900
Message-ID: <20260726220342.47245-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The x25 timers are armed with mod_timer() and cancelled with
timer_delete(), so a pending timer holds no reference on the socket and a
cancel does not wait for a callback already running on another CPU.

x25_heartbeat_expiry() also rearms unconditionally, so it can reinstall
sk->sk_timer after __x25_destroy_socket() has passed its cancel point.
The following __sock_put() frees the socket while the timer is still
queued, and the next expiry uses freed memory.  KASAN reports a
slab-use-after-free on the kmalloc-2k object freed by close().

timer_delete_sync() cannot be used here: x25_heartbeat_expiry() and
x25_timer_expiry() both reach the cancels from inside the timer they
would wait on, through __x25_destroy_socket() and x25_disconnect().

Arm the timers with sk_reset_timer() and cancel them with sk_stop_timer()
so that an armed timer owns a reference, and release it in both expiry
handlers.  Rearm the heartbeat only while sk_hashed(sk) is still true,
since __x25_destroy_socket() unlinks the socket before dropping it.  Arm
the deferred destroy timer the same way and drop its reference in
x25_destroy_timer().

Reproduced on net with KASAN, with the heartbeat period shortened so the
window recurs.  With this patch the reproducer no longer triggers a
report and /proc/net/x25 drains.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
v2:
 - shorten the commit message (Andrew Lunn)
 - drop the Reported-by tags; there is no public report to credit
   (Andrew Lunn)
 - retest on net instead of v7.2-rc4; the bug is still present there as of
   53658c6f3682 (Andrew Lunn)

Link to v1: https://lore.kernel.org/netdev/20260726071808.47781-1-baul.lee@xbow.com/

 net/x25/af_x25.c    |  4 ++--
 net/x25/x25_timer.c | 25 ++++++++++++++++---------
 2 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 8aae9273b..033e7d059 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -363,6 +363,7 @@ static void x25_destroy_timer(struct timer_list *t)
 	struct sock *sk = timer_container_of(sk, t, sk_timer);
 
 	x25_destroy_socket_from_timer(sk);
+	sock_put(sk);
 }
 
 /*
@@ -398,9 +399,8 @@ static void __x25_destroy_socket(struct sock *sk)
 
 	if (sk_has_allocations(sk)) {
 		/* Defer: outstanding buffers */
-		sk->sk_timer.expires  = jiffies + 10 * HZ;
 		sk->sk_timer.function = x25_destroy_timer;
-		add_timer(&sk->sk_timer);
+		sk_reset_timer(sk, &sk->sk_timer, jiffies + 10 * HZ);
 	} else {
 		/* drop last reference so sock_put will free */
 		__sock_put(sk);
diff --git a/net/x25/x25_timer.c b/net/x25/x25_timer.c
index 2ec63a1f4..7896cd43f 100644
--- a/net/x25/x25_timer.c
+++ b/net/x25/x25_timer.c
@@ -36,45 +36,45 @@ void x25_init_timers(struct sock *sk)
 
 void x25_start_heartbeat(struct sock *sk)
 {
-	mod_timer(&sk->sk_timer, jiffies + 5 * HZ);
+	sk_reset_timer(sk, &sk->sk_timer, jiffies + 5 * HZ);
 }
 
 void x25_stop_heartbeat(struct sock *sk)
 {
-	timer_delete(&sk->sk_timer);
+	sk_stop_timer(sk, &sk->sk_timer);
 }
 
 void x25_start_t2timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t2);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t2);
 }
 
 void x25_start_t21timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t21);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t21);
 }
 
 void x25_start_t22timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t22);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t22);
 }
 
 void x25_start_t23timer(struct sock *sk)
 {
 	struct x25_sock *x25 = x25_sk(sk);
 
-	mod_timer(&x25->timer, jiffies + x25->t23);
+	sk_reset_timer(sk, &x25->timer, jiffies + x25->t23);
 }
 
 void x25_stop_timer(struct sock *sk)
 {
-	timer_delete(&x25_sk(sk)->timer);
+	sk_stop_timer(sk, &x25_sk(sk)->timer);
 }
 
 unsigned long x25_display_timer(struct sock *sk)
@@ -108,7 +108,7 @@ static void x25_heartbeat_expiry(struct timer_list *t)
 			     sock_flag(sk, SOCK_DEAD))) {
 				bh_unlock_sock(sk);
 				x25_destroy_socket_from_timer(sk);
-				return;
+				goto out;
 			}
 			break;
 
@@ -120,8 +120,14 @@ static void x25_heartbeat_expiry(struct timer_list *t)
 			break;
 	}
 restart_heartbeat:
-	x25_start_heartbeat(sk);
+	/* Do not rearm once __x25_destroy_socket() has unlinked the socket:
+	 * it is past its cancel point and owns the teardown from there on.
+	 */
+	if (sk_hashed(sk))
+		x25_start_heartbeat(sk);
 	bh_unlock_sock(sk);
+out:
+	sock_put(sk);
 }
 
 /*
@@ -166,4 +172,5 @@ static void x25_timer_expiry(struct timer_list *t)
 	} else
 		x25_do_timer_expiry(sk);
 	bh_unlock_sock(sk);
+	sock_put(sk);
 }
-- 
2.53.0

