From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC v4] net: hdlc_x25: Queue outgoing LAPB frames
Date: Thu, 18 Feb 2021 12:06:06 -0800
Message-ID: <CAJht_EPZ7rVFd-XD6EQD2VJTDtmZZv0HuZvii+7=yhFgVz68VQ@mail.gmail.com>
References: <20210216201813.60394-1-xie.he.0141@gmail.com> <YC4sB9OCl5mm3JAw@unreal>
 <CAJht_EN2ZO8r-dpou5M4kkg3o3J5mHvM7NdjS8nigRCGyih7mg@mail.gmail.com>
 <YC5DVTHHd6OOs459@unreal> <CAJht_EOhu+Wsv91yDS5dEt+YgSmGsBnkz=igeTLibenAgR=Tew@mail.gmail.com>
 <YC7GHgYfGmL2wVRR@unreal>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dMbJmdRaY4vfG00koCsvkPR/U7WAiUX8hNZHDlwWe28=;
        b=YsuE22azdu18HaTMEtOCgZygSoSSxe/L+KLqHQGnitgtAooyq/dMbQrh2WSPSOwVrn
         G8ENzrPqhXaMiT30v+xvukAHiadnP8CWL/Er/IqoLAV/3Z5ulNChCeNv4csJJEdp/tpX
         qTY8hsXpkLTqn4nQAJoGyBN0e1KQb5mvhALIaFjAAEf6BihjuxNwIxRVdfVmUlJzLXdn
         squ/Ein7iMtlEjhliP3u5gw34EECZwaNijX53cCqQD4g+itUX2RcKIjSBySgKikuZSUz
         0DN5iklLyuWA/YmfF54OE+UjuZDtWFzhu33ZgbXa2XrC78UTeVZtSdfOMjtsro4JV8Py
         NCsg==
In-Reply-To: <YC7GHgYfGmL2wVRR@unreal>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Leon Romanovsky <leon@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Krzysztof Halasa <khc@pm.waw.pl>, Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org

On Thu, Feb 18, 2021 at 11:55 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> This is how we write code, we use defines instead of constant numbers,
> comments to describe tricky parts and assign already preprocessed result.
>
> There is nothing I can do If you don't like or don't want to use Linux kernel
> style.

So what is your suggestion exactly? Use defines or write comments?

As I understand, you want to replace the "3 - 1" with "2", and then
write comments to explain that this "2" is the result of "3 - 1".

Why do you want to do this? You are doing useless things and you force
readers of this code to think about useless things.

You said this was "Linux kernel style"? Why? Which sentence of the
Linux kernel style guide suggests your way is better than my way?
