Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B3F3C65E7;
	Fri,  3 Apr 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231733; cv=none; b=UPShruLrvKCv2GcrHOZ8AoZ1mLqJ7zzoF30SM5xtldlQE0aqaq5YYOrnN5TfM2IcyRDczYbIfpOjnDBC5AhedkTbNsa5oAjSr2CyZG+9II/TN5dQ4r7Y1bDTDNR9rznTCsp8fNx3LWuzYU7eRMQsMqFhkRQGmjbo1b69WTk1LsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231733; c=relaxed/simple;
	bh=5zCdI3/H+C2yChLoNxakHbo/nK6sYvMuqWoXXXeX1xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCGsZwxQlD4KWoZqJWymnSFJtiyzBWQGN3TfWZdaAx/aNHQEgFaeDEtwN/7XzpwNKUe4DKcD3m7evPoSvXN62XW2QwzQWlSP19zV++9AREoBSVLClV+mv3jlQXR0vgBhMFVVgASAyXLYOsFGfua4hnFHM3Ix7remD/wKVmo4ujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOjp5HqM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOjp5HqM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BF1DC4CEF7;
	Fri,  3 Apr 2026 15:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775231733;
	bh=5zCdI3/H+C2yChLoNxakHbo/nK6sYvMuqWoXXXeX1xM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tOjp5HqMlfxqT8dJIb0IjSHeFSaxEgLddrpyBkKJIdaJeYCW5sEQ9ayITXYjdcSmy
	 5F8bwW6PBPgJohc+QcKbboI4SzLiBsFYI2+csceuSx1lBK6mgEosFPd34EghQBCHps
	 EdajSe9aiOVZQNK+zAQOl6BdUFroLLNQLK+VDWZhBGuIuBATjQiziJ0c3Gl0nG8d6g
	 z98LvV7OTIxb8/BAOFw9xw0iqT4ELkK1MppSKO25nQmRBIw/9E8NaW22bWG4QHZJ6L
	 v70rtSy/18LZXUuZh/QO1QfcCYCNeLeCGSSUfR3oHl+jdYXYy95BpsZX1l6SMJqYFc
	 /ocOleUbPmjdA==
Date: Fri, 3 Apr 2026 16:55:28 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com,
	Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org
Subject: Re: [PATCH v2 net] net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
Message-ID: <20260403155528.GA198235@horms.kernel.org>
References: <20260402103519.1201565-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402103519.1201565-1-edumazet@google.com>

On Thu, Apr 02, 2026 at 10:35:19AM +0000, Eric Dumazet wrote:
> lapbeth_data_transmit() expects the underlying device type
> to be ARPHRD_ETHER.
> 
> Returning NOTIFY_BAD from lapbeth_device_event() makes sure
> bonding driver can not break this expectation.
> 
> Fixes: 872254dd6b1f ("net/bonding: Enable bonding to enslave non ARPHRD_ETHER")
> Reported-by: syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/69cd22a1.050a0220.70c3a.0002.GAE@google.com/T/#u
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Cc: linux-x25@vger.kernel.org
> ---
> v2: cache lapbeth_get_x25_dev() result in @lapbeth.
>     make sure @lapbeth is set before returning NOTIFY_BAD.

Reviewed-by: Simon Horman <horms@kernel.org>

