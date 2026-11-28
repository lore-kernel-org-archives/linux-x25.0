Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.37.255.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795845149;
	b=4cwhBAhrEuzyy+WA2SQPQLYryUYzoFf8/z6hT6cNJHYxiFRCNaIwFr+220SPhk56mOrP
	 OxQGT2DUsgLq0yGrqVlTOLLg3NTz7vsLzJYIKpm4P+9BfVczobKNWRgGK/E8h/0GL/XSn
	 Hy6MI0TD3iJo2VoU5FFFAUKskw6qDeAJEuKMpc4EpclIRyJKuiY41f94vqkGOt7xHw/aO
	 ldbdKl6im63zhGEpgKqim3jU/Nfwf7XFcz/Bg0d5+7m3tf+HH2n5ZDFDDzxP3WjznPfUC
	 Q6yUONfaTIkaFtoy9jEYfqwu6TbKhKWO3enhA6Eq2Cg/O70FkiqEdLBZd2mrrdR/FAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795845149;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate:
	 X-purgate-ID:X-purgate-type;
	bh=znvjBjLFYwzq+8PsQDB3a1sIrQ+WiVM6SE0SCET5shc=;
	b=LNdWhT/BWSRyCsggS8EDjh7V68svNoFDXR2at1BzKhW9vm85ancYXVmZC6V0Lkdmq/CC
	 y+bAtjKTOQovHjc6J4u03IXRFO3fwccNNPfhoWSqebmYMEFbL4RazIivR+qXDCEsIBYyb
	 Q3G5HtbLzIlsHsLki7Mgw172IKQ1wom72/TPV1DxQoTB8LSpqXujrCLQzXU12TfpuDu7S
	 aK4AwSeeSaEUKylAH1QSdXpBxZadS2SEwtEiezdgmYxKWiEPDNEblZtZHAQ6bR+d6zbxe
	 m9XC71rCPMeSKayDVKkw1Eg/uzxJjDm7doOYpTGwmaN85Myhsr8HC0V69Rjwck2xzLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=kI2UH5KT;
	arc=none smtp.remote-ip=194.37.255.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AF8606A31C;
	Sat, 28 Nov 2026 05:52:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11AF8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=kI2UH5KT
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68062c6ca6=ms@dev.tdt.de>)
	id 1xXBMH-00200P-3Z; Sat, 28 Nov 2026 06:52:25 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xXBMF-001bYh-IV; Sat, 28 Nov 2026 06:52:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795845142;
	bh=znvjBjLFYwzq+8PsQDB3a1sIrQ+WiVM6SE0SCET5shc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kI2UH5KTzR2HApuxaCK+UmmGwMxPyT9cIKhSuBXwvCejjBxaw9mfm+crGkPK33RBc
	 XzuuR8JNzuUvAYJPd4SZEN1Hw5b+wOCDvNSiNs95XOhbC4KMso5Pd/ovcyQTu5TJlF
	 eWpoxvWTjE8KWf8MQGWwcGljJDalaLeJ9XKntfyiklRHS4Ngq5QrnvCoTto3qvmUJ4
	 4m9n/0j9NyO8PCtOpR9rw4uGjHw6wbPXqa+SmxiDP4ePgM487ke2irx3oWIN+6YeXG
	 zo+cfL+S7Y6EotqK+kSLe1Sifsq6eDH4enm4bwNCgmp36tGwCA6LCs9Um8IzpuJzes
	 rfplgQ42ONAJw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id DAC14240041;
	Sat, 28 Nov 2026 06:52:22 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id BC27C240036;
	Sat, 28 Nov 2026 06:52:22 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 74D9525F74;
	Sat, 28 Nov 2026 06:52:22 +0100 (CET)
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
Date: Sat, 28 Nov 2026 06:52:22 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>, Lin Ma <linma@zju.edu.cn>,
	Duoming Zhou <duoming@zju.edu.cn>,
	Xiyu Yang <xiyuyang19@fudan.edu.cn>, Xin Tan <tanxin.ctf@gmail.com>,
	linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
	Shuai Liu <847807867@qq.com>,
	syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
	syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net/x25: don't call lock_sock() from softirq
 in x25_kill_by_neigh()
Organization: TDT AG
In-Reply-To: <5ad2c46b-4ed9-4689-950f-93753fa1586e@gmail.com>
References: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
 <5ad2c46b-4ed9-4689-950f-93753fa1586e@gmail.com>
Message-ID: <ef81cfa72a9f35249165b042e645cb88@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate: clean
X-purgate-ID: 151534::1795845144-91996B36-A46D2B35/0/0
X-purgate-type: clean

On Fri, 27 Nov 2026 14:30:05 +0100, Krystian Kaniewski wrote:
> Without patch 2 all three end in a NULL pointer dereference
> (trimmed):

Thanks a lot for testing, and for holding the window open. That makes
patch 2 a triggered bug as well, which supersedes what I wrote to the
netdev bot about it being theoretical. If the series needs a v3, I'll
add the symptoms to the commit message.

> I can send the test program if it helps.

Yes, please, that would be useful for regression testing.

Thanks also to Shuai for testing and reviewing.
