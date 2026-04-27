Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075373A1A56
	for <linux-x25@vger.kernel.org>; Mon, 27 Apr 2026 21:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777326404; cv=none; b=sQ9uvWfjvHlxijQNgRG5QTLebTl7Rrr5f3Kpd2RTra++hbL9yPqPbADYKxmxwCm09ThACSVyT3/lhC1/+IocTy+MGNzXCCH3M05x9mSc3pkLYNI0IIH04gjGZlwrJgLDMjpSUgDFlG0GJ3Y439NvrKng6TTeylnu5qbefojem+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777326404; c=relaxed/simple;
	bh=i/k46YQbNxc6jmDhpSrBTZQploRe2hY24KQV/uGHVj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sSXJSm8toldX6Jw7YfZ+E25ZA/3DGM0bdZKTcv5TmRpDSmNP+Uop8uJvCi5HuCKyDrVpLXCjYDyqOp7jOMKDbrRYQ4A+vuyxtC3QRT4h7f3Q5yEO7eec+LMg5IULFQWxr52nmTpE4VQSKk0cD7YLIeDGlso01HUnnu+Eypx/olw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BXCpH8w7; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BXCpH8w7"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-678a526f374so6520669a12.0
        for <linux-x25@vger.kernel.org>; Mon, 27 Apr 2026 14:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1777326401; x=1777931201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=BXCpH8w7bCGSZVWmx06UFIcXbB56vyrK4bg/odWGlhAZW6Kxi4ovd1YpaCavhC5ZIU
         O7KnVKZUp4Hc1v2YQ5bsPmnaqDD3pa1MhspOQQDgBzsNROzCMnQ2929yWP1s9kZWCJIf
         1CF1d9EibPkDaa1MiDRzC5krGOpXh+FXPrWCE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777326401; x=1777931201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DjF1Jdn4Kp6xFyaBmAP2391GfFF2q7kuOVlruTChM90=;
        b=I5z/mWUwvp+7YqwGilD001G15rELxyofKO5rI+ATbJTXulfbPcORn6W9Dd0zdwTvkK
         S+wnEJSVZIhnaamJ8czBH83Otj/kQrhYnjhvlXhkMamUKZYurnb6q7Q07EtQ/8bbbOwn
         mbWZS/grCo8fLLM+laJ426CW/GUNbl9CF7hk41XewRkND2KLANZjvYk6slvDEYDgadTG
         k7tMizjpXX6olwoh2cDqDGnfevxZUY63pRo06/SHNfWuNM9EiHKZTwqWf5kPIscR8KLe
         W160UVCJ4t3u5BpLHD7hulT0RvW7qizsHsPZ2SbYe3dRrxTzE0kOw7T4nyceBJ/4z4Ja
         ajLA==
X-Forwarded-Encrypted: i=1; AFNElJ+H3ONdG5zPnrHPwsDA+txDvkNCz1nz9Ox1WuJBfqpeCkQ6xWIgnzZ6hirJZOqdCrWdAo+mqKfhkrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Oa3hPQpVOsnmlezgF2cLOKMmls4byn3ZVaiR88JsYOae6rwG
	j/J82WvsNVlGxfupSPpXnJR34mnF/Z22gce0g4qGB4iVXoIEtjmTIUprmUP+PkZ2pRcmu1nwBXW
	2j2Dd6yFDxA==
X-Gm-Gg: AeBDieufT0tGFdXaHyEUXq6/+FOGWPMFUHWpDa9fXnxojCb2cVKsWM0cfVvviG7Jj7A
	+//s9LZaeQFloZkTZ1BvNFq5Uz8BTMs03YC6IRG68t7wK3w0oQqTit5dr+iV/iZj7tuoxSg5MOY
	mJBzEoJpyVUfEwVP3Pum7sMT/6RTT7KeO5NyqP0trm05gp6y4k4g6wxqFuACdWEo3zv4r1eF07r
	7SmBuDJ93Wwr0caUsN7P/FURqz/pLj9XLT/msIEz+oDd//nuibb2njqL6KcztdZuL44r8aoRqnA
	AigNX4czOgrGtOiCVfa8ijkd4zt9Dd3pQ82n+dOEviR7dFrA5d89lPlo9Nrh1Tknw46cEayXXa9
	HV4unHfZBPinApNeTSqkyATYndvyoaRKDqkV+ql66JXC2ydXH6grdZ1SbLOudS2ODmiv7o+Km37
	YBsmNKgDs49m4I9tjuRgQVtPI3s8Feh6Ohoep5x598djrrCRQ/+iAfgzuqYeVLzHTHlRZKnpmZ+
	eLsfjeGCeo=
X-Received: by 2002:a05:6402:3593:b0:670:8bc2:7fc with SMTP id 4fb4d7f45d1cf-679bb04c0c0mr172029a12.2.1777326401435;
        Mon, 27 Apr 2026 14:46:41 -0700 (PDT)
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com. [209.85.218.43])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-679b68543d7sm138126a12.25.2026.04.27.14.46.41
        for <linux-x25@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2026 14:46:41 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so236939466b.1
        for <linux-x25@vger.kernel.org>; Mon, 27 Apr 2026 14:46:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+O4y2nQwRVPHnWj+ydHR7UtNh57jPRijhonHyy88M4a0eYq3gUME5LE4PkHoZC8amrVIjLD5FliEg=@vger.kernel.org
X-Received: by 2002:a05:6402:5216:b0:679:1f4f:9d30 with SMTP id
 4fb4d7f45d1cf-679bb04c1a2mr179970a12.4.1777325976937; Mon, 27 Apr 2026
 14:39:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <289b424e243ba2c4139ea04009cf8b9c448a87ff.1777306795.git.chleroy@kernel.org>
 <CAHk-=whC1DZojwdMB1=sJWG2=dsCdfyU8N6tDE1qx50HRZ-WJQ@mail.gmail.com> <20260427222914.1cb2dd3b@pumpkin>
In-Reply-To: <20260427222914.1cb2dd3b@pumpkin>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 27 Apr 2026 14:39:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
X-Gm-Features: AVHnY4I-AxqvQRk42MegvhKMp_z4sSEpEzhzpgw2GyV2bV8dezSPoI0JTlwB18Y
Message-ID: <CAHk-=wg0SGbRYhdZ1kvJUTv1HEvmRJyQauFtBGV_fMcZVF8UpQ@mail.gmail.com>
Subject: Re: [RFC PATCH v1 5/9] uaccess: Switch to copy_{to/from}_user_partial()
 when relevant
To: David Laight <david.laight.linux@gmail.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, dmaengine@vger.kernel.org, 
	linux-efi@vger.kernel.org, linux-fsi@lists.ozlabs.org, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, linux-wpan@vger.kernel.org, 
	netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-staging@lists.linux.dev, linux-serial@vger.kernel.org, 
	linux-usb@vger.kernel.org, xen-devel@lists.xenproject.org, 
	linux-fsdevel@vger.kernel.org, ocfs2-devel@lists.linux.dev, 
	bpf@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-x25@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-sound@vger.kernel.org, sound-open-firmware@alsa-project.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 14:29, David Laight <david.laight.linux@gmail.com> wrote:
>
> I think there is a slight difference in that the normal copy_to_user()
> will determine the exact offset of the error by retrying with byte copies.

I have this dim memory that we decided that you can't reply on byte
exactness anyway, because not all architectures gave that guarantee
for the user copies.

But that thing came up many years ago, I might mis-remember.

            Linus
