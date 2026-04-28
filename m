Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E163A6B7F
	for <linux-x25@vger.kernel.org>; Tue, 28 Apr 2026 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368820; cv=none; b=Svkt827rAdTKBlqxHpw4W1ZULwqypAuN2uiaNttiFnPQdmGNIKO95iI/YEzG7ciJkWfiNBn0SKi9Vnz50VLh6dStIOmFlUjFs7ajdAIC52rgcM9sUeB7YEOTlHQZhlEsTGKKlBc+UfWHN8oEEzbShmS160IJCs+FuXy9pY304yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368820; c=relaxed/simple;
	bh=WZ0dv++aH+AeLwkvbNXxLqu7wJ3mA6GpS63WG1N27Uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nh2BvYWhRpdzum8EAl8Ghy/OzD39PMHV31EuE2i5Gu6B7tOoQuGFgteBm1iitXLSsdemE3KOfgs8rHml6F6ZLRuk6YYjCBxIrTDEEv2bN5bKF3KYNw+EHItRGz7CRJv/IBNjmCBC0StImUwtdgKmZt34HzQuJnms8RB4fEk9RpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bb3c4d8cc29so312391266b.1
        for <linux-x25@vger.kernel.org>; Tue, 28 Apr 2026 02:33:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777368817; x=1777973617;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Al22kA6RCf7FSEzj29cZLSkjdM9EgXxihmBX7/SeSVI=;
        b=cmBBwZOG+N2/M3C40jcc5Ed3/AK0PbMrHbX1wztBs5WmY1PO8HfWtf2qh3T0jvkmzY
         MIyds+GcCF9jur8hcDeMzbhEkUqcrW475E3eTElhBoZaxY3USGleEwS6GA13Mq9nkpp2
         KbGSuDBH+GxoxK+mvWWRI7ZXuwD7CI3aMDHlF8RaLFop5rqwE6KA9wTMLVwf9dKgtFgD
         Tc65Q8MqzOXX4vvZd8QGrNdwo23pCwAMTNsY2prKZD+KT6cLkslce+d45AvCxfQx8+/r
         Yi4SYUdHZc1uQf2sracmRLTRs9HkkXGoJqZHFxS07pl9XkY3ORFPRC5gMXyv87/mVrmp
         730Q==
X-Forwarded-Encrypted: i=1; AFNElJ/FsWTgamhku0Q8Y+sBopVQ2Iaw+hMlj40PhrTlXruA8bgUA/c9iqeUpIHs33nH5Zwyp7iC9XdTvpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyChv7OGK4d8mH4okT3wfzbi+dVK7eVhO9UUig1ylSEvpLnKa
	Rf7Fg1+JreNiULJY8NM0KCP8eO4JJ6N95q2e7lrbywnynynFwAy+xZopkSBymwt0C7E=
X-Gm-Gg: AeBDiesv+yjIoU/dCmCBIBxuOgfiEFh96WEbXWIZhuacELmNvJUTN04H23a+rDMpUTj
	n7kYKzqu8ORxKRkFrxk8gxMwi5qOD8REtDXnmRG2LUTnUbK2EKAJWFp/bAHD45/1fNyrk5ow9+T
	+5NnMG/m9Z2XSbBGlIR3L03uKNlajlXX0dD9PZ3K/+suStyY3U9xFUuabEW7OinC4E0mcavd1fU
	l+PZS9u6GalSeOWrBIYER0kqpYgQQISYLpugGZB3ugJsUjxwwcvS+McQvvTUkQ5up2RQQgQdrm/
	uTQcnJuPab1f41UbY5/z4WPWNplsRopCxR7cnquAqGxkmDgp02XaS3CcvMqknGrzMhfL9fH0duc
	G0u7/Je3mHN6CfaQQzkZy/BMjtiRJnIlkgyofuJQNplfRy/XOcK+krl/o4U3ULU3tQHcOhNJ+//
	XCgmKwBceoWcr/vDNRrbHtuuvl4I6DNA0elr6Gomtu82GRrgHAgIjtzkKILexm2tlkwwpVL08=
X-Received: by 2002:a17:907:96a2:b0:bad:d21f:904d with SMTP id a640c23a62f3a-bb804728021mr128212766b.31.1777368816888;
        Tue, 28 Apr 2026 02:33:36 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80902237csm73765966b.24.2026.04.28.02.33.36
        for <linux-x25@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 02:33:36 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65c4152313fso15353603a12.1
        for <linux-x25@vger.kernel.org>; Tue, 28 Apr 2026 02:33:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ92MjzeZQSB2Dhx2clyprKXbV22jrk6Kg2sBzzlGmzr+gNpRvgBWn2I60mU+71KQVU+nmYJBd1RDvs=@vger.kernel.org
X-Received: by 2002:a05:6402:5056:b0:676:d8a1:7a04 with SMTP id
 4fb4d7f45d1cf-679bb09a4admr915149a12.23.1777368324094; Tue, 28 Apr 2026
 02:25:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1777306795.git.chleroy@kernel.org> <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
In-Reply-To: <c73b90236f2810edd47c84edd2a8d8e8e0c816da.1777306795.git.chleroy@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Apr 2026 11:25:11 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
X-Gm-Features: AVHnY4JEWBVPw4tSjHgbQTia8gZd2WGJ1sv6qLdKJbtvs4hms1blpvc35yb0VWw
Message-ID: <CAMuHMdUvTBWoDN_wUo2n8-gkoheJ+-rbwew53OvoAwo8G5n1qg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 4/9] uaccess: Introduce copy_{to/from}_user_partial()
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Yury Norov <ynorov@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, David Laight <david.laight.linux@gmail.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-alpha@vger.kernel.org, 
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

Hi Christophe,

Thanks for your patch!

On Mon, 27 Apr 2026 at 19:18, Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
> Today there are approximately 3000 calls for copy_to_user() and
> 3000 calls to copy_from_user().
>
> The majority of callers of copy_{to/from}_user() don't care about the
> return value, they only check whether it is 0 or not, and when it is
> not 0 they handle it as a -EACCES.

I think the "a" can be dropped.

> In order to allow better optimisation of copy_{to/from}_user() when
> the size of the copy is known at build time, create new fonctions

functions

> named copy_{to/from}_user_partial() to be used by the few callers
> that are interested in partial copies and need to now how many

know

> bytes remain at the end of the copy.
>
> For the time being it is just the same as copy_{to/from}_user().
>
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
