From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Tue, 4 Aug 2020 03:07:40 -0700
Message-ID: <CAJht_EOeCpy_SLKk2KXJHBj79VCujUZWiZou_BDfMr+pVWKGPA@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_EO1srhh68DifK61+hpY+zBRU8oOAbJOSpjOqePithc7gw@mail.gmail.com>
 <c88c0acc63cbc64383811193c5e1b184@dev.tdt.de> <CA+FuTSeCFn+t55R8G54bFt4i8zP_gOHT7eZ5TeqNmcX5yL3tGw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oJdxWGQYUK1/0Tk5To4OdiSJhwKCWBDTC5eP+NtdeJU=;
        b=Uv2wL9/B0Zh+y88bUQ/S771LAewriGVxI8lSuTGvu1TBIvGZ+3Gc90rSJCs60kBV0e
         4/7UfBuaNQa/VmFJagebEKIf/bMHZhakzZf1tWahBg3byESGrXKdJKQfwB2W/S1FzU5B
         HXVG4XnprmC6Ni1seBLNhDRza+3ouyewoA99x8V+OiQGCojsjcoXg4JlaHI1jYx3aG8a
         b/4CwrytoOOAxzBPvcsh7LjTciaGvcPoFqUQ5K27z+2B0ZRRgLS1VIOmEHvdJSY8byNh
         rHCmtElC//YwQ4qwUusX9LJhPgPwbqQZXl8xCM/MUaECiQT7E/8Bi1ywlSm1Isn23tRw
         5huA==
In-Reply-To: <CA+FuTSeCFn+t55R8G54bFt4i8zP_gOHT7eZ5TeqNmcX5yL3tGw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemb@google.com>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

On Tue, Aug 4, 2020 at 12:06 AM Willem de Bruijn <willemb@google.com> wrote:
>
> > BTW: The linux x25 mailing list does not seem to work anymore. I've been
> > on it for some time now, but haven't received a single email from it.
> > I've tried to contact owner-linux-x25@vger.kernel.org, but only got an
> > "undeliverable" email back.
>
> That is odd. It is a vger hosted list.
>
> I'm not subscribed, but indeed the spinics archive ends in 2009 and
> the other archive link resolves to something that is definitely not
> X.25 related.
>
> http://vger.kernel.org/vger-lists.html#linux-x25

Maybe we could contact <majordomo@vger.kernel.org>. It seems to be the
manager of VGER mail lists.
