Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.198.224.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795506947;
	b=YDCyD2uJQzAhiHnQSCUqpSvMr7BMSlKRiDUIWV0c5PREouY37CYSzy61M+hkIr7WrceQ
	 TTxwC7v9laijPrbXOc0Xpzithu6NGB6RE3c2aE/QATtQFuHAMryL7Di/xRVgynnpEMQX9
	 KTya3P03b9UV0joBlnlIl12G/u9pOvUy9jN2x9cKxH1xGy2/pybechZswnF4Ya7AasZKS
	 mqoJjh0cm6hBR4RKtgq/JqU+4aArHeEEmcMKMkpt7B9Eho1X4RJNuZzmVP7klTwFcPsNJ
	 SZi4EAO/3gZNAfOWAsx8u++KnfGbRz5e0QvgKjF6vEOUXj/pFgfZTHsqe8DyhyZTGAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795506947;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate-ID:
	 X-purgate:X-purgate-type;
	bh=HXQmUKwNTzWkAjfW6xDycCgr6LCHVATUPkPJy+Ngb+E=;
	b=4IqHrfpyHvFIe8TsYcuKx9YZC/XPNkEBM1A5P4eiTl8kNm4oeb1G+C7yezzW8EWiP4wx
	 hRHlJnUPHBRhMoFM+NWLTCi9G0owekDAg6PFVWuXHpdFsOau7+9/TZxhmTKc36OUeus+W
	 4l9mIW/Ya09c+z1em63O7qF4tAVzHI4tpjmlXcl9MNL7ZEkaR0TsG2OsKFGNxn5odMIlN
	 S91Sj273DBjGllXAJzD/AKoehMOSUgdAoR5VaZ45805wSrhfolJBrok5h+5QImnXqLM+5
	 TB1nXmppK4k8g+8weMoLVwFlq42Zk9uvn7mX48PO52nPSL5mBQjaJdl9hAbuhYoTZew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=gz6xY+Nc;
	arc=none smtp.remote-ip=91.198.224.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [91.198.224.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12447606A321;
	Tue, 24 Nov 2026 07:55:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12447606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=gz6xY+Nc
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6802181f00=ms@dev.tdt.de>)
	id 1xVlNJ-00DE1u-2U; Tue, 24 Nov 2026 08:55:37 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVlNH-00G06g-Mm; Tue, 24 Nov 2026 08:55:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795506934;
	bh=HXQmUKwNTzWkAjfW6xDycCgr6LCHVATUPkPJy+Ngb+E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gz6xY+Nc4vWg4eUJeAB8o5FgvArlqImsILkbSypdR7gt4XIb1cfL/s2ct0fbkdB5/
	 k3JjlH49LBXWSCzmgWR3uyOpTaKzoEwAytO8GkkSqkud9FwI74AHP6b3pt2BYrXLOI
	 pQxgUK7IVARxGP7T5a9DfF0zonzFjW63Ay8V6WCXGpJ3NBkXZaE6OYItkYv9pLIGeE
	 6iArQV7+hIrA2WhJwOGBkVfVoGXnTJ104juIGUItA5xE0PcrrNLRYF4fT6/Wl7MRqm
	 h26Hvh1NVqOhXiBpFLRnSP9S1UksmGb1PtpH3GTEqFRgvbw60xFCxavYQCfvMbgRDP
	 U8KmW3xHmRbyw==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id DE9E6240040;
	Tue, 24 Nov 2026 08:55:34 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id D3799240036;
	Tue, 24 Nov 2026 08:55:34 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 4B6CF20059;
	Tue, 24 Nov 2026 08:55:34 +0100 (CET)
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
Date: Tue, 24 Nov 2026 08:55:34 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: Felix Hoffmann <f3lix.dev@gmx.de>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: x25: shut down T20 timer before freeing
 neighbour
Organization: TDT AG
In-Reply-To: <20260731173955.1601698-1-f3lix.dev@gmx.de>
References: <20260731173955.1601698-1-f3lix.dev@gmx.de>
Message-ID: <0752bfa788132d988fd1d3028b9d2d89@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1795506936-D8CF571F-2C8530E9/0/0
X-purgate: clean
X-purgate-type: clean

On Fri, 31 Jul 2026, Felix Hoffmann wrote:
> Shut the timer down synchronously in __x25_remove_neigh() before
> dropping the list-owned reference.

The fix is right. The AI review of an unrelated patch has just found
the same use-after-free again [1].

The placement question from Simon's review doesn't matter for the
current callers, which only pass neighbours that are on the list, but
moving the two calls inside the if (nb->node.next) block would match
the comment. As the patch is marked "Changes Requested", it needs a v2
with that change, as a new thread with [PATCH net v2]. Unless you'd
like to send it yourself, I'll post it in a few days, with you as the
author. If you do send it, feel free to add my

Acked-by: Martin Schiller <ms@dev.tdt.de>

The dangling nb->dev the review mentions is a separate issue, which
I'll look into separately.

[1] https://lore.kernel.org/all/179549218277.3135.9518512691383315581@kernel.org/
