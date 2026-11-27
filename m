Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795786209;
	b=RlzzktEX5IMTrIdpE5/u5t1IdUm6yfGH3RJDE0/e1R6ykDzd1T1q/x0GwE9Nbjn6rR1a
	 du6Cdmr/sHzbHWcGA9abo5GZYOTY7sH9ORcTtQn53FfURcS5IA37VdR8oLFN0fn2RFdCW
	 kS1otAi96D1BwJH77wl0ojDy2qvHg2xAozLdinEl7rDVkrwZpWRtZdrcPiGwym8Uyrqwt
	 +pjAglf7Zd6N0nyAi4lKoT8vk4dgf3CyWTd7UmXf+73hj2xFtjZR1HoH4t2an9S8FqOVd
	 4m0TwNKWkksijn5AnPESFArYQcOvQplM7w/evh32IP9tnxAdlX6mNXJjuX/qotlQWcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795786209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=gT1wk/EW5UkWtNt1mV/GP2JY7Jq05n1STN8XjDBmi1A=;
	b=Eto2z5u7yqH+vZBEECfJYIRzsnX+WwINBvUDqRdD1YEGS23Dy035Xyni/o5NF+0yEAf8
	 x9U08fytDh8j+BQ0jDEZ6whFKF1H8zcKWItDG45BRvid8L82dgncJ8P9ZjPHPr9Z4UeP8
	 mOy3M7ibJ2Fm5hj4PhFQG7+c8yN1j96WcaPaR1SGRfiHFcYgV1CE6vLt3sREZPgxOul+U
	 M+wMgDtamFz+JSUQacgI2Wl/bbxTpJbFymqR0PEJRGlTOUVOQR0Xt/VD77idDBM3cWbSU
	 XWq9dCSqX2P5dLQCqee4Fd673VpRTpdhhVCiK7e2GNzWMTw2CwhXy4bkyPRKUm/N7uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owqBHRlN;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80E606A324
	for <linux-x25@vger.kernel.org>; Fri, 27 Nov 2026 13:30:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E80E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=owqBHRlN
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c515369b627so876098466b.1
        for <linux-x25@vger.kernel.org>; Fri, 27 Nov 2026 05:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795786207; x=1796391007; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gT1wk/EW5UkWtNt1mV/GP2JY7Jq05n1STN8XjDBmi1A=;
        b=owqBHRlNX9brkGoupsEPjMJ/YOe5lVhkLo/R9Ape0agdoJUGcj2ExyeUSwfMGX6Nz7
         2LcQYtu76kPD6ODzJ9getFml9dOdz0wAtt4C6kyFLCFZfnNxe7TBtqmfLGPp1+TmNqlp
         r9uTNr+YwKSZjooyoTs21f/DgEdf4sfO2HH8YxcE5wxQu/GEZqn5LKb5SBYzTu05RMtK
         DQaAvJZxNIBy9+RNQkCGjKhViN3qcXR0xyae8Lf/aZBGPTnNJO/ZOP+uRgpp+9+03pDG
         UldGb+IJjEnxlgD+WRjhz+0W+/1s1e4okaKkYWl2eOOozREzVNMC6Af2Xflu2mbRgzJK
         +iYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795786207; x=1796391007;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gT1wk/EW5UkWtNt1mV/GP2JY7Jq05n1STN8XjDBmi1A=;
        b=2UcBueeez0Ny0/khWb/34ZI8vFh7xcKLeZnqyjRJri2p4BPd2SQZTR7xCg5eOCr3D0
         1Ba3m9atXNOjn3NP3fi1mSpHvPjtaNwRbPwUTX150SUdaBFcgOjsns+od+McFkUHKLwR
         yav6CLgi0x8/Cy/L1apzO+2Q13gXhB3nBGeNBTjl96WQBqMhw/OrXr8sLvjvJSK7oT0i
         GlGyiPj5ggsM2hi8Ny604T7IapClpeCuBHgk9a9AKhNf/tPtYGP2sOYDmSXp7AyxuwkZ
         +0er2I+/JoW17X9fmWlSFXkazlj2vME7c4aFLk4HTva53fz9N+ylSb3IUxuuZN8JGxyP
         zgwQ==
X-Gm-Message-State: APuU4Z8/AQd/F8aLot0w35CWiP9ggB2C+adAUvLzfhUrtJZ0zy93G7uq
	LDEQSmnDc/wFcieg2tXpDkgWtBCUzj8mblfZ6N8gb/x8JH/xnmApjneO
X-Gm-Gg: AZFdTZdvA9fcUfakAOFaH6axvsI3MrVDVNSHRw+AypZrHsuATfeAMW3M0aq+zig8/9o
	Pj092Kc9IRMsDUgYO+ZUPhF42UIKEVg1UXdc3zzT4fd2W/0lgumcQWh/ufxGY8bvQRxGQ6bbjSl
	jUobWtCkQWsSrnTMoSShRf9uyuEekEeD6w8oEjrnxpOVebIlCgi975zGHBUhzZC5rhn1BQ9UFtn
	+pNcTkK5GXX1IAeDXIRDM+rXmOeoMtg+eZeKMpsRroBzuxB1qW7am4EGRJYV2vbbm+fECsD8EsH
	BArl9ozobi2HBvugd1jz9QoY9rnWDRrSci43nwJUaiW4hdXxAVjYp6aFMUl60RgPnK/wvkv4dEx
	3k1RfMzLH79zIkcXSw/sRWaRYh8B4VLGz1/SwFmz4DR9SNPrTVUUK0M60kL6ByUVfWPmTmqVtRw
	gPNOi4qZbMNuo18uJ+tv13s2HCEuLUVgIbSj/YIL7Nke/ZUrbkMPBwq6WEqyhD+8wu7L7pdNg9v
	2fSRMWIJic8ztbUmVMaKG3BCazWj/eIhJkJLBM9/eI52w5qwzbErN99uVvP9UA9zHHG6tRzyaN3
	nDq4wWERdmQ7zJkHcPSHK/kp0VQFGYHJNGr1pRWJ82ezm13iac+Hx/hLEGI2iT2woe5pv1HRxxw
	ZvXR5e8KriY0bEOOnC0i5B6Cf7/itYo+seJ9j1ALYU2AA2t+EoqWkqMKjb4t9/LOaa3ALey766M
	EKNGppUFuoOa5yDAbIP5f3a9XLRGMI2339GM2CwbvpwA88a11HPwS+N6iGLCrsKTM=
X-Received: by 2002:a17:907:a890:b0:c51:24a3:fdcd with SMTP id a640c23a62f3a-c513aace71fmr2108908266b.17.1795786207212;
        Fri, 27 Nov 2026 05:30:07 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513afc2455sm859101866b.57.2026.11.27.05.30.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Nov 2026 05:30:06 -0800 (PST)
Message-ID: <5ad2c46b-4ed9-4689-950f-93753fa1586e@gmail.com>
Date: Fri, 27 Nov 2026 14:30:05 +0100
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 0/2] net/x25: don't call lock_sock() from softirq
 in x25_kill_by_neigh()
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Simon Horman <horms@kernel.org>, Lin Ma <linma@zju.edu.cn>,
 Duoming Zhou <duoming@zju.edu.cn>, Xiyu Yang <xiyuyang19@fudan.edu.cn>,
 Xin Tan <tanxin.ctf@gmail.com>
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>,
 Shuai Liu <847807867@qq.com>,
 syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com,
 syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org
References: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <20261127-x25-kill-by-neigh-v2-0-c7cdcc9f1320@dev.tdt.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Martin,

I tested v2 on net c5de2ce2fccd in QEMU with the syzbot config of
300375dfd44665f063a6. The syz reproducer of that report and both
reproducers of 9faa82ae2e94c5c7d2ef hit the splats without the series
and run clean with it. Link loss, restart and NETDEV_DOWN with idle and
owned calls are clean too, and your tests 2 and 3 pass. The same holds
with the PREEMPT_RT config of 9faa82ae2e94c5c7d2ef.

On the question of the netdev bot: patch 2 fixes a bug that can be hit
at runtime, the x25_recvmsg() case included. The window is narrow, but
a test can hold it open. A second thread owns the socket, stalled in a
userfaultfd copy, while sendmsg() or recvmsg() waits with the lock
dropped, and a CLEAR REQUEST from the peer goes to the backlog. For
x25_sendmsg() and x25_output() an RR in the backlog first frees the
send buffer, and the sender runs at SCHED_FIFO on the owner's CPU, so
it gets its skb before the CLEAR REQUEST is processed. For
x25_recvmsg() the CLEAR REQUEST follows a short DATA packet and the
first fragment of a longer message, and the receive buffer is small,
so the fragment sets X25_COND_OWN_RX_BUSY and x25_disconnect() purges
it again. Without patch 2 all three end in a NULL pointer dereference
(trimmed):

  KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
  RIP: 0010:x25_sendmsg+0x8b2/0x1580
  Call Trace:
   __sys_sendto+0x48a/0x4e0
   __x64_sys_sendto+0xe0/0x1c0
   do_syscall_64+0x125/0x7a0

The other two stop in x25_output+0x51f, called from x25_sendmsg(), and
in x25_write_internal+0x26f, called from x25_check_rbuf() in
x25_recvmsg(). With the series send() returns ENOTCONN and recv()
returns the data. I can send the test program if it helps.

Tested-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
-- 
Krystian Kaniewski
