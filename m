Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.37.255.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795598881;
	b=Fk97ZwAlQvTipQ/LXlEQHctvXNZe6nGBNPbocr4iqDyWELFiKBq6MarBnYAXTl4WG5TI
	 lG4bFI8eMEQd/rO4mFxo/cqkDBcuZDxTw9wONrN189LrsfBbjFimQUDwtQgfNExXjw+42
	 xwwX+W1Rb34KKInBGCw2SEkHb+CHfVOgfhao2j/s3E5s0DBzu6dlWyKnluGr2nG2F3dkS
	 3VIsSgyJbN1csmXSE+ehV/n1ax8uttGSMb+/9vDJqhK41GJyEPGL68MpVdhM2BVuSI8UW
	 C+I+/jeWMouEZrtffnGehpP3mQC5gBeLxFEa8PLZQz4HImKnfeN65t1vXwnvhDiFVSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795598881;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate-ID:
	 X-purgate:X-purgate-type;
	bh=maG+ssYUFbVrGsr8p7Zk+VAC48SBPsjeb8y+qRk3j8k=;
	b=ng4K7y7mwTfwpPbonZIu4cvLxx6NHAIa5P/9r5Z/pwdfHkvv5RoQVAFv4n6IocIiXwqE
	 KwXwjTS9tgLxMqKEkaGLFCv9iyRCsNEu3uTidz48zVXW6wRLhKyYJqlLuvFpcBNLBHh1o
	 pdHOkqoC3NJh8SMMXFsy5l6hloZ/HVQId41LPJEuG2df7loSXOFZAySwvSquYJe+XSrC1
	 HScu02t6lLTc4FdpVWRyuUBD2+DKWmIojoXk/KjMTQCijmVVbugKplgje7EW+PMlc8nOv
	 as3EZl2fPVvR9OBDzAO9Xq58x0g8SzbC8sz1uQexfarR5EBK5RzWSjVtnneMuS+LTTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=PwFXVKmQ;
	arc=none smtp.remote-ip=194.37.255.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4FD606A321;
	Wed, 25 Nov 2026 09:28:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C4FD606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=PwFXVKmQ
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=6803393a3a=ms@dev.tdt.de>)
	id 1xW9I8-004rQb-MJ; Wed, 25 Nov 2026 10:27:52 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xW9I8-0033Ny-8I; Wed, 25 Nov 2026 10:27:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795598871;
	bh=maG+ssYUFbVrGsr8p7Zk+VAC48SBPsjeb8y+qRk3j8k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PwFXVKmQl83XpJbkfUMhKlXpnoFmqtvlN014hNkUcaLfLlY3RH9/LY6/G5cpmqlVA
	 ztwXsJwucQ3fPkzscCyHg9AhuvRStVGbXYleAF/1qdOgcqi6O7HjL4qbpa+QOcn4ts
	 ed6KODdvAtFX9RKOY01MXivbT4Wh7fJiG9vWRyf6OtXKlaj/QnPstlhcT9rgQ6DUaT
	 O5XIN6xVbOuNaOlLOx0ympkiTqoFt24/UrMnHBAaAvvPM9y0mEh7oAKsU2OswNX+Es
	 o6GMPRofBQUS9EX31Vwodv//MfmQ43gc3yUySNGDB/BIIRFZw6M9ccK0z+4DXO8UCc
	 Ng+G/1xmXo28Q==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id ABF13240041;
	Wed, 25 Nov 2026 10:27:51 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 977C5240036;
	Wed, 25 Nov 2026 10:27:51 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id 3C23329D20;
	Wed, 25 Nov 2026 10:27:51 +0100 (CET)
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
Date: Wed, 25 Nov 2026 10:27:51 +0100 (CET)
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
Subject: Re: [PATCH net 1/2] net: lapbether: don't hold up_lock while
 calling into LAPB
Organization: TDT AG
In-Reply-To: <tencent_81EE31BA79E5206415DCD8EE76690A171D08@qq.com>
References: <20261125045909.77644-1-SuperSkidder@qq.com>
 <tencent_81EE31BA79E5206415DCD8EE76690A171D08@qq.com>
Message-ID: <a68d70362e0db1de4c1243fb7bca1ef2@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1795598872-6ECB512C-C32C0398/0/0
X-purgate: clean
X-purgate-type: clean

The cover letter and the patches are not threaded together: the mail
server seems to have replaced the Message-IDs, so both patches point
to a cover letter ID that doesn't exist. My ack on the cover letter
therefore doesn't reach the patches, so here it is per patch.

Acked-by: Martin Schiller <ms@dev.tdt.de>
