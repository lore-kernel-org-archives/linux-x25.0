Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582790;
	b=rPi9Edk9kYot8dR42Oe3OXb66rlryLl4vH+/c3h8Sppdeea02E0gwrR9kb9mTNfiEM4T
	 Ed51Af0qsNVKAvfUWUtvHoNXQB6RGr+rTa6NWgf6q4Z4mggnMkbGlPLiTnBUOGY0J4C19
	 D9D2m+uJbKxH54MilZWCk7Ywk9Q4WBgn/VYjtNC68tK5Pk4u/YBOxm1/Q8pQ1Ivbmev0i
	 S2z2KOsh2bjJSY35EuSPD1t0tcRneoOHwLoG3F11GjsK/ZU5UCqSFRa5x8KB2xBb4tlXO
	 3GeMN7UqYy780CxHZ+3TrUgOe1rrA6q2fF7uezBJaTL5R0DxodN/wYIeBtbB/ZfnIZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582790;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Sender:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y7hMmAkvX9J5Ts9LNfrAigsFzopoqW4RntRQ7UkLy6c=;
	b=Utp0gNu02lr3PfCvcwKbILjqpBvwTKl/g7xZCcOl73J6KJidifyOtWDMLdr9Lo/uCE+d
	 xXPM3pEt9jAIId3/t9huiU/7Zjdfd+VrqvZZect8CNxBv55VLIPS9xsReYwDaqUsxgLxf
	 AOc7dCVcw4RRaHvdqlt1x0Plvaf4useIOZP+u7hUaLfrlqLeA/bSKqEwk2URTvNJadnxd
	 G+s9DCMa1GBV9ZeowQiKaCq2romWAnDEQTUCAZ/2dwDBGyDcWm53+XHgFbLL3zmc/0Sfs
	 NQlSapP67bBUCMP/FJ+B4eWAfs3rS2hHnefK5UZ2PSNqF/UAy7E1bc+B6cNNW46+uMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=w0+zaYVm;
	arc=none smtp.remote-ip=43.163.128.49
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA51B606A31E;
	Wed, 25 Nov 2026 04:59:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA51B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=w0+zaYVm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795582787; bh=y7hMmAkvX9J5Ts9LNfrAigsFzopoqW4RntRQ7UkLy6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=w0+zaYVm1lmVe8eyL80tPQAfLLXLBj8CO3G4v9vZMduZsusFSOlblpcHhpg0Etzty
	 rPkrXl2kmD/CWFsZ1ozV4I7jVp2Ld6RsCeNxORtrB5J5rv6majX6i/NXEd5rbdYKgk
	 Re+8smUSXK0Nel9ibBk6KxNMOn3qTVdmPZ+ETzrk=
Received: from localhost.localdomain ([240e:360:b507:6a00:cdc3:f6f1:3f3d:301])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id ECD3BE27; Wed, 25 Nov 2026 12:59:13 +0800
X-QQ-mid: xmsmtpt1795582782t9bdqru2h
Message-ID: <tencent_1010BAB1E5DD6485DC34EE706951175FEE08@qq.com>
X-QQ-XMAILINFO: M+J86KchSb6F2NBrI5betZ6pKPXskkfCgfy5303+VudZ45AU+fDLdGzJCqRm4l
	 /KcuYVdBSu5lqKV2nmyUeqmMki2Ev38owRczCt0X9DD6C8iojraIpRKtRnrMCwlqmyVRN1UcMgK8
	 JjzQU96b6tuB+bMUwRY5USuOorkz4F4C6dLhQFBslHCzC6n5Q7xH3C+yrKc3Yg2MtiI0IRXWX5/w
	 QfDpOds8d9Mq80PVXIubUvv89xnf0zrIXJDePa3oBEi/KdsCqxwVJw+AEXWDKNB5BfYbYVdP/8KK
	 XN+ntjgMq/lqWTTdMqBWXKAHn3G4JV5mPNw5A1XMhrgC6uqFI+1i5ob/m5QB+QJHDxTVN9kJwCkp
	 S4DnEPMWchUV1NFFDG1cW0CV/kvu+6Kcgut7PlAnb0KmqEH+BYvyjI9P5Tk0Fr+4KtZeIcdfoXv7
	 YncTsKNJ5g2WOrN4HxSwD2FCkFuzL2VlCT3gwgfs2wx9obiRHe26AD4tRya7nL3OWUBP7IwfDI+t
	 MypL1yeK7xJaqWJfTBTGZ1DEVviajwjQ6gdgmYg4xlYdIihuvUAdrdJ8NU/entC4922jYQiWAy1d
	 RWA/ReyR20yaAqC+lL47F11W6WvEpnWxAUL+qZM5weNi4pFfeQvi4ySO6E2fr7GRARty7YSp+BNw
	 rXZcG0PdsVN1lFOH1tkGB3MKzkb35Gok0w9wxp9/u3UVKpV8OqN3Cp0CiNazNJZyBPnINdxjKeeC
	 qJjHlGJpDpxQMAzAm4LwwEJDT32VFG4GIsHlEWtBQQqZs2miKrDtC9o22j3Zbuaqtfp4djVRjwxT
	 oMSeCdJK/ZwwOO3eZDlduVvYwoOjvpKiy69TiitWHRKKPIe0WfcbM97d9mHmel6SCvhMVEkmh6/u
	 JL463nW4E8q5WO+CPLsyaHsInLQ3WGIz2TTrg68abD+eKTZJHtEFFUxhzbmu38d1sWTjdP5BN1Th
	 0B4tVvonLxmrW2aliGzKqxrCKO2z4WadLsCWdKsMFhjhAaV7nsmF5zbWQbyYu21V4ClogApNwwEW
	 TD7qtDyHD7pA69MUy6+PGlDZgCNKSmcSJqGI/a2yV/odAdEYqZaeRYoqD7xKUKjqWQQ0A488GL8g
	 stmCCJjLZRqcbusyYhDaWSqG1Bin16YwZyNNPkfsrMw6uOrNxHjgithrqZDpGztDffUHJDFhPmi2
	 eBw+LV4q0myD5GSOBQvuTbPj3SGz3IbB+2amnEfBvElIN+ykogX5Larn/bqCvJuzB2t8o=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
Sender: superskidder@qq.com
From: Yu Gao <SuperSkidder@qq.com>
To: Martin Schiller <ms@dev.tdt.de>,
	netdev@vger.kernel.org
Cc: linux-x25@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xie He <xie.he.0141@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	syzbot+059a2795ad4cff2a2695@syzkaller.appspotmail.com,
	syzbot+8328573e4d0514392471@syzkaller.appspotmail.com,
	Yu Gao <SuperSkidder@qq.com>
Subject: [PATCH net 2/2] net: lapbether: use lockless TX
Date: Wed, 25 Nov 2026 12:59:09 +0800
X-OQ-MSGID: <20261125045909.77644-3-SuperSkidder@qq.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125045909.77644-1-SuperSkidder@qq.com>
References: <20261125045909.77644-1-SuperSkidder@qq.com>
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

The core calls lapbeth_xmit() with the TX lock of the lapbeth device
held, and lapbeth_xmit() calls into LAPB, which looks up the device
under lapb_list_lock. lapb_unregister() takes lapb->lock with
lapb_list_lock held for writing, and LAPB transmits frames with
lapb->lock held. When the Ethernet device under a lapbeth device is a
tunnel whose packets are routed through a lapbeth device, such a frame
is passed to dev_queue_xmit() on that device, which takes its TX lock
under lapb->lock. With up_lock gone, the syzbot reproducer for a
possible deadlock in lapb_connect_request() still reports this cycle:

  lapb_list_lock --> &lapb->lock --> _xmit_X25#2

lapbeth_xmit() does not need the TX lock. Data frames are handed to
LAPB, which serializes each device with lapb->lock, and connect and
disconnect notifications are queued on the locked rx_queue. Set lltx
so that the core does not take the TX lock around lapbeth_xmit().

Without the TX lock, the core no longer detects a frame that loops
back into the same lapbeth device on the TX path. If such a frame
reaches LAPB, it now deadlocks on lapb->lock, as it already does when
LAPB sends it from a timer or from the receive path. Only frames that
start with 0x00, 0x01 or 0x02 reach LAPB, so a frame looped back
through IPv4 or IPv6 routing is simply dropped.

Fixes: b491e6a7391e ("net: lapb: Add locking to the lapb module")
Reported-by: syzbot+8328573e4d0514392471@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8328573e4d0514392471
Signed-off-by: Yu Gao <SuperSkidder@qq.com>
---
 drivers/net/wan/lapbether.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index b4dde9b..c7496c7 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -364,6 +364,11 @@ static void lapbeth_setup(struct net_device *dev)
 	dev->hard_header_len = 0;
 	dev->mtu             = 1000;
 	dev->addr_len        = 0;
+	/* LAPB serializes transmission under its own lock and may transmit
+	 * through another lapbeth device while holding it, so the TX lock
+	 * must not be taken around lapbeth_xmit().
+	 */
+	dev->lltx            = true;
 }
 
 /*	Setup a new device.
-- 
2.54.0 (Apple Git-157)

