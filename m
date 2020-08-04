From: Willem de Bruijn <willemb@google.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Tue, 4 Aug 2020 09:05:49 +0200
Message-ID: <CA+FuTSeCFn+t55R8G54bFt4i8zP_gOHT7eZ5TeqNmcX5yL3tGw@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_EO1srhh68DifK61+hpY+zBRU8oOAbJOSpjOqePithc7gw@mail.gmail.com>
 <c88c0acc63cbc64383811193c5e1b184@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xNn+QJsZyJEIY4atBkbvkSPk2NvJPQW/iKso3++vDyE=;
        b=NzmY7W9cY2+pdV6WoPDEaVC6+5v/JHjLil+1hUMDCbQ5CrKzMBlIzcJUdbj8GqcPfD
         FW12VNde4ccGMkvFqmd+uhrrjdTDjsmGkhxxzbm/USSoi9EeCItqYXTsaohC70w2rr0K
         mED0Yj/a74t3ijgKH++93px1W4SUIuC3833/6/ojHzFtLSpDldRX0f4pRTQr5lcyUuj7
         8DPZ7OA0e15P+Vs+3rjDcSUP9vmfCfCAgy+yrJw3JDY5urdxYkdKHV2lmVqdtKw9Vpor
         rGcrkwFRxx8qaGdwIZiCWtOPbNs6hvrvD88vhaz1HPYl8BPpUpdqLMVbJHStNf7c/ZzA
         V2og==
In-Reply-To: <c88c0acc63cbc64383811193c5e1b184@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Xie He <xie.he.0141@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

> I don't like the idea to get rid of the 1-byte header.
> This header is also used in userspace, for example when using a tun/tap
> interface for an XoT (X.25 over TCP) application. A change would
> therefore have very far-reaching consequences.

That's no longer the plan of record.

> BTW: The linux x25 mailing list does not seem to work anymore. I've been
> on it for some time now, but haven't received a single email from it.
> I've tried to contact owner-linux-x25@vger.kernel.org, but only got an
> "undeliverable" email back.

That is odd. It is a vger hosted list.

I'm not subscribed, but indeed the spinics archive ends in 2009 and
the other archive link resolves to something that is definitely not
X.25 related.

http://vger.kernel.org/vger-lists.html#linux-x25

> It would be great if you could add me to CC list of all versions of your
> patches, so I don't need to "google" for any further related mails.
>
> So, what's the latest version of the patch now, which you want me to
> review?

http://patchwork.ozlabs.org/project/netdev/patch/20200802195046.402539-1-xie.he.0141@gmail.com/
