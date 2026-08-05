Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377593B5306;
	Wed,  5 Aug 2026 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785895254; cv=none; b=AvIvLWv2qRgX4v3SjbdJpwdf659BB/vvwjkzXCHvmhtE+zp0A+7VxsSY0c+EOz2qFoFNUIWkEFSRyq5yNmgoh35UAJmERtkdHKPwD5SEXiBaowMFR/LsJO1Y74Lgt5xH6rS/OqTmGsKsX7OQERLG5ix/HC6uBP+1nUhEZoypV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785895254; c=relaxed/simple;
	bh=R1ba/U4WRfjPr6YGnMHzX9gfg8EczVMB1ENsE+XnjC4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S1hk6UvRo3lLv4qnPjSG5I1KSVaQvHOLqVKKaMnuREPvijfP4ya/KAr7Tp+jXbWMQYBCHxqyptN8RxdhyarAtPOyCMnqyI/jZs9XLkbD+8WQw3yEKHJuu99buzSzvcogLhD2Z3lkTYZqqH75xZ2P9aNs04EDvqugKDIzlIwhYJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cekCH9Nm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cekCH9Nm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9901F000E9;
	Wed,  5 Aug 2026 02:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785895253;
	bh=r8uPylUGWVbDMgSUd2wNVjVPcO+fXcqOQGGJ0uCUDM8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cekCH9Nm6sPGg644d/9v48pjNKjJT5ouzwvjMyF0PNmke7TPjB3Ude6alUK5YY0PY
	 Q5su9AruOdZobWFaDfS6jUebcTjJ8FrjoSByumprig6zdAMdmXe9CuGuvUHEZQmQ7r
	 Lq4abeerhxBfUuy2z4eCYegf+en54N23+4ywqqglBiS2vptQSoulNWKTbWOVnrh0wF
	 nVpFJ8NpT/riWIRgjryxTncI9674u2z2WjzVLEHt4MylNC67HGTYosMwXDZO1JFxg1
	 XS1AQkbS/PY/iFsB/vJbFnkuS1eIdzlZXxC//D9vr6xgn6zln/U+ucgbHSNL4UXXlJ
	 f1NfwsL47pUmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939033926667;
	Wed,  5 Aug 2026 02:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: lapbether: check register_netdevice_notifier()
 error
 in lapbeth_init_driver()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178589521313.3873994.8127195302924326288.git-patchwork-notify@kernel.org>
Date: Wed, 05 Aug 2026 02:00:13 +0000
References: <20260803085936.142160-1-heminhong@kylinos.cn>
In-Reply-To: <20260803085936.142160-1-heminhong@kylinos.cn>
To: Minhong He <heminhong@kylinos.cn>
Cc: ms@dev.tdt.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Aug 2026 16:59:36 +0800 you wrote:
> lapbeth_init_driver() ignores register_netdevice_notifier() errors and
> always returns success, which can leave the module loaded without its
> netdev notifier registered.
> 
> Check the error and remove the packet type on failure.
> 
> Signed-off-by: Minhong He <heminhong@kylinos.cn>
> 
> [...]

Here is the summary with links:
  - [net] net: lapbether: check register_netdevice_notifier() error in lapbeth_init_driver()
    https://git.kernel.org/netdev/net-next/c/e43e9d7cabac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


