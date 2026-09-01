Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E9138239E;
	Tue,  1 Sep 2026 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788272617; cv=none; b=aYQr3Mr0Wab/83EVU4Rm6JP5qDhQpI9gV6W3i3xSqQBQmCOdkbSaFzn14wr7kPCzlb2zGjLuPmI5JTuwiDJAfeQX4xYZgU1kjiGzuPcpAIWcbHW1IvbmSqPvLDWAxxm/el+c/X9M8PbbmZRakxmXwvlot0EAZ3dDl5/2CA8Ykjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788272617; c=relaxed/simple;
	bh=Rg72aytZzFtwBlOk0JnbBlNjb2wcsDeAtbCHQT/dP8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rIp39M+mg5wOOGM3YNBOVIk7gbEFoQdc0Uwav9/CD8/wLkQBGmKYik0SqXN72cSkIyUiFCawrRswIGeIz8r9UsDWBDGscm1NJXRI6XV49XYwwOHUWT2S9cH8eyVJOehkNlllqFdOeCNVmUEMHsp8HPV3Wz/ObM7MhcgYCkDm320=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3Gnz0bPH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3Gnz0bPH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nfvQgCmqwjs8O3izl1rYlY9sATRncSgn1VeiBuQXUII=; b=3Gnz0bPHaJpR9L+8LDAMPBoDds
	Lg7ksGoYNlvc5Wnd+tm5lxFgoLa7g2c+YDxBUrB/GnbL0M0krz98mUuOgRdSp9P7H5i3RUB/lQQOo
	sdyH/HXAV3dTE/bFJtSJSWOA7rYwBKmctN25ERCufEVtwKkV9SNJz6VGTrF0WiwzFpsg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x1POV-002Mto-EN; Tue, 01 Sep 2026 16:23:23 +0200
Date: Tue, 1 Sep 2026 16:23:23 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: luckdog <luckd0g@163.com>
Cc: horms@kernel.org, kuba@kernel.org, ms@dev.tdt.de, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, linux-x25@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: slab-use-after-free in x25_transmit_restart_request
Message-ID: <8bcfd8db-b65f-4644-868b-7489f936d604@lunn.ch>
References: <592ed71c.a1fe.1a05d174f12.Coremail.luckd0g@163.com>
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592ed71c.a1fe.1a05d174f12.Coremail.luckd0g@163.com>

On Tue, Sep 01, 2026 at 09:10:03PM +0800, luckdog wrote:
> Dear maintainers,
> 
> 
> I am reporting a slab use-after-free (UAF) in the X.25 neighbour/timer
> path. It was found by static auditing of net/x25 for timer-UAF patterns
> and then KASAN-verified. It is isomorphic to CVE-2025-21718 (rose_neigh):
> a refcounted neigh with an embedded self-re-arming timer whose free path
> does not synchronously stop the timer, so the timer callback can run
> after kfree(nb) and dereference freed memory. Observed on Linux v7.3-rc1.
> (commit: cee9395acd8043be0644b25c34bfa86623f2b935).
> 
> 
> This mail contains: the KASAN evidence, the buggy code, the root cause,
> the reproducible PoC (a small in-kernel delay-only helper + a userspace
> SABM/UA injector + the shell sequence), and a proposed fix.

Please could you just submit a proper fix patch.

    Andrew

---
pw-bot: cr
