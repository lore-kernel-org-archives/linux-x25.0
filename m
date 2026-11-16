Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794789287;
	b=ezyEuRVFMzXf7mU0amKOQl+hZyT0m9ntwhf406aYRtL9C0zmvkxNJQ8XvCGAXsvvIdIP
	 d0FtmDcVXRUC78fMVZCX/gJNbfezXK8xkBOknPDegp9UDaLLnWaqjjxW7tq8GV3R0QDJ2
	 eGMypSOZUlQAzWskxozuHxTSjJ7ofZiOuHfw3xuJX3ida/zx4TLsR2QCK3r2PmMFwCjS+
	 MDqHcIntz9LgH2hoWF8dZLdPH6Ciu73D7rzAj7eu2o4epM9WKXbzO5PGgNFfslCyXBPu9
	 jQmaeYzXkoxtB5hEKgrGN2VcpvVbJ6R1qawb4ISWmZRE2O5u7xArgaYEpZPIem6PT+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794789287;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aTcJ6BGq+uGBRIpdVXeWfbkOmZQ+zlmmC71Argp1h/4=;
	b=lyt9GtaAiDipDO89+weQgouO67Onpddn6bVusk3OVv8qQhImxxnQ3lvKGuLpk2rH2qxh
	 cQMDDYEshhrzACMjUiRIIozgqbAKHzUVO9xzSM2Snz+PkzOv+UBJGtWaphlSqlUhlBac5
	 +O6BBhnExQxg6zKvfFps+TaWIOP/FNZBiy6omI/omTIH780TC/YUwO7VsmpKLc/b7vofY
	 ZKe9fTO1mpZtPhsrVxZ6YZScc+RNTRpoo0xlnNuONzWmKuTSDFUg8haqUIun0wS2psj24
	 jx23kHCDxlOAVpMDTBJdyT5w8jY0h9knQVQPiAPRN/UmQo2UAdpXVSSTPaQ7+875kTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RsHCkO8+;
	arc=none smtp.remote-ip=162.62.57.64
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BD606A31F;
	Mon, 16 Nov 2026 00:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 490BD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=RsHCkO8+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794789279; bh=aTcJ6BGq+uGBRIpdVXeWfbkOmZQ+zlmmC71Argp1h/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RsHCkO8+2lxmdKbDtD080xHIGsnFbYAicOV1cD7X+t62EvjUBzoufhSwFNaBr1FaD
	 f2ogTcxxSdqma/smYCFQrobmaA3RhCr0fo0JYp6SjM/nCdsE20i8xG2fRdcCUyHxU1
	 W26qydVYbFtDGo4NGoNhMlcnZoQD8FZlfHxHl9V4=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 8A427430; Mon, 16 Nov 2026 08:34:36 +0800
X-QQ-mid: xmsmtpt1794789276tyxiqpen2
Message-ID: <tencent_F7C2DC0FA42B5866E5C39A9E70D3C52C2609@qq.com>
X-QQ-XMAILINFO: NUaRPsENHoCKH0tB3KqJdR18HkKzy0d5mKWWfq9kSeWXuj1++6RYjZaOcxHLLA
	 6qNhkKln8w/HhLNThhu+Xw81j1EuMVXg1j0nQrYK2Be+VOmjrdJr1cLj+JAEFG3s/ugNZf4UZXCp
	 jS23lMqvezmSXgyRwidfoUDn28NEDozsDiDEWKrvr8lA0rgSN084DowQDOb+McZIatGIL8jjBeTc
	 1dlwcptWnlm8xWl09B/DzC9z2YwmLyYUGYxKhurIj+1WuyuJLqzXYq1xZ1bp4IGUADsHaO0XqJIg
	 VDM+n+oCeNcfl4RV35Mr8164Mlym4yVahCWFUe1irCar8n12B6EFckjlM2VtIkz5EOnc0ndPpkGa
	 lXx5U0SrDGbZb2bpH7cwdGvLBOuJeecjl5R9GhbExB2cboT2bR+PfFP+sLcfcSxQZmNpbjcN8v1c
	 f/qAgpPb4qbnWDxbNoDdLJzRaFOIv+K63ia9yusXYJMwkIlysMFBVB53Hv+a2VUM1DV7UFfV2cB9
	 xNJ9mJJx3m/yMtDkWa2nYXRRJnWbFWSMqimen12PyUB8F73jh+u9Wg5XbYI2zktw/6Jl3XwtDqL9
	 CzgwU09jYcGJfhCGwJVwUgZgHnQ41I8DBoWhoBTKVrIvGSzAfx8sWqeKe/LLIURwPaymVMrzk4FL
	 yhj04P7qUV7legmeaw80bmBm8ZHtDFqgpWMdgP84z2wGYoTMNyGvn1wo/VZvlLghdKIphREGIvy2
	 KeMvdANWNVKBj7HxsfCQIF5XcEoN1o4GxvUTdZabZYA/1LML8kS85u70CagzS2OnxcOI78veAee9
	 Fiod5jIiYrc4mXdhkELdjLgyLV8FXtP2tBF55QQpdRYJhGTaWIN0uELxe8nhbsgeu+hTIWqyPesU
	 C3jWkciv/ye/Ag8weeaCwLMuwJFXPFq93tLDRKex1b0/N7ZZDadb4N9SQLj5VTO+iDlsViPtlNId
	 IlKr//odsYL7ueVeAR3dB3qzb9TbZffMW2ibSIcYroElpwm5ZTL4S+F+2hlXh3UKiPp/lyxCl9Vw
	 uTklvD++8pTUq3jmuKNWKqC+O2EZeIk0kJjjaHiBoU8onOTjH3l1a+Bj6Bz9maxzUQZJqEBg==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
From: Shuai Liu <847807867@qq.com>
To: ms@dev.tdt.de,
	linux-x25@vger.kernel.org
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org,
	847807867@qq.com
Subject: [PATCH] x25: defer socket cleanup on link termination to process context
Date: Mon, 16 Nov 2026 08:34:16 +0800
X-OQ-MSGID: <20261116003416.747357-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6acad256.a150a118.27e199.0030.GAE@google.com>
References: <6acad256.a150a118.27e199.0030.GAE@google.com>
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x25_kill_by_neigh() walks all sockets bound to a neighbour and calls
lock_sock() and x25_disconnect() on each one.  It is invoked from
x25_link_terminated() and x25_link_control(), which both run in softirq
context when the LAPB link goes down or a restart frame arrives, e.g.
from the lapbether NAPI poll path.

lock_sock() takes a mutex in its slow path, so calling it from softirq
sleeps in atomic context:

  BUG: sleeping function called from invalid context at net/core/sock.c:3839
    in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 14, name: ksoftirqd/0
    ...
    lock_sock_nested+0x66/0x70
    x25_kill_by_neigh+0x90/0x110
    x25_link_terminated+0x18/0x50
    x25_lapb_receive_frame+0x1c2/0x1f0

and lockdep flags the sk_lock-AF_X25 usage violation because the same
lock is registered in process context by x25_bind():

  WARNING: inconsistent lock state
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
    ksoftirqd/0/14 [HC0[0]:SC1[1]:HE1:SE0] takes:
    ...
    x25_kill_by_neigh+0x90/0x110
    x25_link_terminated+0x18/0x50
    x25_lapb_receive_frame+0x1c2/0x1f0

Defer the neighbour socket cleanup to a per-neighbour work item so it
always runs in process context.  The work holds a reference on the
neighbour so the deferred cleanup cannot race with neighbour teardown.
x25_kill_by_neigh() is idempotent, so repeated scheduling is harmless.

Reported-by: syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6
Signed-off-by: Shuai Liu <847807867@qq.com>
---
 include/net/x25.h  |  2 ++
 net/x25/x25_link.c | 18 +++++++++++++++---
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/net/x25.h b/include/net/x25.h
index 414f3fd993454..cb51be81351b8 100644
--- a/include/net/x25.h
+++ b/include/net/x25.h
@@ -13,6 +13,7 @@
 #include <linux/x25.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/workqueue.h>
 #include <net/sock.h>
 
 #define	X25_ADDR_LEN			16
@@ -143,6 +144,7 @@ struct x25_neigh {
 	struct sk_buff_head	queue;
 	unsigned long		t20;
 	struct timer_list	t20timer;
+	struct work_struct	kill_work;
 	unsigned long		global_facil_mask;
 	refcount_t		refcnt;
 };
diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index d1e8cd81c2143..150ccd78cba64 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -58,6 +58,14 @@ static inline void x25_stop_t20timer(struct x25_neigh *nb)
 	timer_delete(&nb->t20timer);
 }
 
+static void x25_kill_by_neigh_work(struct work_struct *work)
+{
+	struct x25_neigh *nb = container_of(work, struct x25_neigh, kill_work);
+
+	x25_kill_by_neigh(nb);
+	x25_neigh_put(nb);
+}
+
 /*
  *	This handles all restart and diagnostic frames.
  */
@@ -82,7 +90,8 @@ void x25_link_control(struct sk_buff *skb, struct x25_neigh *nb,
 			break;
 		case X25_LINK_STATE_3:
 			/* clear existing virtual calls */
-			x25_kill_by_neigh(nb);
+			x25_neigh_hold(nb);
+			schedule_work(&nb->kill_work);
 
 			x25_transmit_restart_confirmation(nb);
 			break;
@@ -97,7 +106,8 @@ void x25_link_control(struct sk_buff *skb, struct x25_neigh *nb,
 			break;
 		case X25_LINK_STATE_3:
 			/* clear existing virtual calls */
-			x25_kill_by_neigh(nb);
+			x25_neigh_hold(nb);
+			schedule_work(&nb->kill_work);
 
 			x25_transmit_restart_request(nb);
 			nb->state = X25_LINK_STATE_2;
@@ -254,7 +264,8 @@ void x25_link_terminated(struct x25_neigh *nb)
 	x25_stop_t20timer(nb);
 
 	/* Out of order: clear existing virtual calls (X.25 03/93 4.6.3) */
-	x25_kill_by_neigh(nb);
+	x25_neigh_hold(nb);
+	schedule_work(&nb->kill_work);
 }
 
 /*
@@ -269,6 +280,7 @@ void x25_link_device_up(struct net_device *dev)
 
 	skb_queue_head_init(&nb->queue);
 	timer_setup(&nb->t20timer, x25_t20timer_expiry, 0);
+	INIT_WORK(&nb->kill_work, x25_kill_by_neigh_work);
 
 	dev_hold(dev);
 	nb->dev      = dev;
-- 
2.43.0

