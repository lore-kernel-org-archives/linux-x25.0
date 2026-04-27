Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA2F3A0E80
	for <linux-x25@vger.kernel.org>; Mon, 27 Apr 2026 21:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327088; cv=none; b=QHnbC9sfXCq22ouxqxGA71bKKVsIRhmw4LTHW4+5yW455J14U15GIFQT4zGsmmQnsd/Y2chOQBybiLsWtpVcOpDSHv4uxoP87SR13UWRSqGi9/RJD+tEGqrkzlPyfOpjNjyFeq7gne8xLJUqUWL58ni5sPZ38WbAFzRdgPNISSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327088; c=relaxed/simple;
	bh=7P7VU36hQu4iMsGekLZKiPL3rBFQOW0TOaXA+fXfycA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FZ6CX1kKou7BVkYvCk9Kd+qKJOQE/Io7TrWtajWYnmjPqinfpzKXUm8afvBlzNxAOD2bNRHLTd1850tZb5F545trPL0HaqHgzz9+RPzqyzrcdVt5nxjWl5MlntToP6wEy42xYtEIixbqFSwrDL5ouRnymkxJS6B0BqsVlB9CNos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V9o0EnHx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V9o0EnHx"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba7a1cc0380so1770650166b.2
        for <linux-x25@vger.kernel.org>; Mon, 27 Apr 2026 14:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777327081; x=1777931881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=V9o0EnHxNm/psDoVzwq+vua/UR3hK6miBjXQkQwk6Sd2shZbJuC6YZDsrg/y2x2ZTJ
         CNeUjfSJv+RDd7Smt/ZTX9JU/ppBXoXuAuLP/cee7Aklmg0tRXz1J/hNrJK3b6lXHcdp
         2QW+9JeWJ9dFw6NMvGGbjvi6DnZjLJmZmmLJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777327081; x=1777931881;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eodThUBj1SnOvacXe/3ftYxEWQMFbYqc4B0FCa9Alx4=;
        b=YcXi/NpOFGu7XaZ3K4LLcDpoM3TLWInu4dEv6jqB9sVJEOXQL3RFN4AQust3HJOYlz
         mWNPInaCtPvRTPnguClcwjLQE8DSU3V4MqB6pUQmzCwoqgsb+TyUl7X7veEb38o/IgSq
         GT7amLgLPvQNlhgpTEQ4BKswAjlPUUiTaEslys4pSu1AWFelsI/TaQf5wD/Z4L73P6LT
         i/5IkzI/QY7m7jiYK2Je2ogzcq2RSX/rxlwWanN2Blx9ZHsVVGBJ63Avt/IjJOPbDgEZ
         XxNKl67h/4AlBiA6J8cW9qYqN9uZG6IhQwfkjzNaLsSorUptiwSjtugs8cgQdVl7qmYE
         sQKg==
X-Forwarded-Encrypted: i=1; AFNElJ+ssu/FSmwqsuxfafAVrPb7YXayjBK5yn51WNfENdSPdDO+LlKbavHxY5l51jBLoxV+Ra3bDitk4AU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcG2YY9Bc9YLRLbed8pbfU5VtCArS3LIOgywTGqXAH/wcRk4mt
	mRaHM6UxJgd6ma2dJ8BdxR4Xra/XDdIKztFd/SqwDMqjgZ3Y00CL4WC9m18El3ntMzoC37v+Chi
	k9I1Bc6k4YA==
X-Gm-Gg: AeBDietuIz289rrAskkRoiXJsRwlRXuGuNJZ6awXaADB+UNcmiAeQoPW5xghEPHhIjS
	WgnTMEjOk79Q3ITdr5q1fqBQ82TQgB+LaFT7ybdavxhxTSgGF2vf3TKQkQAITtfxqgfHecv8rY8
	w47Y1nP/0Iv/JABKwX0nK9szGxJY81ejaAWcNv2VPlWrt+8x7fEKZ3SKZ6p8nwfuNPtEGZRYCcO
	5qfpeEZ4cDqovJDss1RXojR75iMwKnHMTurryfdYhBTmEXQGnP2A8+idVg5h/PSOwk7uH6b0oBU
	jB+9EhDopfxfR8qo+f7McdszFa5WXIoC+popPT7oOg2Cz4t61gdfmajd13VhR/lhvGuIFFCi6KC
	OpIrCORw9e6tPEH/Fnw4s6Yn+lktKg6ACZsYZNi5EndGTRUAxJIGNMxIXpa0dWU3HTxZccmn1+Z
	GEP3bruxnwYIE+/3oYmM4ANmsvyFqIkSlqe50/lT36eIfwczXIrdP14UjnO66fnPRuaLr+a4Tkd
	qG3voQz6dg=
X-Received: by 2002:a17:907:1b10:b0:b9c:bc70:e928 with SMTP id a640c23a62f3a-bb80377aa23mr30519066b.25.1777327080923;
        Mon, 27 Apr 2026 14:58:00 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80b7918c9sm9993566b.42.2026.04.27.14.58.00
        for <linux-x25@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:58:00 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ba92146cc86so1162435866b.1
        for <linux-x25@vger.kernel.org>; Mon, 27 Apr 2026 14:58:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9wK2KXNFHYGX+rB2tUDnsf50KRCvjZzJz0Hzla97v5UAYKudJWMgQ6QPbNRwi1TwRER/z2jY4EniQ=@vger.kernel.org
X-Received: by 2002:a05:6402:35c2:b0:677:270f:6f4b with SMTP id
 4fb4d7f45d1cf-679bb04a8a7mr185115a12.1.1777326742385; Mon, 27 Apr 2026
 14:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <0ee46bb228d97163fbdc14f2a7c52b93d8bc34ce.1777306795.git.chleroy@kernel.org>
 <ae-j2_QirCySZD02@yury> <63a4d0f6-0eb3-48cd-9f98-bf7b223b2606@kernel.org> <ae-2yLWSGnfeTvh1@yury>
In-Reply-To: <ae-2yLWSGnfeTvh1@yury>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:52:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
X-Gm-Features: AVHnY4LQUFWo9ODz4M3q2vZC9Gn8nsdYr95Nd4ky5ERVHHxIyN_9ZXY5zjebfdc
Message-ID: <CAHk-=wgPrLy0FR3sEWBYQuNAac1axDASYMnTuPuxEU0WytzL7w@mail.gmail.com>
Subject: Re: [RFC PATCH v1 7/9] x86: Add unsafe_copy_from_user()
To: Yury Norov <ynorov@nvidia.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	David Laight <david.laight.linux@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, Yury Norov <yury.norov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	dmaengine@vger.kernel.org, linux-efi@vger.kernel.org, 
	linux-fsi@lists.ozlabs.org, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, linux-spi@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-serial@vger.kernel.org, linux-usb@vger.kernel.org, 
	xen-devel@lists.xenproject.org, linux-fsdevel@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, bpf@vger.kernel.org, kasan-dev@googlegroups.com, 
	linux-mm@kvack.org, linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:19, Yury Norov <ynorov@nvidia.com> wrote:
>
> This is what Linus said when added x86 implementation for copy_from_user()
> in c512c69187197:

Note that some things have happily changed in the six+ years since...

>   That's partly because we have no current users of it, but also partly
>   because the copy_from_user() case is slightly different and cannot
>   efficiently be implemented in terms of a unsafe_get_user() loop (because
>   gcc can't do asm goto with outputs).

now everybody can do asm goto with outputs.

Yes, it's disabled on older versions, so it's not *always* available,
but all modern versions do it. And if you care about performance, you
won't be using an old compiler.

             Linus
