Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582767;
	b=hZGYf+BI79kdWstAoZ24yz1aF5Rf4SF3ysfNW3HTgh2IFFXY57z0qTvd9R2gzE0lIfsP
	 lwdDWaOEw/FWtxRL0uQYvqeRa6ufhtEGUdql5ENUHot4+6xrsLYCZ3SlBzOhoBfPVPomt
	 1KXmZwaZANDS4In/x0lMHiGNnvmqjFxyXNMN1xkazLL6QLYZv4CEv6T9xfy20jLkyJXBa
	 MtGH4QA4bvmSpZO1/UpvJS59BUJdwMr3BauYxQuJGuuapcixoOLNeaynxGW7n4FqRQVBy
	 /7KTgGU9P5Engc9dGZ85333weiV/8Uc3/iPQCUuMG0yYovFCbUTmLSO+xyZJcZc8uNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582767;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Sender:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=scdt/jXoN0rwoAHFE7jO6UMzulljKoowhDAjAi8tutA=;
	b=o8w5uHMcW7AcXKpq5dKmybHgd8EIYeh4edEf2qgIbc1xfJ4PwOux3+4Glt90z/nRXIPp
	 OhyfXrb8rzDNt8CfMyF1DI9ufkA5nNfbjcHWz4cHkMDwly9Pzioi+OnJORndmE03uIRku
	 AL3bJPFvK74B+CIiCDWVUiLHlp99d0XYFBb2Hm60SmyoxYGDqFTy6c7m3eWspISeJGoIt
	 aoPlb5NmWbh8vcZeqi/SBGRFjKQI5lIxd4Uij1ntdc0fLFW16pljnFMpOnAA8j0IXM24t
	 0eDWB2z3QCtP833WjnKmSEWcTC2WNWCyMKG3dBGMXrF74XhElpVnKFD4jRiBt/wEnKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PRHrw3aY;
	arc=none smtp.remote-ip=43.163.128.50
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.50])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD2E606A31E;
	Wed, 25 Nov 2026 04:59:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD2E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=PRHrw3aY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795582762; bh=scdt/jXoN0rwoAHFE7jO6UMzulljKoowhDAjAi8tutA=;
	h=From:To:Cc:Subject:Date;
	b=PRHrw3aY9O2Op+SvXvdp8vhpHpCrYzf8iYM90+vItUoZhQdCXLgsv3WXy5OlFh/B8
	 SOqRD/qmBGYGWQsLwq4b01prsBFHn8+uNcmTRomaWORi+WazkkkViNICcRPiTEcDnM
	 NevuE1YoEMpgRPMMP6x6Gat7qRBRpeCdKyy96PvQ=
Received: from localhost.localdomain ([240e:360:b507:6a00:cdc3:f6f1:3f3d:301])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id ECD3BE27; Wed, 25 Nov 2026 12:59:13 +0800
X-QQ-mid: xmsmtpt1795582753tdaq4p244
Message-ID: <tencent_AD34C10B65771ADD86725F3221EE31778507@qq.com>
X-QQ-XMAILINFO: MCbI8wyd6mEf8qkO9vNREiUQpc79jS45nfRQOH32Ky+LqJBnnPGayp99ycuHIx
	 SLy9iDkzp8Ia+AW4AGqawNi91k1cJxJtoZuyo6pbgPsxCVo9nKS19fwddR9kWu2nKprqqaxxut3d
	 zEhcassNDeHeVVBFbJeaLZYyNtmL7bkmDat68WLhxwfNwjxljnCzJv9s1K/jonLQhL1LSGysk+D1
	 TcfNfsmMhDDpZ8fUuS5YwGKpTsLWabtEBaqaNIMjiDkYW6tqAXicEjagkPOKltDq0PIUTAmbLfcs
	 mIuXliecKNsKkb6dmRegnk0xoABs7YgExSWHkYZwS8YxUGiVsYFJ4wmTaqKPWvb5ZJ8Ne7ZNIWrm
	 POY2dJmOiYcXZOwQMxs8BJxnlGFRTnVaPV8rkZtm+ErMAucbWNGIpB6LcI4gaiS84XBAZ7YApzlf
	 oXl1keaMHqYwUGiWsOnPkh1yOGCaThxFfkCAvddY1wQMgjsa/jM3vETteG5JoSBh99hdY8kmNbJw
	 q//eNsF6q9s9pqoH6SHYH3WmfkifzhAtAiaPBiBv/QZ0lPAbDCniRBKW7IqlbnnGx11EgwJWDFxj
	 9jM3ME5d1L0fV0bA++i5iFuTUM4N8Qidf3ItoSHcA/SUUGDNYOhp/FpPMUICn4O3DTRTusIuWxQv
	 sRB4o98agTYd5FYTCCTOozc408joPB/6++sF6WgcrUTdan2VtTSu7YcwrZYsMFmY7E3diO01/iws
	 AfNC3UzseoQkpzUmZ1XahBSSr/5Gy5a6e4ZMQqrU+pfsiNPSy/ufyQYk9byGjgUST1pXIeilcsEm
	 pWRvs7FS/HMAhqajaKoj1tSCk31cNrdbvRU5b7nRcPuC+9DlT8Fw7gqd6p14ysViGtKr2WhSGS1t
	 zLfyC+2xfdHXghihH1PtGXZCymCf4g7zHOWVgzBnB3zhgqeZOIPWB4+z7Ghq8HXEA+8kDhLZXifd
	 LRQAornohaQyL+ahBp/Qa1MPChMUKPewEkTOH66746oJ3fB+oimxFHa8zF7/JtXRS3Uf/1ShXXoQ
	 FPABndOuf5TPz5r+Azv4iagkShvHrFe5OmR2kgj86F7kcGyST4YuwpCITnAjozah8xu43xlcz5eJ
	 hgFzxiXeSYOFIa8rT6ka58NS8WLXWoa5n4ppx77mD0jWF//udv7BAgfbWJF76ZcWWPRhIXy8FJLo
	 oMLSCbAesgQIPlMYHTGX83MjdebcAstJzIc+09eXUvi+CV5g==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
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
Subject: [PATCH net 0/2] net: lapbether: fix lock cycles reported by syzbot
Date: Wed, 25 Nov 2026 12:59:07 +0800
X-OQ-MSGID: <20261125045909.77644-1-SuperSkidder@qq.com>
X-Mailer: git-send-email 2.54.0
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

LAPB transmits frames through lapbeth_data_transmit() with lapb->lock
held, and lapb_unregister() takes lapb->lock with lapb_list_lock held
for writing. When the Ethernet device under a lapbeth device is a
tunnel (gretap or vxlan in the syzbot reproducers) whose packets are
routed through a lapbeth device, a frame sent by LAPB comes back into
lapbeth_xmit(), which runs under the TX lock of that device and takes
up_lock before calling into LAPB. LAPB then takes lapb_list_lock to
look up the device, which closes a cycle. lapbeth_rcv() also calls into
LAPB with up_lock held.

Patch 1 stops holding up_lock across calls into LAPB and removes it.
Closing the device now clears "up" and waits for lapbeth_xmit() and
lapbeth_rcv() with synchronize_net() before lapb_unregister(). This
fixes the lapb_data_received report.

Patch 2 makes lapbeth an LLTX device, so that the core no longer takes
the TX lock around lapbeth_xmit(). With patch 1 alone, the
lapb_connect_request reproducer still reports a cycle through
_xmit_X25. Patch 2 removes it.

Testing was done on QEMU with the syzbot config, with lockdep and
KASAN enabled:

- On an unpatched kernel, both C reproducers report a cycle within 15
  seconds. With both patches, neither reports anything in runs of 400
  and 600 seconds each.
- A functional test runs one lapbeth device over a veth pair, with the
  other end driven as a LAPB DCE from user space. It covers link setup
  and teardown from either side, about 100 frames from the peer and 370
  frames to the peer through lapbeth_xmit(), and closing the device
  mid-transfer. All frames arrive in order, and the output is identical
  with and without the series.
- 300 up/down cycles of a lapbeth device while frames are sent in both
  directions produce no warnings.
- A lapbeth device on a gretap tunnel whose remote address is routed
  back through the same lapbeth device: on an unpatched kernel, a SABM
  received through the tunnel deadlocks on up_lock when the UA comes
  back into lapbeth_xmit(). With the series, the looped IP packet is
  dropped, in three out of three runs. With an MPLS route instead
  (first byte 0x00), the T1 timer path deadlocks on lapb->lock with and
  without the series.

No end-to-end test with X.25 sockets was done.

Yu Gao (2):
  net: lapbether: don't hold up_lock while calling into LAPB
  net: lapbether: use lockless TX

 drivers/net/wan/lapbether.c | 42 ++++++++++++++++---------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

-- 
2.54.0 (Apple Git-157)

