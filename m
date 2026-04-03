Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1276A2673B0;
	Fri,  3 Apr 2026 22:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253632; cv=none; b=haMCjG4SJIzTXCNqHCAOnn5gB8Axu+7wztWVx3eUEI1xbjcHawbV5HGv0yVwM7/OxsE8Gr3WH2aSN1PD+4YbXar3DSpOT3xTL6rM4U4Mbw9MX61Xolfxd69dd9p8ppCdD25FCpCUmgwTMOidu4emOyuDPiXQKuxYmNgZpZRD748=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253632; c=relaxed/simple;
	bh=iOt0gTk7N9wEXrQTHQpVv6cU0BRx3SAd34Oj6SsD8Kc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=L3c9pq+PimWDdUkHgbEhhGYl1DWCVMSbrnXsmnZKXPdiljRMOTZoOBcXfd36SO7Mmj8edSZ0cWtDUPK6T748BLcoYaoroVxlPCN9AlVb0D+SwCtKqRB+J5LG0iL9xY+8xkLi5J1V+feh1IzxAKop4jaY2AhJ8Fz65xsBqC7jg/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9+XcsZJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9+XcsZJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4838C4CEF7;
	Fri,  3 Apr 2026 22:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253631;
	bh=iOt0gTk7N9wEXrQTHQpVv6cU0BRx3SAd34Oj6SsD8Kc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J9+XcsZJbO9tbFcsnlOchO/sYSK++hqzsdvLPDreT8UJ3r1lirse3fopn/fRhu7Xb
	 JkzHKlIFYodzVD90pTNW9+Dc615VvzbPT6Oq21Isk8zuyPAZWXTfSWErQTxmw+xqQi
	 v8BJloE5CZBuujt8BUexS1RdsdREZ7MgWOWQaz+Au7mCFrH2JqtW7I5103W7nyuqAX
	 HTvu5h//h0q9JbOpTft1YCnYK+3lYMOKXbQ15MIKv7x4ZieZ3qsJEaHffhMTHbrk4+
	 4umWe2qKwv9T5CPIHB/YtHOTtyN5GKZK15cNmoHBQAxYXtnWUOxH1oB2vwO9HR84X4
	 PQscBtRY8Zlqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDA23809A14;
	Fri,  3 Apr 2026 22:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525361303.1466030.10042284930163009344.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:00:13 +0000
References: <20260402103519.1201565-1-edumazet@google.com>
In-Reply-To: <20260402103519.1201565-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+d8c285748fa7292580a9@syzkaller.appspotmail.com, ms@dev.tdt.de,
 linux-x25@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 10:35:19 +0000 you wrote:
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
> 
> [...]

Here is the summary with links:
  - [v2,net] net: lapbether: handle NETDEV_PRE_TYPE_CHANGE
    https://git.kernel.org/netdev/net/c/b120e4432f9f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


