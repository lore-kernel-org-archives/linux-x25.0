Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795832361;
	b=sy4KJmEt4JedkS6ooFec8z5WJ/4pQW38P867fyIKeA11n81pQYawTvfRW3rv/dBcgBBe
	 P82idYOeZYgQ7N0/MuPAjzeuij1CeOXa/RcXCkNktikWtNd5uOQkXxjiEx++XrKIyyaeO
	 pTs155DQD5OkbOX15egPYLyM3IQs+LgvFJKD9jDbpqrirgkts1KelJzra6lNmsf6PxOpk
	 oo0lx6hNHQ9CpQ/wXPr4bJV3dbX+mQ+ehawMHZ2z4XkD2uOo8exi1P7tDC8srHYQsiNzJ
	 3x3FsMWVZcZa0tCwzfcghgA7JN0nunT7y3jD/gc6WYbe/X5bGaukNuSd07Q5zUzFSFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795832361;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=eRSttAXdxOyKYsK514hhSq/XSILs89vHnhuz76dJ1MQ=;
	b=Msk+U7+n2e2NgMkvAnBZv/cw23A7g6RBKZMhvq0Yv5jnzUNkmYhM08RxjM9cA/ns9SBo
	 E1pinQ0cuF/Rls4nt5ITLY89YD6mnu3MI7irjHz5hNoFmNBBrjTin4eaBz1uCB3Keaztx
	 fvMVAOogcmW2C1oTzW86H+SwldtTOITrnvbkFrznBE4MpUUsHoc/PQ1ZfWM6rN13gYTaF
	 ykhFlFUlbVUC1+wiERdTbX9FUbsFAq/55RheIpQwHPmQlk1U/CGIL7De93cgjzD67iJRB
	 IEx70K3Cm/R9TpwxGdTXdRSm5oL1+BdPJmVGFjAKOdNawqSv5kUIPwGfSyBbZlhc1Xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ycSLmqKK;
	arc=none smtp.remote-ip=43.163.128.53
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABF606A681;
	Sat, 28 Nov 2026 02:19:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8EABF606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=ycSLmqKK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795832347; bh=eRSttAXdxOyKYsK514hhSq/XSILs89vHnhuz76dJ1MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ycSLmqKKMQasCPOBuR8RhDm//qmIfg3OrivUWR1y+bncG51ym7TY88QTu3XVow+ms
	 JEXEl/tO8BuGg6VciJS+H5Tv+KKGv3qXPpRPAgffAY9E4h8+uYZMRHS7Ite4fjugtQ
	 LpG+x+dzKnwR44ywV3QzhqWEzIgjU9loPjySM0C4=
Received: from shuai-VMware-Virtual-Platform.. ([39.165.245.102])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 4C4B324C; Sat, 28 Nov 2026 10:19:04 +0800
X-QQ-mid: xmsmtpt1795832344to655yx6z
Message-ID: <tencent_000906974D2C6D42C81D56BA85C54F3EAE05@qq.com>
X-QQ-XMAILINFO: MRMtjO3A6C9X5ZoXj9lGCq202fzCPp8a0pUF3fAkl+2i7f98xR1HL6PGsWmipC
	 JwsiP/hTOpDPPwoLFAUeuHcoaK1VB0JWLaj8EgDleWSks+HOpGy8GBlL6yYQ/DrhMdtzR823fvDN
	 JpkMZZHUPohz4YTv5ezZQC+6NsdfydUqd5z7xiI3ynTwAqLdyDwzjmnlcPZdb/giLnFCWba1l8uE
	 nq39e2tlukc0BNc8Zwk8CE2wwxojLPjHgxpBinxGoeynmzKaj7OcCC3Y56fonTWgjweLsEk+3sqy
	 kz/GWbxvJoAbXPYd8v9gATv7QoKiVkMJHGbvWrV91kbrE+jgv5qdCz79gGGr4gKpqLxmzbTDFI5A
	 uLjF93lX0cwBB6ruAjRnM+FoXw6FuuJXDM85vj1FouwIYafikC2iG8yTdkl7/FtxLZEWciMle635
	 8IkvdKHmQdsAU9buTID75OatI6RXW1YjZsx4qupi5o18sVPQhWpPb0tgMnOo+/1uHTve9P5eRoXW
	 b+ftN+ZVh41zTiCW6LOkeMH3r8hwUsr8llfTX/rbPm0V+Z/Fnhqm/8zKtk4RWGupCKUW7lPApJO2
	 3mFc2gdl1Mx4Z3SnLJczg/nFEqugTBdoW6w+OvQaKmzX21uzkjh6kEuzwrZCXmn9wb0RP9BKbAHj
	 j/cEqQ22ZmmvMA5wWoG7X8QbQhSVgMVqAcxRzmW9t+EB71r2IQmBWiuTSI9G0WZMUSjZBBi/x9Pr
	 0v+HD7PBaZbb8Hp+QNQpm6zTm4KZ0GqMBHKV7RLgJxM5RjgXG21JPjHNqsUTldSyumfqbHxMiOyi
	 UhfdGKkJMQhUqzYCgO8g8xKxcx+dRF7HXEzPQI9gK8TJzjopZPE0PqIooXES7DjkOlDSPSU/7kzb
	 t1Te1C8wwPmfleD47Yd/ruZ4Vm0Pp1V3Ga1TSbjDtE9cNzT8/xaQ+YbN4pB0drTEnRiWqWUPbbJk
	 ydPZtVTWlfyPC+yvQB0KUJLz04IaJfPssiJ6ILq7d6gPO9VC9HR5N/aINxJp6W+SEFnX6CXhh2OW
	 sj4EcsCSrcLfSj39qT1YfUKGtK0n3OBsb0Mg6oqrzqzp1aly9C3P3/KtDl5p6+m8esMQ9FLxeZ/9
	 COwvX8i/FrUDZHJUY1Rhye4Hu7XTfT6bHRkvXa
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Shuai Liu <847807867@qq.com>
To: Martin Schiller <ms@dev.tdt.de>,
	Krystian Kaniewski <krystianmkaniewski@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Shuai Liu <847807867@qq.com>,
	linux-x25@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net/x25: don't call lock_sock() from softirq in x25_kill_by_neigh()
Date: Sat, 28 Nov 2026 10:19:04 +0800
X-OQ-MSGID: <20261128-x25-v2-tested-847807867@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
References: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Martin, Krystian,

I tested v2 on my tree as well. Patches 1/2 and 2/2 apply cleanly on
top of current linus/master, compile with no warnings with LOCKDEP and
DEBUG_ATOMIC_SLEEP enabled, and the x25 softirq->lock_sock splat is gone.
All looks good.

Tested-by: Shuai Liu <847807867@qq.com>
Reviewed-by: Shuai Liu <847807867@qq.com>

