Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452248;
	b=szYsGarJrQ3O2QwZ5hQP/72a78hGcVBvIJm8x9kvrV9khVPX8FcaRUXvfKI/4JndVPQw
	 7pBwhzeZDIolD+yLpFjMiHEmp1ce6Y8WWB/xTBJyu/RZDa87cDyetg2F/lLQUlMPSVuTX
	 8evK+Sm1zidJJHDD4tXirlHddYtnUXCvF7nwoMfBo/I2haHlA/mznHhkxzCH1WQl8a8V/
	 YkXCjho7OjB/VKvLazIcvQlqHYZwTHPfW09mDI6oyKHK5KXA3hW3l2DdH83TLkdycKiwb
	 jTo0YbF7hP/l5MeyXJgQH+KML5WwKx77QJL0MK8sV9QEXZImBy02HYfH6p5/mZ7C1/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452248;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:
	 X-purgate-type:X-purgate-ID:X-purgate;
	bh=+j8NlTDkaSolKJC2T/OgIC4R3UPkUPvo0idclAridzw=;
	b=jZXaBHdptvKePGgFyHCKx7tsLPwvuThWS871Za40506dOX+FIBxFWfVL50mKvfocF3O4
	 PRIi5EH7sbJpeO7O5Nv+rhgeQbjxOlospTKAr6K1Y8//Yl5Gb233pwyoTGqt73xtOBKaS
	 /OIilQONsVVNXEpw/GCoVU1T07+brpyibS8ZaFOVY/A+eddj8EagX8U+zz3q5D8tB/lXn
	 u4SBCLwSnpf3UiU1CKlvgUkBtN3xUWhIoI92o1yvdU6cjm7Lin2ewB6gTzqW7zkOxCa7H
	 4jpWvS+QWxjLR2R1xeUKtXeqIcRnaGAbAm4Il9Y2XcgogQBR8v0DZLSNI/Zpac917EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=Y4klHzNh;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC70606A31A;
	Mon, 23 Nov 2026 16:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FC70606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=Y4klHzNh
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68018334f9=ms@dev.tdt.de>)
	id 1xVX9C-00GtH9-2r; Mon, 23 Nov 2026 17:44:06 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVX9B-002tZ2-Ix; Mon, 23 Nov 2026 17:44:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795452245;
	bh=+j8NlTDkaSolKJC2T/OgIC4R3UPkUPvo0idclAridzw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y4klHzNhRpNdJtjtlMPEEhin3Zm4SRR/9BU/KQ8b07eaLwlT2b5T7Jb79KXl3RNrT
	 lqQFNPbbJOoCI3ZW29fke261imKo+P5PYfcSM5Kl4ImAzcFOswVZAhnPaPCwHPjw2v
	 HrXpKH6dyS9/dSthjbLw0f+NJo0wwFUMGRkOudOtn3qaVvv09dWgtSLIJAZK6th1ut
	 MIo8JF7vOUHuiw9oytM889tcfBbw98f4PntmWPrIy+oao/lj51plBUz+FgpArjoFDK
	 +7pOMLhvmllnoCmWWaqfS2i6S7NL9F0qN6M0MxvzWxlPdSOIpibE4afyiNpK8AcQ7F
	 vjUjNW7YiK2Ew==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 0CD5D240041;
	Mon, 23 Nov 2026 17:44:05 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id E789E240036;
	Mon, 23 Nov 2026 17:44:04 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 905C920059;
	Mon, 23 Nov 2026 17:44:04 +0100 (CET)
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
Date: Mon, 23 Nov 2026 17:44:04 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: shyckless@gmail.com
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org, linux-x25@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	paul@paul-moore.com, stevewong@hust.edu.cn, kaixuan.li@ntu.edu.sg
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
Organization: TDT AG
In-Reply-To: <20261123-x25-v1-1-4432d3892f8b@gmail.com>
References: <20261123-x25-v1-1-4432d3892f8b@gmail.com>
Message-ID: <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-type: clean
X-purgate-ID: 151534::1795452246-CD763E18-5E6CCF35/0/0
X-purgate: clean

On Mon, 23 Nov 2026 01:31:20 +0100, Suyuan Wang wrote:
> x25_make_new() creates the socket that accept() returns by copying
> fields from the listening socket, but it never clones the listening
> socket's LSM security state -- there is no security_sk_clone(osk, sk).

Thanks!

Acked-by: Martin Schiller <ms@dev.tdt.de>
