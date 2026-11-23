Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430376;
	b=00wNdoRcVBUrpzss5dIR0bJ0DBFldIQ/w2n0LIMdAVUnb19JiqpoUTOdWfCaJ2CU9/dG
	 gtQ4NfvgmQdx3/rWmooTEAxtZbsDHRHZGkVHO/62LoRPdnHoCm8z6U/qq0C2E5i8lfeAd
	 OfKz3ZorLhV8wgPz8NjYfnLLHMPQ1R4uVuIizsboAH4p0cSxcoan3WXqbCjOPRWyTYDUd
	 4f4kk0OLT0H8tYTgStU9noj0S+aFDKtnCpZs7kYOAo3L5letzjC/X6Yp60WpybsY6a6d7
	 jK1ihH+HNv9eTe+HAeUPD3cqZV8O4Mcqzm2GLdAXMv+m0Lt2N0mWo5F2B4nXeRtZUTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430376;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=j/tG/UEzIieZgAJph/MrBCvQdKGyZRKklloUXvZ0UYA=;
	b=Gs87BowwKRc3XrAXhXU+wYqRm6ElhqL+TI6j0gRL76aMByh8ktYPcz4Mf+K+OEE6P26U
	 /4uYd9/PYz5Nu17BmrSl1Td0Px1dykqOBcpYTOYRFJ9o+e3IxofgQlvazXV+scMQ8GHdJ
	 1DvttnDS5CGyhaC8Q1zRasGxj4vSrDGykNJUln8X+jRR87LcViNuHHE9aLSd6LkiYQnF9
	 tFxuDctIdnDNM9pxnCAUmYBG46+SlXLkPW6mPok93eMA9jSFr4XoxHfG9gZ9KDeVvMXuu
	 4/qhWmcsxpoaKBduQwM91r5wsRD7i8FaoMb5jd+uSbwRpE/uhGcwq3I0dZobKae0fFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=njNAbrpq;
	arc=none smtp.remote-ip=162.62.57.252
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2896A606A31E;
	Mon, 23 Nov 2026 10:39:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2896A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=njNAbrpq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795430364; bh=j/tG/UEzIieZgAJph/MrBCvQdKGyZRKklloUXvZ0UYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=njNAbrpq4KIHGXNhQieMt9cicwl4OezNy2Bmc36lyj5fzU3Cg4cz/acF1SVRGCMQq
	 t8M7UEwq3HOZIe6ElZk3NEhSGxV/n3rfG1x4TBDcb8Fzx8Y2zcnKgLMdD1xA3QsKVU
	 cPbXs09tXynPTEqOM3Wtdk75/88eijM8oIM2Owgs=
Received: from shuai-VMware-Virtual-Platform.. ([117.158.156.199])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 9D68AA19; Mon, 23 Nov 2026 18:39:22 +0800
X-QQ-mid: xmsmtpt1795430362t9r4b51ec
Message-ID: <tencent_72DC05B1DB892BF77B6916964DF9A3263907@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25Gkdy/Sr2RyBrIzXg5agU7hEvfOAKWwVTxgOiHxpWaZtfr0UXLf1
	 XVeVwZ1hOlT1SZdJIAosyMolDr4AhWKlk4VDcSTcOCSWtt1ikXPong/lFGIgCTuytxQR68r0RdDn
	 U9OJ02z0uZkX1Q1eUL2LWxIhDgxvHRltDAG1VTW93KgB5iIqOa2UCGyJPO8nAjNhpxES/NnS6Emo
	 hV5sfxbOUoLbcxTnvWAWC0JLwCuMZ6WlGtT98m4xvVU97wo5XUWPSmDIKf3fdarsXCsmwlt2ZaND
	 /tuN10MHRwj3h0EK5pUFdvjj93JOyEN7wpuazmwcJlhjw965Q92O2T7IeUkvXg/E1HBcyBTYTjhB
	 fs9NGa/7Isig6FIyuUYtlRA6Z6Z/3L9NfSD68Lc5tP4WpA4tLFxzBWhoTWtPGOtdKF+hK9wYpC5Y
	 a19/HdMvFxOG+ZFB5xesocQ68vVA4HTE9PeH0B5xbZvEiDqoYOHW70VgSOng0i1nAeKcJQsLYc5E
	 YQmCFitEjByOOhGxwRjb6gEgx69sgP9wApMXBqtCP+gqq2H+5VKcSA7GkgWG/RI3kZqORZoDEEm7
	 80CCCV/uVm4xTXLHb1Pq46Eq1+sxu3H63XIR9o/pT4PVmZYri97wrHdil0HRdT7tZa9wUVAP2pek
	 kYDz/egJa+sp5Fw1egH4G+wxBjbemW3Z14mQxMvXG+kh0fmQME5DVc2pna+DGfEce3If0jigxMqv
	 fxPPY350VI8t8DSrPSfyaO2ZmEpQw8sHHpDjGLYaPSPKYVPpJ/lkgF6qRZSENNP85oInd3izkNo6
	 TQ/b9Wd6qPu4biI3jSOy+n3Nb33eOc5KSqtdW4CECIETgU0GJbjrhPWnEAaoANCXTw1f/gwP/gQY
	 cejNSc2sZ/3iPAQiZCafOnoSC1JVMG7ASEVvfGqlPrUqTrWjlyuGyitLont+4tlSKY1ylUxGgwTv
	 glaoobALT/zNR3FQqWdHu+O6kUFWeSPwwAP/57RFM2Jt3wWQpshbojcrWYLGq9kNWXmIook0DMti
	 fPA3Ecp4EDhvY7dgvtqWjyzC4wtCtk0Uf75Jknq3YQFxM5cgiZsewkj02VZZ2tSccOIWH2fZ6MYE
	 Qz4h6k
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Shuai Liu <847807867@qq.com>
To: netdev@vger.kernel.org
Cc: ms@dev.tdt.de,
	linux-x25@vger.kernel.org,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	847807867@qq.com
Subject: Re: [PATCH v3] x25: defer socket cleanup on link termination to process context
Date: Mon, 23 Nov 2026 18:39:22 +0800
X-OQ-MSGID: <20261123103922.1466829-1-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <mid:11>
References: <mid:11>
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

Hi Martin,

Thanks for the detailed test report - it settles the discussion. The
stalled-owner case is what I had missed: the deferred worker blocks in
lock_sock() until the owner releases the socket, so the window is as
long as the send buffer takes to fault in, not microseconds. My
"runs within microseconds" argument assumed nobody had the socket
locked, and the workqueue approach is the wrong tool here.

Please drop this patch. I will not send another version of it, and I'll
leave the fix to Thang's series.

The bh_lock_sock() pattern is clearly the better fit: clear immediately
when the socket is not owned, otherwise set X25_KILL_FLAG and disconnect
from release_cb, skip flagged sockets in __x25_find_socket() and in the
transmit path, and keep a sleeping sweep for NETDEV_DOWN, where the
device can be freed right after.

One thing that may be worth keeping in mind when you post it: in the
October thread sashiko pointed out that x25_make_new() copies the
parent's flags word (x25->flags = ox25->flags, af_x25.c:607) and only
clears X25_INTERRUPT_FLAG. If X25_KILL_FLAG lives in that word, a child
created while the parent is flagged inherits it, and the
__x25_find_socket() skip and the transmit block would then apply to the
child as well. The current posting may already handle this; I could not
tell from the thread.

I have the syzbot repro for this report (extid 300375dfd44665f063a6)
and a QEMU setup where it reproduces in under two minutes on current
mainline. If a Tested-by from that setup would be useful when you post
Thang's series, I'm happy to run it.

And noted, my mistake: new versions as a new thread with the version in
the patch subject, not as a reply to the previous posting.

Thanks,
Shuai

