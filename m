Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.37.255.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795457887;
	b=dUPhqbFGXBYPaJVUuTI4CvxhT5fkwkOILKDErd84V4sLdLOJxT/Sm+3XpTQVZ9fG16Nu
	 FoDlVEW5K3MznvdiVDq5c3/+Wy5G/bXQDvwbLOYkPDPAeuMLUc2oj6r4tuDiZqYV47O6C
	 HyA+nLQg0o0BcXd5JAVtSSIcKqLxg6Bg2Yb2MtPcBRhPaLkctlKW4CtSMbikafyXWVV/p
	 kTTTd8hJPysYdNDjIyGz7e8UwvopnCMeG/VDlTt3Dv1RIKhpki75Z3VGOSSZZRn/iW7cr
	 lsNVAWX00eECym/id0/NBLnsZIdhCUajSAI32cxtGJMaFiUVYaiTvTQEt4w/QIyQZTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795457887;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Received:Received:
	 Received:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:
	 From:To:Cc:Subject:Organization:In-Reply-To:References:Message-ID:
	 X-Sender:User-Agent:X-Spam-Status:X-Spam-Checker-Version:X-purgate-ID:
	 X-purgate-type:X-purgate;
	bh=sb2eexXkaePTkOjZScatsgbEjOUnIQ9erSIOfnFWnj4=;
	b=2rE7Y7pueRGglVCIljlNctK5YLW0H1fCodajck7X9Xay9jt+PqWov3HgybSodo7zhG01
	 kkt1ZNdk+vL4QYZXbtn48vykl9OmLqEFMz9FNjxu2ZA2Af0cds10LvsWr3wwHHnMoZYjz
	 UhMtRpKlEX8N1Idb6Sy2EUSgr2VUxge2JbIuxQfSpr1u08UDUFDJWOawmeb/elQbIh+uT
	 jtT24o/tMNrpWQYRcF0IYGz2L/Y+6iIoWCeojlNOdUR1VXeIj8rT2zo8wkGLuC6QyMRNY
	 HLXtWmsR4n3ejVdLr0xftm1miIKEUjvRdedOEZXVisdpEud8FJZIruBDxgJ7RBMHBDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dev.tdt.de;
	spf=pass smtp.mailfrom=dev.tdt.de;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=nX44UOb2;
	arc=none smtp.remote-ip=194.37.255.70
Received: from mxout70.expurgate.net (mxout70.expurgate.net [194.37.255.70])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA454606A6BC;
	Mon, 23 Nov 2026 18:18:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA454606A6BC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dev.tdt.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=dev.tdt.de header.i=@dev.tdt.de header.a=rsa-sha256 header.s=z1-selector1 header.b=nX44UOb2
Received: from [194.37.255.9] (helo=mxout.expurgate.net)
	by relay.expurgate.net with smtp (Exim 4.92)
	(envelope-from <prvs=68018334f9=ms@dev.tdt.de>)
	id 1xVYbt-00AONN-9e; Mon, 23 Nov 2026 19:17:49 +0100
Received: from [195.243.126.94] (helo=securemail.tdt.de)
	by relay.expurgate.net with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ms@dev.tdt.de>)
	id 1xVYbs-00HHgh-3G; Mon, 23 Nov 2026 19:17:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dev.tdt.de;
	s=z1-selector1; t=1795457867;
	bh=sb2eexXkaePTkOjZScatsgbEjOUnIQ9erSIOfnFWnj4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nX44UOb2cGgRFZnvs2cN2i7OqLCp9oqBHsDqkv4xfJwCHFb/qD1aMOxG+LiJ/NFLf
	 V1WRfTTvFXGtyJ1wqvay4GtvlFYus8KGWcT/IhS6paQuxogwtss4cLqw6ufYgbwHK0
	 X8JjOshBdjKB3BThokAEh/9u+ovFoTUgCmiRaFa3P4mkIZP/GDd2nwzyHif7S0pcVf
	 IZs+ycQnGHiI7mTYKxZSw4rSpdQ+OswVhARbx/xV6la46rBleP+rI6LjEjdEpzR1VL
	 gx2jhGkw7/+iPMbreZKZb8mf9QN9jG0RQw7fS2VuDV20o+ohxU1g531mTELAwusKVi
	 vFrR6QO394wcA==
Received: from securemail.tdt.de (localhost [127.0.0.1])
	by securemail.tdt.de (Postfix) with ESMTP id 54543240040;
	Mon, 23 Nov 2026 19:17:47 +0100 (CET)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
	by securemail.tdt.de (Postfix) with ESMTP id 4BF1C240036;
	Mon, 23 Nov 2026 19:17:47 +0100 (CET)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
	by mail.dev.tdt.de (Postfix) with ESMTP id DD6C32AE6F;
	Mon, 23 Nov 2026 19:17:46 +0100 (CET)
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
Date: Mon, 23 Nov 2026 19:17:46 +0100 (CET)
From: Martin Schiller <ms@dev.tdt.de>
To: benquike@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: lapb: fix uninitialized stack frame fields in
 lapb_decode()
Organization: TDT AG
In-Reply-To: <179018861262.2160803.7893822871484169869@kernel.org>
References: <20260919213639.3314894-1-benquike@gmail.com>
 <179018861262.2160803.7893822871484169869@kernel.org>
Message-ID: <4b13f8daeb814d4efbd04427debc1013@dev.tdt.de>
X-Sender: ms@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.17
X-purgate-ID: 151534::1795457868-7855AB36-53AC6A50/0/0
X-purgate-type: clean
X-purgate: clean

On Wed, 23 Sep 2026 20:36:52 +0200, netdev-bot wrote:
> - [Medium] The second justification in the commit message is factually
>   wrong.
> - [Medium] The patch bundles an orthogonal receive-path acceptance-policy
>   change into what is presented as an uninitialized-memory fix.

I agree with both points. frame->cr is really left uninitialized for
an unexpected address byte, and it is used by lapb_check_need_response()
and lapb_transmit_frmr(), so zeroing the frame is the right fix for
net. control[1], however, is always set in extended mode and never sent
in standard mode.

Hui, please send a v2 for net, as a new thread with [PATCH net v2] in
the subject, that only adds the memset() and describes this effect,
including how you found the issue. Please drop the Assisted-by: line;
checkpatch rejects it, and tool details can go below the "---" line.

Rejecting frames with an unexpected address byte is a separate
behavioural change: such frames are then dropped silently, and a peer
with a mismatching configuration can no longer bring the link up.
Discarding them matches ISO 7776, as the review notes, so I'm open to
that as a separate patch for net-next, with the consequence spelled out
in the commit message and ideally a lapb_dbg() message for the dropped
frame.
