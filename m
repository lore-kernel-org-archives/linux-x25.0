Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795761236;
	b=3hXhZlwm2bIJAEQ/o6WsCfPqTWD6GIp7dLhEleX8Q0vCEsOgDmRp3lEEaNfYGTAVHVNa
	 RTw0BemhEZtS3mXuGN0G0s61jfj0uoD7CMzqazrJ6Ertg/c9Yny1+JrpQhg4i2Crr658N
	 e+H7C3SmWirUlzUUktLE9Co44JF5unmBS8YERPmgRLKMy7SnmEQHfxfdSMOzmhAMSZ895
	 gz30D0nBH+F1/P5SwyWR6YoB7GjXeeX3yvXjP8etjOMIp7EUDEpWAcEes5t5YdiPpKbt3
	 xDcWutJsDqi0IzGx36wofUpfQsYm+H7K8BNgqCRnSuKXntTu23lKRpPt1CPBGilEDzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795761236;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	b=oVdyCeod2mIrRPJx8Fma/kBAo2isOoe7zDkj4Dtc+V8TuLGKOXdxjuYtCv9wO1rdfAPO
	 FQ0s7qQvYeCJOo+pkGVhAx3OBraP4LYnjcjzVbZbuDbd7+y1YwRk97VzC/F0qIdZRHrOs
	 gX6yaEZnMwx9ydiIq+u557X8OylS+k8Z9Yi8Hx1kmSXe2vItYKJ/kDj06RZh8OUv+mrtI
	 LySTXOZq8GL//cLAiDLkHXlTYMXOBdE3jdCrl3INfMVoNtLqiB9aZzZ2PUaFcZqjh0hko
	 cXKq7Z893elz3Lu49UgHkiI9RtQuNJRfevbLLsPUgmYkIN0LRvt5ALX4Ib2O9rBISyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gitcPxo8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53B0606A31C;
	Fri, 27 Nov 2026 06:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gitcPxo8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E0B61F00893;
	Fri, 27 Nov 2026 06:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795761236;
	bh=Ps3dmenyy5Kz+Ld8FFyPnRbKN1BblcpmGxOsdgzLlkg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gitcPxo8d7QjIlzPUrsx3M9yr6OGjQxh+AtSqjPVupHfuq4uWe+N0DtMH364AWCXb
	 we/vusj8x+N9prBFw9YzxZMx58dTSjKXzGe0tk4DSNULVbRK8nvCwL8IeugzaXE6td
	 e8KLNxkcUoYqRPiWfKcuZQQJzXr3WaRUWb3wggF9z1sli0RFyKwhDUj0Cwrf+C1dWa
	 iHlXUByFxv95Fy7tVvGDE13h6xu2WQ7j0lK40IBbuCEtneEeUvW2YGb34hyHpxrXB1
	 gmCWtF29sDIy/w5hrfEDUwG/4aHhnDtjCOaYUzczcOv4tcK1YGPu81+rogUKQuWUrO
	 6HWv2vVzD2VWA==
From: netdev-bot+sinfo@kernel.org
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, Lin Ma <linma@zju.edu.cn>,
 Duoming Zhou <duoming@zju.edu.cn>, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
 Xin Tan <tanxin.ctf@gmail.com>, linux-x25@vger.kernel.org,
 netdev@vger.kernel.org, Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Shuai Liu <847807867@qq.com>,
 Krystian Kaniewski <krystianmkaniewski@gmail.com>,
 syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
 syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] net/x25: don't call lock_sock() from softirq
 in x25_kill_by_neigh()
Date: Fri, 27 Nov 2026 06:33:54 +0000
Message-ID: <179576123458.3294.15178511049839805716@kernel.org>
In-Reply-To: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
References: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
