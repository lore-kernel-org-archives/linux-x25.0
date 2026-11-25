Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598893;
	b=btG5I8TZrdw5pX55FgnpJjGKJg/RZr+UON+7P23RL1hagI//pYbhyebrqZtgmsZoHPZh
	 AyrokpEb3a/SL+/gT9ov8g+IwWvAvKOdcJWKfsLLME9p7nM+ycsAyiJvzgkrp6l2mfcqk
	 nOh7tyuMln48NeIx6Tt1352Z1hdf+LYqBA82Jdyxj0sAC/D86qcLNCa2r5MrsmI7tzCQN
	 x8Q51/kXmZXB83Yp5rQdYXz8/rmLD4tQ3UHWLOS4PYhgLBG0avQex/snE6/c7j1cclClp
	 oroMM2Y/hjj4xniUDVQZ7yAX0qi13rGM+wIqcgiCMzAP9L2sfELSsWm2Iln98rRG4Ig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598893;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate:
	 X-purgate-type:X-purgate-ID;
	bh=qlFwqH2sgs8M24fTGidv/K1nJcWyHs3H7/lqH7LE0JM=;
	b=47kx28DbBbIdLx3zw40Edms3d9qAUee46JKjOCagKHItKKOga8CzINYIecsAO7veYTC4
	 jXxGlURsxm2DAFsG8FV5xXT0VT/aXp5c720iqYp9feBAYj2u/ZEVqmwucx57mYQyuUDJM
	 xgGBwPJEu/920XNvoU7CuhkdKdSlqX6NEDXMv8nbFrxKxRgvcUlYtbvTD7wAUjl0s93jV
	 i/WxwKr/aviNIg+CTVpzQS3sqMRJ70uweZty1HSMORWRXO8ldg6MSP5HxOZpRhS6ovTZm
	 hvfRc6Cbi6c74zI1MykXXocSeeEZJy1NGTAo3ZwAJsh23LIhZ4wqZQDhju6+3BMIeJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=iZKnY+TU;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE5606A32A;
	Wed, 25 Nov 2026 09:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59FE5606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=iZKnY+TU
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6803393a3a=ms@dev.tdt.de>)
	id 1xW9IR-002BbH-75; Wed, 25 Nov 2026 10:28:11 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xW9IQ-008Gbh-Pi; Wed, 25 Nov 2026 10:28:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795598890;
	bh=qlFwqH2sgs8M24fTGidv/K1nJcWyHs3H7/lqH7LE0JM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iZKnY+TU7IObwYf9W1d/mOPEIUdR5vs3ku9vD6ZApk4uNFO5/zNIQkW+7ziO8p9jn
	 gfs3rm9gsM6EItPkaFkGq2hvNMwKlxZc0DuWe5o6/Re0eTrEb9Xl/TzmYLsPQTl63w
	 +4cirVphWuZHVI+DVfgVp4WtlsRKE4HtcG+8S2ekA9Pmi8XBLvbBjYcfl2k188PRgB
	 BpmGQID4D8xI2KBef5+K/uqKDTmyZsOyjFr9qi95WGgNGp7k1Qs4WG8ovQO2Vt0xra
	 f+MKfbw7nlUGSPT2Yruc+YwWQHxOPrWTIYu3g2/cUpvhNL7q3WyCCgC2tWbjMt4lLD
	 bmN6Hb8Cazovg==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 568A4240040;
	Wed, 25 Nov 2026 10:28:10 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4F1E9240036;
	Wed, 25 Nov 2026 10:28:10 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 31E5829D20;
	Wed, 25 Nov 2026 10:28:10 +0100 (CET)
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Nov 2026 10:28:10 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Yu Gao <SuperSkidder@qq.com>
Cc: netdev@vger.kernel.org, linux-x25@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Xie He <xie.he.0141@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	syzbot+059a2795ad4cff2a2695@syzkaller.appspotmail.com,
	syzbot+8328573e4d0514392471@syzkaller.appspotmail.com
Subject: Re: [PATCH net 2/2] net: lapbether: use lockless TX
Organization: TDT AG
In-Reply-To: <tencent_1010BAB1E5DD6485DC34EE706951175FEE08@qq.com>
References: <20261125045909.77644-1-SuperSkidder@qq.com>
 <tencent_1010BAB1E5DD6485DC34EE706951175FEE08@qq.com>
Message-ID: <718297b4a3b97e2366be3b660dc6cacc@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-type: clean
X-purgate-ID: 151534::1795598891-FC91671F-DCB1AAC6/0/0

Acked-by: Martin Schiller <ms@dev.tdt.de>
