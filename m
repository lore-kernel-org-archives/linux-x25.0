From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net/x25: fix restart request/confirm handling
Date: Thu, 10 Dec 2020 01:31:50 -0800
Message-ID: <CAJht_ENaD2N8UHOXYsFGzzRsf=yVqd7RsqDG3p62NAHagnwCGQ@mail.gmail.com>
References: <20201126063557.1283-1-ms@dev.tdt.de> <20201126063557.1283-5-ms@dev.tdt.de>
 <CAJht_EMZqcPdE5n3Vp+jJa1sVk9+vbwd-Gbi8Xqy19bEdbNNuA@mail.gmail.com>
 <CAJht_ENukJrnh6m8FLrHBwnKKyZpzk6uGWhS4_eUCyDzrCG3eA@mail.gmail.com>
 <3e314d2786857cbd5aaee8b83a0e6daa@dev.tdt.de> <CAJht_ENOhnS7A6997CAP5qhn10NMYSVD3xOxcbPGQFLGb8z_Sg@mail.gmail.com>
 <CAJht_EPj-4bv6D=Ojz5KCbk0NTVfjRyEA3NmMw7etxrq8GKu8Q@mail.gmail.com> <458f89938c565b82fe30087fb33602b9@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VYZF6b0eAf0D2UpGn/w+5r6w0iBI6SckFUc4KZtxYx4=;
        b=GVbKgxRpIEs8XnfazLphorUnKvkhAwtOtzBGMkORRuLBGzivBRbhyeouw5NbFmvjg8
         0jLQHOCcMrlZl0i/H+b4dCCr6IozvyUIiFzADzIMTOHEQ/21DjUVDKxGM3Xjldl5aaks
         51TMQ44PaAK/FjHA0Df9Qxh4rUuiBDJLGQEWHkDNK4dn9howBkrnLYgxn8a6DnA/vzzD
         PcUywu3uqdDuFFOsUK3teD8hma8lg4wsLl4dX7edxBQb7wz4tWIR88Fk+T3LYMUDmKgQ
         tP4h4FcAuHJwMBwV2AhMXSydvdE9/FVDsiagfJX++sqICT/FYkO0rdnxSw9b1HoVjPqH
         XNuw==
In-Reply-To: <458f89938c565b82fe30087fb33602b9@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 9, 2020 at 10:27 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> > Hi Martin,
> >
> > When you submit future patch series, can you try ensuring the code to
> > be in a completely working state after each patch in the series? This
> > makes reviewing the patches easier. After the patches get applied,
> > this also makes tracing bugs (for example, with "git bisect") through
> > the commit history easier.
>
> Well I thought that's what patch series are for:
> Send patches that belong together and should be applied together.
>
> Of course I will try to make each patch work on its own, but this is not
> always possible with major changes or ends up in monster patches.
> And nobody wants that.

Thanks! I admit that this series is a big change and is not easy to
split up properly. If I were you, I may end up sending a very big
patch first, and then follow up with small patches for "restart
request/confirm handling" and "add/remove x25_neigh on
device-register/unregister instead of device-up/down". (The little
change in x25_link_established should belong to the first big patch
instead of "restart request/confirm handling".)

But making each patch work on its own is indeed preferable. I see
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
says:
When dividing your change into a series of patches, take special care
to ensure that the kernel builds and runs properly after each patch in
the series. Developers using git bisect to track down a problem can
end up splitting your patch series at any point; they will not thank
you if you introduce bugs in the middle.
