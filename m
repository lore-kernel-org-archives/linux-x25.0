From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Tue, 4 Aug 2020 02:48:42 -0700
Message-ID: <CAJht_ENFwn82PEr=dtCzB=0QU=4pstNyGr_nFBb6Xjhg4fLGXg@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_EO1srhh68DifK61+hpY+zBRU8oOAbJOSpjOqePithc7gw@mail.gmail.com>
 <c88c0acc63cbc64383811193c5e1b184@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hg8Qv9n5WNyPEJBzVokQio7quoYDQddeKfpiH64yPFA=;
        b=LMbQEkRcjUfHXw8ytwWW0WO3GgVrO+i3HjZUS94+ApzAkYhajuff/4eZFLZmbSK4bC
         d/rT8MUtyRDXp/FQCikE48qmLGZOY66FZGnzVa6NpN5/9VocD8dS/DwSCwzzw96XAx/C
         CR+oEZC7RAROP2FRut9Zv42SjP9g0OVKnm0IJD0+oG10HEaeYuBARF9MTNnReS3sM3PK
         Uc/6K11QUi1bdbCGFSF34Dv04lcHQOcn1nfuJ0Ts9NrcSxYkXAurIO3l1tXTKUp8VJs8
         dUjWK3xu7O7PT7JwOKEb/Tjydd2ogN5DyqU3RpsFdCA4zImBN9xCZW6GX16CScHBPdBF
         bgbw==
In-Reply-To: <c88c0acc63cbc64383811193c5e1b184@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>, Willem de Bruijn <willemb@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

On Mon, Aug 3, 2020 at 11:53 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> I don't like the idea to get rid of the 1-byte header.
> This header is also used in userspace, for example when using a tun/tap
> interface for an XoT (X.25 over TCP) application. A change would
> therefore have very far-reaching consequences.

Thank you for your comment! This is very important information to me.
Now I think it may be the best to keep the 1-byte header so that the
kernel interface can be kept unchanged.

> BTW: The linux x25 mailing list does not seem to work anymore. I've been
> on it for some time now, but haven't received a single email from it.
> I've tried to contact owner-linux-x25@vger.kernel.org, but only got an
> "undeliverable" email back.

I was suspecting that it was not working, too. I CC'd all my patches
to the mail list but got no response from it. It appears that you were
not able to receive my emails through it, too.

> It would be great if you could add me to CC list of all versions of your
> patches, so I don't need to "google" for any further related mails.

OK. I'll surely do that! Thank you for taking time to review my patches!

> So, what's the latest version of the patch now, which you want me to
> review?

It is at:
http://patchwork.ozlabs.org/project/netdev/patch/20200802195046.402539-1-xie.he.0141@gmail.com/

Thank you so much for your review!
