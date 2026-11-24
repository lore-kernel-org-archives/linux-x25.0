Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795540800;
	b=D16avD+lqviyCXfXBea3rlfWpHtWcWxxgHkx1s05JVzAdmIMOqEHNDcGw/KlScwp2+JH
	 XxvsmgRCZK0H76KNIAeG9+urT6w4AKmiXCTxNxZi2fmHayz5pGjW8blAMF4oU/Sy3VImo
	 t0fOfwFBm1e4Li53JhkUFegN+YfNFgyXwGDQydpsX3xoU8Pk3Oa0/NFdji66nU6yYtisk
	 X5UCVdIPP03hHUohaWxpM+4CvVY6FLSK+elPQXY6H1vHYILAgA4nFDar7Y4Vhnz9aE5p/
	 qnvkuotCrxnTna7yYtJswcdZ09h7xMIrHte5xmZv1QqunWvh/aXuiMKOpMAdXogZ1pQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795540800;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=6Sa4W9FQ13TndG6KfCVgrINI2FSIc+okogULQsXiVgQ=;
	b=CD3MZifo4/B2ZkrvgmmzfaJT/9Gcx90VpwZfrkl5hAY/dsAjF9N2KDGKSdqSth15ZFP7
	 CH6VMzSF24pgCRqNXs1ecJzpQ33Tm8EG28b5ay8C6b0jTxaR2cZmU+kTIr63P6QtIwMcu
	 GWEBuVsbVDgl46EiW9YV1GsN/PgX951kaZtRVANTAd6PZPSYVF4DC6BNuwM8Lm/62T6zA
	 De4u4/IT18xTCL+JbNY/b+oW8Ppnc5RJLLIYwVaMRQcB5uxry7eoDYHF2o/wGG8CAX/xz
	 C2NzQsD3JKuBbpihUbIUFJhvkoYKXXxD8r4vPjaN7q8D/qLdYo1ZPED+f6OYGG6CxYA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEdMmKAK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861B3606A32C
	for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 17:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 861B3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sEdMmKAK
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so51984745e9.0
        for <linux-x25@vger.kernel.org>; Tue, 24 Nov 2026 09:20:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795540799; cv=none;
        d=google.com; s=arc-20260327;
        b=SwxqtBPzZ/BjHh5z02fVFeXNrLJbLuwan6cSduax395JdWBG7lK+nrYr4Bc56XB7Th
         6OuWcmHWaypCGJ/WyNxi5ZXiaW+wkowjocrJSyrI47kpKjDSzUii6BCy1grZeM5lkL1s
         +aFRLzpMGS/yMa9GYUB67n66YNmGt6kuDpqcnyvzXeJCTtWgZWAjyi07S/5VZfeN8nil
         QbP7kMyucuf2IxRKoYeQYxgw53g59dfsxMjvfPq+UG69JEvRDC1T/aZKCaRKfoEgciOO
         Q2TwQF0sB9WQ9Gf7xK53blDIRfaP7zC0yBStzBrSstGbFFnCKI/BpfuvMikVCI3RxILq
         w4WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=6Sa4W9FQ13TndG6KfCVgrINI2FSIc+okogULQsXiVgQ=;
        fh=NfY51j2qneE6PtkDcZHQGBznxLR5ln4NBV4H2JVl6kI=;
        b=SrRa9P62gU62F8Ou0COOHQNbWHuWD9djyitcqTo5kiZhXahZ2fbmRLMQxRmgesi1GX
         AkrIy2LZGceTIlhXrYe0YftzX6cwHJ14h9GFNcV3udBzWi/tHe5fsK6eN7xqh4qpv+o1
         gGd8Re8UbPrG9IHd/mUVUANZpanAFUNj92exoYAkiTPHj/vtC14Me/oNboYD3NN8WtgJ
         xL9+jNqiMrfR0D2fM47x85QckoCFZOUEguVrxJrs5VK+EzcCqgdryIxyoP2HxzEI0/tn
         fB5siAgM1ATuJ76wOd4JXuDr+NzdzJH5cSeGZfDPmSRtClGTMjVRCwUzQBYH2gECygMX
         hrEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795540799; x=1796145599; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Sa4W9FQ13TndG6KfCVgrINI2FSIc+okogULQsXiVgQ=;
        b=sEdMmKAKvHAF6+bOEUrtKd9w07tUhTwyCvIlU34VldlORSo5/94WD4gjL3zIgravLX
         i1VWQCmyD/L5b0ICrRoSFWPGmePK6nm38QkNpgKSfWLCunId7wp3XMz/eg8Skqivz31O
         LvcjGiCbIGKLDETBg3RWXHAVzEUE4aRRIZYuet0jE2T7DBNy1SrtreXLoX7ZJOKPI1yV
         GfHI6F2FbzyOUBrk+LyZGyKoZ4Sk65y+9FAaXOrInNvB9h72Fe26mweN2lVZ04w6Jyif
         VYdW1udaWJjDXehNqpTiR8sTi92H5eRe+btzKG7KxYNzAUZRoxVPUjWGPdA9ltPsxrSl
         nXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795540799; x=1796145599;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=6Sa4W9FQ13TndG6KfCVgrINI2FSIc+okogULQsXiVgQ=;
        b=nKsJITeYvbkEYl1XH/qKVlaGqCdeQ1QmLI2VhcmfFUgObOkg5unGEfwUvg/xOwMb3h
         PhTo/ZuibAXJCcIw+Vs0oR3i2xANPYK8H+8XSaLoDTuK+mv+oMnu/nYZpAq8RCjWLqJv
         X0Uca22A/3hh/UY9RE5/hAHY43D8CjBk4uK7xlJZQWRDgqy+bxTc3Q98LIOEghiXFjhr
         9n3nTXYmn/Bh11FJr1qFgl87iAyU7ea3+O+h+lPZWh/YdVb4U+2mEw7K+1LXpMFb1wQY
         6Vw7pd90V9p+DWX0FBVvGxhbRp9/N7SKbCXUA+zJRoX6aH9xL9qpPEBEzF9YiPtr9vRu
         456w==
X-Forwarded-Encrypted: i=1; AL+hErFKNR/F8D6IdJTN33lHuK64nRYcoR6xKT3jz7CKHyzpdPu0C6yYwQLEhAgGH/Qi6zW5mkKayM7cKWA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sVAzuKks7bRId11o18ptrTlWzYVl0UkiP1OqS5He1wkkHTcYc
	YaUtIt9G2RTpkQxfvSDJR7nArYN48uBzHE2zmbAaXmElbtCKHe/jS5w78o+r9VKQdp4L7WsDYbs
	Whp7jjpf+DrQIpqI92G+Ab8Owrmlka7A=
X-Gm-Gg: AZFdTZf0k7T3E4vm0GCZZNIQSUbgo37w3rO+AF+Nsv6VGm/X3yG6HJ7eAIZgmwZf7tV
	CwoVy+flipXM8lhJU6oqpBWgjtwjJPnitJAQVVHEjWjOd5pkA+RjIrJBlGNFjXpSOT76D/+3hVj
	MXlkb4802F3kXTGWp+0s8ly/AMpf3iox/BMQtJoQ890UeYFj6wIs8KEsU2Pahhl2n1Obw4Nj8cj
	WivP4bdI5WkwA5iRZuKpge82ZCmfZcSqI0aaa1M3JhjSWrNJP55hWGXjUZsIk7YK/i1cGrWDDGA
	Xhm1kB/lfSsjk0wY6fl3m00quFekdOmibXYEIHT8xlszek2ggHJiDIxH6QTVhOPiWEXkRp9HNi3
	BHuaJOZ8/MYbpzdc+Uhp9/5JJoO6NzMyA/KvG+9H0MNPR4U6osnhLT4RlP+M4PNbXXoHsRSeiD6
	hnDXUSjaRPSxF93oB1jHGOJ4mAyx86Mnqx2wC7ENSIvPGVod0clDo=
X-Received: by 2002:a05:600c:530f:b0:4a2:677:ad8e with SMTP id
 5b1f17b1804b1-4bb8892a21amr289651265e9.34.1795540798527; Tue, 24 Nov 2026
 09:19:58 -0800 (PST)
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-x25-v1-1-4432d3892f8b@gmail.com> <c70bad57add6ff8cd52125c698f3f54a@dev.tdt.de>
 <CAHC9VhTLg2FLNf3sLe3+A=q5Mo4gKs+gB7zi5sQT1jizsOPuNQ@mail.gmail.com>
In-Reply-To: <CAHC9VhTLg2FLNf3sLe3+A=q5Mo4gKs+gB7zi5sQT1jizsOPuNQ@mail.gmail.com>
From: Wong Steve <shyckless@gmail.com>
Date: Wed, 25 Nov 2026 01:19:46 +0800
X-Gm-Features: Aa3M54pfCokUKhl-I0LqSXGVHhsd32oCkVf6bc_7JRKNUQctTjfAfWYnwD5gTZs
Message-ID: <CA+X8SdjoyJT1i1Rf08psCsLQyPQ+yU_tAH0rCQPXpkm4DF_=Nw@mail.gmail.com>
Subject: Re: [PATCH net] net/x25: inherit the listening socket's security
 label on accept
To: Paul Moore <paul@paul-moore.com>
Cc: Martin Schiller <ms@dev.tdt.de>, davem@davemloft.net, kuba@kernel.org, 
	edumazet@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org, 
	linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stevewong@hust.edu.cn, 
	kaixuan.li@ntu.edu.sg
Content-Type: text/plain; charset="UTF-8"

> the x25_make_new() function is called by
> x25_rx_call_request(), which as far as I can tell is on pretty
> analogous to an accept() operation, is that correct?

Yes. x25_rx_call_request() runs in the receive path
(x25_lapb_receive_frame() -> x25_receive_data()) when a Call Request
arrives for a listening socket. It is the X.25 counterpart of TCP
creating the child socket for an incoming connection:

- x25_find_listener() finds the listening socket,
- x25_make_new() creates the new socket and copies the listener's
  settings,
- the new socket is queued on the listener's receive queue, and
- x25_accept() later takes it off the queue and grafts it onto the
  socket that accept() returns.

This runs when the packet is received, not on behalf of the process
that later calls accept(), so there is no process to take a label
from. Without the clone, the new sock keeps the default state from
sk_alloc(), which is unlabeled for SELinux. For TCP the same step goes
through sk_clone_lock() and sock_copy(), which calls
security_sk_clone().

Thanks,
Suyuan
