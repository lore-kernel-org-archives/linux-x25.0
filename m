Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1511612D1F1
	for <linux-x25@vger.kernel.org>; Wed,  2 Apr 2025 21:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743628519; cv=none; b=MnrHW2CjDBPLMCjwoHudaGqQBOuzsUdsO9EwozRDKrbJKPqf/JWh9NBjtD+JifJX6TQ3ENXBU4pzM2A2K7VQ/g3+YLl9U5RlhqsIJHJtgVz36GgJ7QaLGm53o/WcFp36A1LFBCvy+puiksWScAZOJ7K5hoTCAXTnao+c0CmYpCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743628519; c=relaxed/simple;
	bh=yMtg/5bd9WuFFPh1QUVVbVzPyQ8PxgEFM//QPDYEqaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NJ3ad09riPYBtMN5s46wAfdSkvJ6FRzdX5SUMRVw+W1Mwj6SqosDy6ur5rMsD4OCP2lPguw28xfojodsQI5WmtiGLb38YeXLhkmhoAigBQ3qBGjytVxpdDk1SnPz9n/yzBM/oQCLoSNi7APiU1+GXy5FLhwA9Xui3MkXdUH+sTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=G0qPR8pb; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="G0qPR8pb"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac298c8fa50so36473766b.1
        for <linux-x25@vger.kernel.org>; Wed, 02 Apr 2025 14:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743628515; x=1744233315; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=G0qPR8pb13eBpWM2N0++AJ2lvRCp6oawdxMFE+Mrq+GeO3z8ljqMGmJgfdYEnWGrr9
         SU4ShMwVYkwCwXivS36kyXO8e56sNip0gFjSMOgLR5yQDAtFShggFNqpwlXUfcam1OSd
         X/8r3ehZI42uwrg9FSKQtYyFsM8PHK4qIblpw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743628515; x=1744233315;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6vOkaWbZeGW9ejcyKHqKRgGRaPzQmhuks1cZQp6R9ag=;
        b=ONQ9tGp+Ov5OIHgedggnNpD94TsRBlGx9kmqML8bQ+LwkeAUXX+MIhUCC00Bdi6CD3
         IFKTfB5LBd9IeMj28xGB6AQwER9PZk2Wawxgrl70Y/5HSjUa3kSA1LJ3lnFoAY+y8Sej
         onP95/jfszcbvLzOE0k0++DmRwBqT0x59j7YqZSFW/tR18LktlQwK4It+37H4kysr78M
         IE1kwkg+Kua3UGHY02slkuWGVmCVyF/4luqlVGaH6mMkbMCf5x2qkbihq0vZYXbw3vKx
         2LCe7rC3SbaNrVQScNvBqCJvK8ZIEj7YZ/xI7GMzz3lmPIFEsZVVoZIndxevn6RbxUwz
         F4mg==
X-Forwarded-Encrypted: i=1; AJvYcCU457zDf1w0Mfz0vC842t3y3Jg0tnem/ItgwsJmcQV3+j8MSS8Jihiz8LBxfCdlSjHHYCUL8QJ/jPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCx5IfmHgwMc0C3MzIJZB6bNGU5nbzQRF2cKKtAE/KmeZgrU+M
	omSOe5F0lbi3q1jlSy7HElxWaiL1Jr6XkQjzXQu2eAlMNYs6TAfWF0AL6KDQvIK2mrng6zkTGe6
	qtlzjgw==
X-Gm-Gg: ASbGncssFiKEXqDiWsRe27Rs6htiVut1pwJ/QPKgA6RQOVlxJf4ykCSSDpipSRnjCe1
	F/OhFCLDlSd5W+RRi4S8ed6WeGeOL/eCWcazqZKLL5OyHXuHLpponqW+WQltHW5Dh3j3TwK/FNR
	Jpr47teFws4WL4VRI+1zvWpOLv8B+bDbTIFwnVe2LXcJzaFy0fuWD5gQLu+lKsuYuOznykqHWOO
	JzXmlUqPvTBgg6l0A6qvfUnNBWMW2SiD1pXno5Nu9GlSKGeeuLzzZ97/oS3Yfcz89zJxCcX2Hq8
	VLb9BLmRsRz+QT7Y6Ae1rdWLddg29gXF0XVzj66MgUktUTMVCHQ6vzB0K5+K8gaOnZYlj1jkPnm
	ohQyYIFdPiF0qZpuKet4=
X-Google-Smtp-Source: AGHT+IGMIyhnxOBpRJEX6Er7aFuHGlx7IjsOPsU/22tJsFaQxvRpfHKGNGHbpwt9lKzujwbyXu365Q==
X-Received: by 2002:a17:906:6a08:b0:ac6:fc40:c996 with SMTP id a640c23a62f3a-ac7bc0b0ce3mr23344366b.23.1743628515479;
        Wed, 02 Apr 2025 14:15:15 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922babbsm967784766b.5.2025.04.02.14.15.15
        for <linux-x25@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 14:15:15 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so470627a12.3
        for <linux-x25@vger.kernel.org>; Wed, 02 Apr 2025 14:15:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV8ULHwPXYiW6mVWDxT89UEWkxWfC0/z01k5MUgyjQhgNPDgo8FRxeNNPUAGKiuYxAAeQsnBJYjjO4=@vger.kernel.org
X-Received: by 2002:a17:907:9409:b0:ac7:970b:8ee5 with SMTP id
 a640c23a62f3a-ac7bc126208mr19593966b.27.1743628091735; Wed, 02 Apr 2025
 14:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z-sDc-0qyfPZz9lv@mini-arch> <39515c76-310d-41af-a8b4-a814841449e3@samba.org>
 <407c1a05-24a7-430b-958c-0ca78c467c07@samba.org> <ed2038b1-0331-43d6-ac15-fd7e004ab27e@samba.org>
 <Z+wH1oYOr1dlKeyN@gmail.com> <Z-wKI1rQGSgrsjbl@mini-arch> <0f0f9cfd-77be-4988-8043-0d1bd0d157e7@samba.org>
 <Z-xi7TH83upf-E3q@mini-arch> <4b7ac4e9-6856-4e54-a2ba-15465e9622ac@samba.org>
 <20250402132906.0ceb8985@pumpkin> <Z-1Hgv4ImjWOW8X2@mini-arch> <20250402214638.0b5eed55@pumpkin>
In-Reply-To: <20250402214638.0b5eed55@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 14:07:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
X-Gm-Features: AQ5f1JpKVAIlc4pALP5yKNCr8F3ijIqVBIOCCdqoIfNZomenel-ajZbKWJ5EdvE
Message-ID: <CAHk-=wi7p9bKgZt1E1BWE-NjwSRDBQs=Coviiz0ZTQy9OhHvPg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] net/io_uring: pass a kernel pointer via optlen_t
 to proto[_ops].getsockopt()
To: David Laight <david.laight.linux@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, Stefan Metzmacher <metze@samba.org>, 
	Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Karsten Keil <isdn@linux-pingi.de>, Ayush Sawal <ayush.sawal@chelsio.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin Long <lucien.xin@gmail.com>, 
	Neal Cardwell <ncardwell@google.com>, Joerg Reuter <jreuter@yaina.de>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Oliver Hartkopp <socketcan@hartkopp.net>, 
	Marc Kleine-Budde <mkl@pengutronix.de>, Robin van der Gracht <robin@protonic.nl>, 
	Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, 
	Alexander Aring <alex.aring@gmail.com>, Stefan Schmidt <stefan@datenfreihafen.org>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Alexandra Winter <wintera@linux.ibm.com>, 
	Thorsten Winkler <twinkler@linux.ibm.com>, James Chapman <jchapman@katalix.com>, 
	Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>, 
	Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Remi Denis-Courmont <courmisch@gmail.com>, Allison Henderson <allison.henderson@oracle.com>, 
	David Howells <dhowells@redhat.com>, Marc Dionne <marc.dionne@auristor.com>, 
	Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, 
	"D. Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, 
	Wen Gu <guwen@linux.alibaba.com>, Jon Maloy <jmaloy@redhat.com>, 
	Boris Pismenny <borisp@nvidia.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, Martin Schiller <ms@dev.tdt.de>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, linux-hams@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org, 
	dccp@vger.kernel.org, linux-wpan@vger.kernel.org, linux-s390@vger.kernel.org, 
	mptcp@lists.linux.dev, linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-afs@lists.infradead.org, tipc-discussion@lists.sourceforge.net, 
	virtualization@lists.linux.dev, linux-x25@vger.kernel.org, 
	bpf@vger.kernel.org, isdn4linux@listserv.isdn4linux.de, 
	io-uring@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 13:46, David Laight <david.laight.linux@gmail.com> wrote:
>
> The problem is that the generic code has to deal with all the 'wild stuff'.
> It is also common to do non-sequential accesses - so iov_iter doesn't match
> at all.
> There also isn't a requirement for scatter-gather.

Note that the generic code has special cases for the simple stuff,
which is all that the sockopt code would need.

Now, that's _particularly_ true for the "single user address range"
thing, where there's a special ITER_UBUF thing.

We don't actually have a "single kernel range" version of that, but
ITER_KVEC is simple to use, and the sockopt code could say "I only
ever look at the first buffer".

It's ok to just not handle all the cases, and you don't *have* to use
the generic "copy_from_iter()" routines if you don't want to.

In fact, I would expect that something like sockopt generally wouldn't
want to use the normal iter copying routines, since those are
basically all geared towards "copy and update the iter".

           Linus
