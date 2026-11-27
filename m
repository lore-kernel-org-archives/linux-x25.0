Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795760902;
	b=nOe42rtYvpCJODOu+/p1sELhLpzzxnJSsD79ktxtLX5fauflVUSQeL+ANKXTOB/8GfjV
	 WCWNzMqiGk+6MwflLXygemJqzFRF749Gi+FQRYQuQrR9RPS6qjghoz7QUDgc8TLKepYgS
	 87c0CVjiwUrXOjjcnBKKo0avCKT/d9/9Veh95QyPF3fAkraa6HmJDCgUgPa6Og+XtM8OH
	 EmNtVSx2Bzi54dwWYr3LQkWC+i87cMIrrERjC6agpaeZiPAJictJit6KM3AY1BBj+TYWQ
	 7aZgH5kSR1Fn1ryvCosJqTBF2UH1HBN5qtKRhdon+RRpyE0wsgHiVrAicaX9UymhiNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795760902;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:From:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Spam-Status:
	 X-Spam-Checker-Version:X-purgate:X-purgate-type:X-purgate-ID;
	bh=hR1lIsDu53XucOC121gNhnBmLUv3K3O3Iqrvd3qun8s=;
	b=er7lZn/UForWTjPsV/IprsAVk6CevzvyAjrBjPdksuuYDfhyYemMlrpfGBC3mGgTRZaj
	 TfWzNEazixx8kO7r8GawLoiZY13A++/rQm1N/WYHJOCcIsh6285FFqGZHBOF2xtgTq4Xx
	 PiBv0ow1c4rzr4xNcmA1C3gdZ+0xJHYDmvmVqJk2fhk470qWnMbcD43wr9NrPsNd7ukgt
	 Mf/6C7b9qPSPufpQISMxBcORlMDLn99QzM0Qm/4bPJTmVTY2Q1dIrwbiWNL/HEd4S3gtE
	 QBqZSJ2flwNMA2BmYs08rAyCOscQc+b6nwkdyk9wg/sDuAljY3SnqzQwqCNEmfqMeGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=hA6TvG8h;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD34606A31E;
	Fri, 27 Nov 2026 06:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9DD34606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=hA6TvG8h
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68051b93b8=ms@dev.tdt.de>)
	id 1xWpRN-00179s-52; Fri, 27 Nov 2026 07:28:13 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xWpRL-0022Is-OQ; Fri, 27 Nov 2026 07:28:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795760891;
	bh=hR1lIsDu53XucOC121gNhnBmLUv3K3O3Iqrvd3qun8s=;
	h=From:Subject:Date:To:Cc:From;
	b=hA6TvG8hKDtK3jlOWRY+1Xyg3jUZ9ybwwFok/qPvaLDwViug/nqONaT0acecizxa3
	 iFowpupaWDxZQSfCujBH0maKClcw9Nu/Q8P8VqonEtO5BEQSAF303P5we8utJ+8BeF
	 e6gyixOk1TcmKmP1XpvJeXoKOq7tb1j9+f1i1ru6+kEJErGdHKVUoYGp90On+7vZum
	 e5BcXSHWzVR9AWTsm6XBdYrJYNUzN0bs4ZqQZvDuOdNw7q9qpwvUJS/PoNJRDIU/2+
	 fdjPnxJUN6nIJk976ME/rUj/iLA3mjU9NuHzL4UXJaF0S4nRa66wTQniZ3WBNYQ6eT
	 bNAB9WHVySUHA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 130D1240041;
	Fri, 27 Nov 2026 07:28:11 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E81DC240036;
	Fri, 27 Nov 2026 07:28:10 +0100 (CET)
Received: from [127.0.1.1] (unknown [10.2.3.19])
	by mail.dev.tdt.de (Postfix) with ESMTPSA id 8A5952B0F1;
	Fri, 27 Nov 2026 07:28:10 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net v2 0/2] net/x25: don't call lock_sock() from softirq in
 x25_kill_by_neigh()
Date: Fri, 27 Nov 2026 07:28:04 +0100 (CET)
Message-ID: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
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
X-B4-Tracking: v=1; b=H4sIAPQiCWsC/x3MQQ5AMBBA0avIrE2iEypcRSzQKRNS0opUxN01l
 m/x/wOBvXCANnvA8yVBdpdAeQbTMriZUUwyUEFaKSoxUoWrbBuONzqWeUEa68Jqo5pGK0jd4dl
 K/J8dOD6hf98PsSd7tWgAAAA=
X-Change-ID: 20261124-x25-kill-by-neigh-2b70f6d19961
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795760890; l=3787;
 i=ms@dev.tdt.de; s=20260220; h=from:subject:message-id;
 bh=v6SgoFrkv+b0LfnHHS4QhUnFOc6lzK1a631nmYR85VA=;
 b=Om0fG895OE7/xfLbdIK0ZCpQ+X8q6rVyWrj7DEiaxuq8Yjqm8nbAKVOUGYHg8TrXbfvK0VGmo
 Fga67G/AEP5BUna6gO22ffGVjK81SQrThs2EYj/X+1MagGpGQMiT9Fw
X-Developer-Key: i=ms@dev.tdt.de; a=ed25519;
 pk=MAojd7D5IafMnqCYSFC7hY/u/jppX58CLIEhsEsSOYE=
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1795760892-5AC14D96-E86CBE01/0/0

x25_kill_by_neigh() takes lock_sock() on all sockets of a neighbour,
but it also runs in softirq context when the link layer reports a
disconnect or the peer restarts the link. syzbot hits this on mainline,
net, net-next and the LTS trees. A plain "ip link set lapb0 down" with a
connected peer is enough: LAPB sends a DISC, and the peer clears its
calls from softirq.

Patch 1 is v2 of Nguyen Ngoc Thang's fix [1]. Sockets that are not
owned are cleared right away under the socket spinlock, owned sockets
are flagged and cleared from a new release_cb, and NETDEV_DOWN still
waits for owners. v2 addresses the AI review of v1 [2]: a flagged
socket no longer matches incoming frames and no longer transmits, so a
new call on its LCI after a restart reaches the listener, and child
sockets do not inherit the flag.

Patch 2 fixes a pre-existing NULL pointer dereference in x25_sendmsg(),
x25_output() and x25_recvmsg() after they retake the socket lock. The
same review pointed out the first two, Krystian Kaniewski found the
x25_recvmsg() case. It is independent of patch 1.

Deferring the whole cleanup to a workqueue [3][4] also avoids the
splat, but the restart is then confirmed while the old calls are still
bound to their LCIs. [5] had the same design as v1. Both have been
withdrawn in favour of this series.

Tested in QEMU (single CPU) with lockdep and DEBUG_ATOMIC_SLEEP, using
two lapbether devices on a veth pair. A sender stalled in x25_sendmsg()
via userfaultfd keeps the calling socket owned during the link event:

                                       unpatched  v1    v2    wq [4]
  1  link loss, calls idle             splat      ok    ok    ok
  2  link loss, caller owned           -          FAIL  ok    FAIL
  3  restart, caller owned, then a
     CALL REQUEST on the caller's LCI  -          FAIL  ok    FAIL
  4  ip link set lapb0 down            splat      ok    ok    ok

In test 2, the old call brings the link back up (SABM) before it is
cleared. In test 3, the new call does not reach the listener, and the
old call sends a DATA packet on the reused LCI.

Tests 2 and 3 were not run unpatched, as that kernel would sleep in
softirq. v1 was also tested by Thang with the PREEMPT_RT config and the
C reproducer of [6]; the changes in v2 add no locking.

Changes in v2:
- skip flagged sockets in __x25_find_socket()
- no transmission from flagged sockets in x25_kick() and
  x25_write_internal()
- clear the flag in x25_make_new()
- add the current syzbot report
- new patch 2

The changes on top of v1, patch 2 and the tests were prepared with the
help of an AI assistant (Claude, Anthropic).

[1] https://lore.kernel.org/all/20261001150118.128470-1-ngocthang2710.1999@gmail.com/
[2] https://lore.kernel.org/all/179121364205.434549.10310203820251738113@kernel.org/
[3] https://lore.kernel.org/all/tencent_F7C2DC0FA42B5866E5C39A9E70D3C52C2609@qq.com/
[4] https://lore.kernel.org/all/tencent_8BA4FF587EE5579AB67149C5062618DC7109@qq.com/
[5] https://lore.kernel.org/all/00f667e3-a158-4fb5-84a3-9ecda4718ce8@mail.kernel.org/
[6] https://lore.kernel.org/all/6aa7e6d0.4c28b7d0.c1bba.001c.GAE@google.com/

---
Martin Schiller (1):
      net/x25: re-check x25->neighbour after re-acquiring the socket lock

Nguyen Ngoc Thang (1):
      net/x25: don't call lock_sock() from softirq in x25_kill_by_neigh()

 include/net/x25.h  |  1 +
 net/x25/af_x25.c   | 76 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 net/x25/x25_out.c  |  9 ++++++-
 net/x25/x25_subr.c |  4 +++
 4 files changed, 82 insertions(+), 8 deletions(-)
---
base-commit: c5de2ce2fccdb7d3b48946179634eaa3d7ce2e7e
change-id: 20261124-x25-kill-by-neigh-2b70f6d19961

Best regards,
-- 
Martin Schiller <ms@dev.tdt.de>

