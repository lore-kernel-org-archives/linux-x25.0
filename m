Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795523519;
	b=2erR5rZ3Yt/+MEh0q4HukdLciy89OIIqRQnQDd0BKtlgnbSCql3HyfkJRjn9XNhsbQPd
	 PDfkp/6kaFN9PS5yiVAq20iUu7YEYe+w7hK+kw8AdKgUIakP5inHZ9dapxioaPRny0ofg
	 Klx0CvRKXk8FGcW18WknNFqh4cgJtz8YL4Qc1IC8+O+kKUBMaPGIK4F7PHb7IxzLyME/x
	 SJAec7O0dQfBGtCMCMjqb0oG6jxL6jVbEe1mO+yoWEvfQ6fKocksmmB5vZp+ervktzXtr
	 wqFcg05Dsp1dFWIy5BdR21WkJTsevqS3hD6ob4/Jvljp4UtK70BiJ0bulXdLzGpeohg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795523519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=VAGi8ADLbe1nwsDdtMJUG+mqysismIkmi3QPANzknRE=;
	b=2oBCido97+4Goh+frIiFm0PQRf2KzDSu0kto+0GTGfEE324gjZM0mB9+YHrJzygrdebJ
	 du1zogxjeUQX6GppyG47+neW5RUSwML8TJbb2ZteChUGPiILv3aIB8MsONdaZeBfeGi54
	 fiWwdCY+IvCJ2VIPimLxlIeT2775JXdPIzxLEdqKEzOjyK0qFZ8sPMlnctSNN1R3n5blw
	 GWdv64XfIONP2RuFxm2leYuVjIj+akAEKdmtUoPz528y62D0u1nYnn0Um6IbiNSFwZkeK
	 DP1MPeFYRJwiLnI35sFoXEAOVEdHAoa5QWjVjdGd6hWqGSdkYUOoZ+fH0Umvo3GW58A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjCUpmNl;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2B9606A321
	for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 12:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD2B9606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wjCUpmNl
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b88d143160so5416580a12.1
        for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 04:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795523517; x=1796128317; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VAGi8ADLbe1nwsDdtMJUG+mqysismIkmi3QPANzknRE=;
        b=wjCUpmNl+mRVvplDoEgumYPE3g2vqJKQo580YWEMbgKWCwgMLPfczJbnJxQ2Lx6fJS
         yMpi0u2vJaALSnXWBIHszPeiqA8DCjAM+BWjq6vY+ps/NaGroZjTsfuQgmP7K4h+36Qz
         tQUPmLxV+LEfU1HxNxDFfHAgAqiFd4ma61hQXlKn1wGEgaZaDUk6pSN5v6EIgXxgMe3t
         npl0OXnPrxY6k3giZUxQ58l7irS7XvjxWs1BVUZvTke76E5MjqYYNGj9HMBsQwvf+U3l
         9EdajxbwknzTCJQr6V2FnxbYW82Nsi7Bp338o/4kSx+7Bzf7mU9y9WbTXxn2OZQzyleL
         bErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795523517; x=1796128317;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VAGi8ADLbe1nwsDdtMJUG+mqysismIkmi3QPANzknRE=;
        b=hlyXpiyRssFeXhONU8qQzeSNH4UH8OnrKw+yGoqoO7qWeEHu8Nr7LJ6owLodT1K6i8
         p0dNCVUu923L+lQxGY0MiDHh8jFJuS8cLCDAdS5N9Xw8kOOGu4Ku9VBqwuMUKDSgz5kB
         vilJcPz4hIHL3WFPRSu72qH5x5z0v9swjE/CkuVv1Ih0Nqe55Fu3SXrVgMbUbcJGLZnC
         fZgeFgAMaBSznmERXYV4xLFmEtXrgpx/vWqq2EuBVB3dqC36pViogIaX/oI+xZjCV/Y6
         vQc0xHp3JE6yyJYSxUV6bYUpVVzasad/zKRLdFCxXXKk4KSSTyQE4uk2EohNqgq9yf3X
         0pig==
X-Forwarded-Encrypted: i=1; AL+hErGoVL4SAc/3lohJRS2KCCvQjd0VWKKjlT26lNQmD9FgMSVsbnRAaQNu3cGSNc6igBJgNJloBZpX6fQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Fjyw3vkMcvKFOc++jdFOCEu3f6lyqyA9ej9RgPDneJMvSPdEp
	8QwEXP4tspACRDR18XUs/5DYBXiTDA6t+llU0hXYS58MUrNk8NfCQWYC
X-Gm-Gg: AZFdTZc7HyaiMv5apoJ2nx00giSqvAgSFu90PwbrT+VKHJDy0V5H56EZdOyrgfsxIyc
	BcI7Hj0wt2zBm7T7jIFwpXaIYaH2jySY/CJGsYkEtgcDuEo1HSczq2b1smKl03AOhbkcXK3WeLl
	fHuMl9f6lR2fLVM5wXzQdHfgK4LEQyGF0yqRfQSNauxysFaA4QngD9dIA4h++AgHFSyQeN/FA+7
	mGdeWMNZKXT3Zzg0a2ksiwRgA+1YRYCY3gAJhVeI/dV1icT3a8pD63sVIEr9jlg1VswxUGFlFlp
	0pV+oLOlzL+Qlky0g0P1PHpHQOg6eML4zRRp+m9Cr9pd1Ad2lGpjfH4zBt+PHvP4u+Zm/OsxfDt
	h3THBRCHbm08pDyQBZlwKK3oGHLpec+opJeTDKdHqhHj/hnQ6ExfWc47Xej0jvep3BkJjdFnbL/
	2ErNAkNb6Bt/EjtnwtwqlEG2bAm+TT3ppVLoFTisJHZnhWJIfErNYvq6WxpIJY5IcHNnWbNaauH
	yCmvJFqAPSohlH146qUKIoPJR/vVKyKREOfCY38juHCSpvTjKmH7x+otdNX6NMX4AfkxZOdtnVv
	q3AR3w1M50t0TKuu5mwirUBYASCtjfwMZuNIKz+JnmGPQD1nclTqOIv8LeGwSkKKUhA1Taqwo7B
	pZaC2Moy93Odmf2zV3VW+Ek5muQHIocH9cUMSP97XrktkxKgmx7pXWC/HI+LXg6Wkp9k2TPELDx
	WW5vr1t8/uKJydoIsM2vV2zUNlLvFRn5QL5yykjKtGgVd6DrUCA9CkSgqam3yS56M=
X-Received: by 2002:a05:6402:ea9:b0:6ba:eb4c:487a with SMTP id 4fb4d7f45d1cf-6baeb4c48ccmr1907009a12.22.1795523516710;
        Tue, 24 Nov 2026 04:31:56 -0800 (PST)
Received: from [192.168.100.100] (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba854bed08sm4675512a12.30.2026.11.24.04.31.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 04:31:56 -0800 (PST)
Message-ID: <02419845-bab8-4e36-9a98-6830761da1b9@gmail.com>
Date: Tue, 24 Nov 2026 13:31:55 +0100
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
Subject: Re: [PATCH] net/x25: fix invalid lock_sock() usage in
 x25_kill_by_neigh()
To: netdev-bot+sashiko@kernel.org, syzbot@kernel.org
Cc: syzkaller-bugs@googlegroups.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, linux-x25@vger.kernel.org,
 ms@dev.tdt.de, netdev@vger.kernel.org, pabeni@redhat.com,
 duoming@zju.edu.cn, horms@kernel.org, linux-kernel@vger.kernel.org,
 syzbot@lists.linux.dev, ngocthang2710.1999@gmail.com
References: <00f667e3-a158-4fb5-84a3-9ecda4718ce8@mail.kernel.org>
 <179551432467.3135.11868205229731190547@kernel.org>
Content-Language: en-US
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
In-Reply-To: <179551432467.3135.11868205229731190547@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Tue, 24 Nov 2026 09:58:44 +0000, netdev-bot+sashiko@kernel.org wrote:
> - [Medium] When the new softirq path finds a socket owned by a task, it
>   only sets a flag and leaves the dead call usable until release_sock().

Agreed. While a task owns the socket, the flagged call keeps its LCI
binding until release_sock(). __x25_find_socket() still returns it, so
frames that arrive after the restart go to its backlog and are processed
in the old state before x25_release_cb() runs. The owner can also still
transmit on the old LCI, and after a LAPB disconnect this brings the
link back up.

This patch follows the same design as Thang's patch from October [1].
In that thread Martin confirmed both effects in a test on 23 November
and announced a v2 which skips flagged sockets in __x25_find_socket()
and returns early from x25_kick() and x25_write_internal() for them.
That covers this finding, so please drop this patch in favour of his
series. I will not send a v2 of it.

> Pre-existing issues:
> - [High] This problem wasn't introduced by this patch, but it is still
>   reachable after it.

Agreed as well. x25_disconnect() clears x25->neighbour since commit
4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25
disconnect"), and x25_sendmsg() and x25_output() dereference it after
they take the socket lock again. Martin wrote that he has a separate
fix for this.

x25_recvmsg() has the same kind of window, and the review did not
report it. If x25_disconnect() runs after skb_recv_datagram() has
dequeued a packet and before lock_sock() returns, x25_recvmsg() then
calls x25_check_rbuf() on a socket without a neighbour.
x25_disconnect() does not clear x25->condition, so with
X25_COND_OWN_RX_BUSY still set and sk_rmem_alloc below half of
sk_rcvbuf, x25_check_rbuf() sends an RR through x25_write_internal(),
which dereferences x25->neighbour. I found this by reading the code and
have not reproduced it, but it may be worth covering in the same fix.

Martin, syzbot tracks this report separately from the one in Thang's
patch (extid 9faa82ae2e94c5c7d2ef). Could you also add the Reported-by
and Closes tags for 300375dfd44665f063a6 to the series, so that syzbot
closes this one too?

I am happy to test the series with the syzbot reproducer once it is
posted.

[1] https://lore.kernel.org/all/20261001150118.128470-1-ngocthang2710.1999@gmail.com/

pw-bot: cr

-- 
Krystian Kaniewski
