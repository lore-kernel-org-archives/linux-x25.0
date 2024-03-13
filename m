Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E8735894
	for <linux-x25@vger.kernel.org>; Wed, 13 Mar 2024 14:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710339220; cv=none; b=ulr4oiZy/YEP0x0UoMcaTOrA2irtqz7po0xcR+Xq9hOGdpeGzKemKJxV/iRVBxvo6GPddKBAHUxKYP3apbmQKq+VMkvjHk/cVmmvS4PrbVDtGB1H1D5fNuGDUcNY9+AJnmAO392EIVnymL1IU/lxDXOyWnShGq/RnUTATYyFEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710339220; c=relaxed/simple;
	bh=1WBBRYOsC8dbpVv7/4w7KnkU6Wkm46ZVmyWNZS65FKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fICb4zxaAH3ZJnxosrgwtk3UcjyFcPNPnlljIX9Mo+t2Sohr/H+Tf0+D7gNiCvyJiUUjwq7VBitPbaBjOz2B58W6B9AN1tvolt1HZfZsAL6f2fa3gvwrk8vKbAzlc0oK7zo+Zi52AwxSwTWNk+V7g4UnJxWNeTeblMF8C9prQuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KIs5qeq9; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KIs5qeq9"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412d84ffbfaso87585e9.0
        for <linux-x25@vger.kernel.org>; Wed, 13 Mar 2024 07:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710339217; x=1710944017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4S7rzA3Q12yyyNj0yHPuw2b6cR1SlWu1XVF5K5zh5cM=;
        b=KIs5qeq9Gn5BHHH3Bc84KXKzVEfdrKZSofpNy5gIUD0p83xEfdnRyD7W+/P6os9Flj
         NQ0NYKX0bfJuHj8nL9+Mo0Zu/PciH8FSYqjWkzS6eaZEmIWYcybX8pmRQX+d2y8TalMC
         iFYeyPun/VdIUMVSxKF4Klm3StcQNt7SZXu7Xb+jEcM8o5yKGiR9yFW3opmW1koxGTgv
         txk21ZraikygMkGi43ZEEZrbHkak2MDavjvuq33Ww2Jx2vYW7fqP+zcuYlqG/DXe+xhA
         8Ko9t2Wh4Dq8TxZaKaocILC0btyL5G2b9xeLVIbHnKP1RA3HztSgy9vxPAED2LsLFNqC
         1OuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710339217; x=1710944017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4S7rzA3Q12yyyNj0yHPuw2b6cR1SlWu1XVF5K5zh5cM=;
        b=wclmbjFj5smyItwZf/JUIZbno3mmCxligoA/UxPH+njlpxdgWgJLgDdxTavgcmdzdr
         O3+X0FNOGzEfUYdFdoHs2ML+/OiUW2fO7z3FhyzUAZfOYUn8wJYh/gumtfD+JOy5hpXz
         1w1An7SYqqneIkofBTn09ocBOW55p/kIThAOf9lfUXA+h+m75jJmqQ2J2zEhRS4+UgNZ
         VkjEBpRraZtuVd6SgHvnABx3669GWF94z5ToW3UaulI5+WPXyNXkwBqOiikox03yEdhm
         1jea2CUBnFIJNBCRjC+Y+F2+v2tOqvZXgSD6hUtt5BXtp7K0J/KH249WsR9uXgzqHz53
         POAw==
X-Forwarded-Encrypted: i=1; AJvYcCUgZUm8XUBAV9m35v4EfgRSF2ThUK1bSlikFMeb9Lxpny7ncFBU+dz7xA+rwK4t48OVEpLIp8Zb1bgVWQJ4mDFB0TAdUYp7ayqi
X-Gm-Message-State: AOJu0Yw84aOGND7XpNIJU2lzGpMD+V/CfkcKwdPKB7ZxYxufHRgCRqRG
	pgkJKmNbVVWf9af1hUayN2KnqexnVHMOZ8wewfwm6TlnVvuOyonQuXD8QXOBx/SyxYI2e4o0iI4
	DEpY+ZgRtxfJYSx4cQNmmNYiVSAV3F3Xt1lcUKGq+gRENCI3pKJDw
X-Google-Smtp-Source: AGHT+IGWezW5K3xlgUgzmO8FPKgclsOf/ynFUCVJY/rj65VqiXhUcA0s6QDTTr3YLAp7kN7pUTc5FTJk9XZpVw0QVC4=
X-Received: by 2002:a05:600c:5006:b0:413:e6a1:81b5 with SMTP id
 n6-20020a05600c500600b00413e6a181b5mr145981wmr.7.1710339217325; Wed, 13 Mar
 2024 07:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313132214.48716-1-m.lobanov@rosalinux.ru>
In-Reply-To: <20240313132214.48716-1-m.lobanov@rosalinux.ru>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 13 Mar 2024 15:13:25 +0100
Message-ID: <CANn89iLfExAa7T+0bjyBHdbwrF-77SF+QaMHpy-tg7dYEp0YKQ@mail.gmail.com>
Subject: Re: [PATCH] x_25: Adding a null pointer dereference check to the
 x25_accept() function
To: Mikhail Lobanov <m.lobanov@rosalinux.ru>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 2:23=E2=80=AFPM Mikhail Lobanov <m.lobanov@rosalinu=
x.ru> wrote:
>
> To avoid the problem of dereferencing the null pointer in the x25_accept(=
)
> function, you need to add an additional check that the pointer skb is
> not equal to NULL.
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosalinux.ru>
> ---
>  net/x25/af_x25.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index f7a7c7798c3b..91bc5994cef6 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -896,7 +896,7 @@ static int x25_accept(struct socket *sock, struct soc=
ket *newsock, int flags,
>                 goto out2;
>         skb =3D skb_dequeue(&sk->sk_receive_queue);

skb can not be NULL at this point, we hold the socket lock.

Otherwise the bug would be in x25_wait_for_data()

>         rc =3D -EINVAL;
> -       if (!skb->sk)
> +       if (!skb || !skb->sk)
>                 goto out2;
>         newsk            =3D skb->sk;
>         sock_graft(newsk, newsock);
> --
> 2.43.0
>
