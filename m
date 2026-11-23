Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795405704;
	b=DSSSK2sedPjS53d60SOUMGjxTl9iA8R2tKPfxQAlCCViDMrWVrp603QGNXXBFYobFQIc
	 GSrdQXJjGvo8X57S771mTfA/u5WUUfOxv/iEeBRp2wJ90EZtdRR04NxmYI0+PPgGamae8
	 9UgUlIPZdtRyM8K8Ky38YG7K9oRk8x7ft6ZSMU/NYUuEDre5SMjDpTEQqarJOlJIfYW6E
	 dTcey0HPXv9NwV8Jh+W32honz4DQduABZHUr9/hcvD2mZKItTyfxoULKIvzKeqPam31nI
	 G6AXhFVeB4qznxiyGhVDuclYRXAPwZ97EOVJ4P3WEfCjKULmquClIUS7/WprBratQig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795405704;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YNmHaqmtwbx/EzQOm04VaagFwsQ5IZpEuhdBjG4NZLA=;
	b=ZN8BqRnKX57BXQBWbR2h4PVMOqVzTDiTW8bcGkUMhJrP3VX2+F2X8Nuipv8fq/uYXSTG
	 Tefkw8RhdudHqrfG0rEZID2Ga6PTmKtiuNNgpzwZPbT+3Gr58cHdiwuZSZRol2cVrob+L
	 VVc0UoJXNuC1o62/zlXOOcv+ZOYk6CQKGsqa5/Qv6n4LgZj6cLhFlserRIXqs9TXRQMNd
	 XnS0XyUnlPFHb2JK8qcXmCKl6SiUEUOxpNg7ukPcdfqQnhAl8axwkz9NEKLBShAam5PKC
	 6AVVe5pOvu1IuZHcRIkDLMgy75jkeJvkVXrljYqRnULo9uvAmJb5MjFbYXizl61hBKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=AVzpacww;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68714606A31E;
	Mon, 23 Nov 2026 03:48:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68714606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=AVzpacww
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795405692; bh=YNmHaqmtwbx/EzQOm04VaagFwsQ5IZpEuhdBjG4NZLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AVzpacwwzg44/gz8/MhNrnij/3TmhDkqRv90iaJYnqtLZ8ePhxx2GC4EvJMzgOlCI
	 MSGc347bdxhdacwFIbhl87N4qD36btIFU5gLmPTDbtdQ2XjXGtwRcU8i7L+sjHEKYp
	 hr51/6CPkg+v2tH9J6WA2SzLvisrwG6cILfR1qQk=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id C0AA0A27; Mon, 23 Nov 2026 11:48:10 +0800
X-QQ-mid: xmsmtpt1795405690tniae0z6g
Message-ID: <tencent_0B3A9605591EA70906F7462C6282CD7D4305@qq.com>
X-QQ-XMAILINFO: MA2CfewR0F23ME4Gg7w33qWAEdTs2lFyGItXk+FMPsVR0J1umXSbDUBausOrO0
	 3vHnxXhov851SX9zF0FZGncogjvBkirGAtcHsFKQcUkPN/SoicShS/pqs7/pvH3BuVzd2ZSL4y0d
	 jlPw5uml0Oq8wXSZTYtkiQigoCC0irUzbynCfA8gVjeHrUqTriu2j2jq7NoIoKwl1juO346bYVvS
	 LgGJY3c5qPSRzvjK59G40H7LcSgZCCG/SZNp6xNdqKoQptfPy/DhkkZT7p8MK4bGRSDRQ7tpwPwB
	 mjGD9fSJ/J+T9svcJsCPaupDXR2yaRZRNnYyvJur2cMPADjcSw5y1TIs0KeN1YlaFoN9Rm2QJeIo
	 BAOaoOY2EVOwSdB+Or9ZlxaScKx50kzr47UjNsQU9IxNXQ02WHgsbIVnhg+IWI1ccoVDJVlTw9eG
	 qgdAElqUcWVey1nY7BxasoMWh+SZW81sBPYuJsvP7v4YXupOTgwsfuO6ykT1cPGJrJ7QYIzikp76
	 BF6fkMgWlmuHg5lyuo3pq3QeaNMAOZ6xBJ/U0c/yk9D8accemMKDQQD7dtNN0fwujAIiwA54J3ik
	 i7DLq/k/fiNtnmoyPAHj4+Ec3erI3prmGUGAjZ75DkFkxIYoW9smHmcb5nNsx7KsCmwMILkLy4nW
	 GfsZFAtkP/GHJkLkj6JUEoBtr9pFkZM1AF3LrcGY+eB227hpNgYgEx+Ap1MdG+nMuWiCUJ57vydH
	 HK0L7YgDETwjmBxqyGw3T2RVr1Ehfaz+PXQsMpAYCS2VbjeQmyGaD5Dw9Js16wE/jeu/PvEVNuYZ
	 asHCzxt480c9FnQaSZkDjMFp+GEqDbZyo77uz73mK97gybSW9Zc9P/q6k5MGDJZaCecyY90u88Q5
	 17WHySV71jGwvdqi7/2YUeT3Pr3KpzDPzk6JofuEDAq7gmupGlVLtI0qTk2Xy8M7r1KMSjkS3e26
	 iERCv4HlnoFEJkOQUHU145pFB8Xpl3lTuKFoIAVsrNCMGBhqDOLTtxvMGkzlCg9nWxQAhO5z8cSB
	 vuOW4d2LwCX4b/x+DbT8UtbNj9dhju3mQgr4NxEAHADfO4LZgF2PseNv08691gk3eajysFLXejjm
	 s6OnOM9wL7A4gFtbOocUjDhm/+5fvM5FoeDnGFFoKvwS9F6okeSJ/KuPgStLuD+PakpabB
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shuai Liu <847807867@qq.com>
To: netdev@vger.kernel.org
Cc: ms@dev.tdt.de,
	linux-x25@vger.kernel.org,
	netdev-bot+sashiko@kernel.org,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	847807867@qq.com
Subject: [PATCH v3] x25: defer socket cleanup on link termination to process context
Date: Mon, 23 Nov 2026 11:48:10 +0800
X-OQ-MSGID: <20261123034810.1269365-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179539800759.3135.17245752044060918891@kernel.org>
References: <179539800759.3135.17245752044060918891@kernel.org>
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

Hi Sashiko, Martin,

Thanks for the review.

On the [Low] (NETDEV_CHANGE flush): fixed in v3. The carrier-loss path
now flushes kill_work right after x25_link_terminated(), so both
process-context notifier events (NETDEV_DOWN and NETDEV_CHANGE) keep
the fully synchronous socket cleanup they had before the patch.

On the [Medium] (restart sequence vs stale virtual calls): I looked at
each scenario and believe the remaining window is not actionable, so I
kept the softirq deferral:

1. "A reused LCI is matched by a stale socket" cannot happen in the
   x25_link_terminated() path: that path is entered when LAPB reports
   the link down (X25_IFACE_DISCONNECT), and any further peer frame
   (including a CALL_REQUEST on a reused LCI) requires LAPB to be
   re-established first, i.e. a SABM/UA exchange at least one RTT away.
   The deferred work runs within microseconds of the event, long before
   the peer can deliver any new frame.

2. In the x25_link_control() restart paths the link is still up, so
   frames that were already in flight when the restart was processed can
   land in the window. That is precisely the out-of-order case the
   existing "Out of order: clear existing virtual calls (X.25 03/93
   4.6.3)" comment acknowledges: those in-flight frames belong to calls
   that must be cleared anyway. The workqueue item runs microseconds
   after the restart handling, so a peer would have to send a new
   CALL_REQUEST before it has even seen the restart complete for it to
   matter.

3. Detaching the sockets synchronously in softirq would require writing
   x25->neighbour / lci / state from BH without lock_sock(); those
   fields are lock_sock-protected, so that trades a microseconds-wide
   theoretical window for a real data race. Splitting the sleeping part
   out has the same problem.

4. "Valid new calls torn down by the deferred worker": incoming calls
   need the LAPB link up (point 1), and an outgoing call would need
   userspace connect() to land inside the same microseconds window.

pw-bot: cr

Changes since v2:
  - Flush kill_work in NETDEV_CHANGE as well, restoring synchronous
    socket cleanup for both process-context notifier events (Sashiko)

v3: https://lore.kernel.org/netdev/20261123034748.1269213-1-847807867@qq.com/

