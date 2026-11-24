Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.37.255.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524960;
	b=a6cgsvLFfOfFmKQpnIBO6xX7963BtER7ceBzTmXk9UqH1fQ27DuOe8sQttuddslaCQKn
	 Mb4z2ALbyKpyXHpWLKUyBhN+UVhCgd1u3PtdHCY65amrMuEsJwlA8Lun1opODCRn5TBhR
	 eXjusYYUw9zivlb0D7MPyfYtwJmhAQwlLnNpgydJEQ3SdzWjjhr9ixP3iyNz3zoPV2JYt
	 pX3H766UAZ00Q2vm1lFbykYWSDDwfdcyMvWUmmelHlGN9AuQC/hAqkHHdHVTUVVkDqiwA
	 0kTiAPib1DipP4YTlCRfmnwB8tP1QT1ktVjkKPUgG5Mml/9mEYOiRzlTMbvf4++bCNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524960;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:
	 X-purgate-type:X-purgate-ID:X-purgate;
	bh=slugAct+d9okK4SVhnpunN3npmVqm8AIPnUV1JVa6F8=;
	b=eIOhYr1s5X7R/EeZYFeRpBEnebwa4V02wRiJ/h2TnZrIjfH4AQvXXi8QptxJbVn3C6wk
	 zM6BWaa1cMyRBE1VQVJpZO4E4Q5FJF/kTOClyOkcZTCeJryBwPGdHR/pAPdxlETbI2B14
	 t975bbuu+ibs3neDoNipIxn+Rxka1MzqF6/jKIr4bOEymPQ9tiHKO1+VpRF9Zc9b1KfIP
	 Vd8cxINEPBJUAuXBzIrPuj5PyZ3s26+QGDrreAaGR+yw0T6dnWs/QmqNgHJ5vom8vKByf
	 KSzSW1kjivD6B4ndZOYVx/CXif9e+UyRJjtjqMbZJskzNCfjGyFEJFPE3dqJOrGhdoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b="n50UEsy/";
	arc=none smtp.remote-ip=194.37.255.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C55606A31E;
	Tue, 24 Nov 2026 12:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48C55606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=n50UEsy/
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6802181f00=ms@dev.tdt.de>)
	id 1xVq3w-00FLUD-Nk; Tue, 24 Nov 2026 13:55:56 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVq3v-008LwX-9D; Tue, 24 Nov 2026 13:55:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795524954;
	bh=slugAct+d9okK4SVhnpunN3npmVqm8AIPnUV1JVa6F8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n50UEsy/cNEQKeTXohBifcZ5TKBQf0pmbS9nl/L6lNLgy2Gfh2R56qGiEHk84nb8t
	 X+gWk9dnMkscHXSDw8YnNRCaz5ulFdE5CwuB9Svpwbw8advP4Sbfw9FF2Vo07sbnhj
	 vsq/znndinH6KDI3AJz+X+mhVEb/uglIcHjAobiIIAQ7L286QcpVL2HnIgxWEHztYy
	 CtO0E3EGIg0/XbLFCD6vzenhASpCoLF/5wmqmGV5TTLa0qfnuABIm3wRNBWudYQ4Iz
	 t5hTvPjwE+HpRUBjToNFa0xlic7lNSrB0z/S8X1W7N4hFKUCkbgRMb0T5NLhJA8n3M
	 OHB2QGcw6O9+Q==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id B043B240041;
	Tue, 24 Nov 2026 13:55:54 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 9C3CE240036;
	Tue, 24 Nov 2026 13:55:54 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 72C1429D09;
	Tue, 24 Nov 2026 13:55:54 +0100 (CET)
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
Date: Tue, 24 Nov 2026 13:55:54 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, syzbot@kernel.org,
	syzkaller-bugs@googlegroups.com, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, duoming@zju.edu.cn,
	horms@kernel.org, linux-kernel@vger.kernel.org,
	syzbot@lists.linux.dev, ngocthang2710.1999@gmail.com
Subject: Re: [PATCH] net/x25: fix invalid lock_sock() usage in
 x25_kill_by_neigh()
Organization: TDT AG
In-Reply-To: <02419845-bab8-4e36-9a98-6830761da1b9@gmail.com>
References: <00f667e3-a158-4fb5-84a3-9ecda4718ce8@mail.kernel.org>
 <179551432467.3135.11868205229731190547@kernel.org>
 <02419845-bab8-4e36-9a98-6830761da1b9@gmail.com>
Message-ID: <14b34e044b3de00d871d49226ab0e00b@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1795524955-78D5BB36-D4B7661C/0/0
X-purgate: clean

Hi Krystian,

On Tue, 24 Nov 2026 13:31:55 +0100, Krystian Kaniewski wrote:
> x25_recvmsg() has the same kind of window, and the review did not
> report it.

Good catch, the code agrees: x25_disconnect() leaves x25->condition
alone, so x25_check_rbuf() can still send an RR through
x25_write_internal(). I'll cover x25_recvmsg() in the separate fix for
x25_sendmsg() and x25_output(), with your Reported-by.

> Could you also add the Reported-by and Closes tags for
> 300375dfd44665f063a6 to the series, so that syzbot closes this one too?

Yes, the v2 will carry the tags for both reports.

> I am happy to test the series with the syzbot reproducer once it is
> posted.

Thanks, that would be great. Thang can still send the v2 himself this
week; otherwise I'll post it. Either way, you'll be on Cc.

