From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [net v3] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Mon, 3 Aug 2020 10:25:23 -0700
Message-ID: <CAJht_EN-Ko9qZDzGsQu_S5sDxUSbddwGzi3NC+m-A55tp0EaMw@mail.gmail.com>
References: <20200802195046.402539-1-xie.he.0141@gmail.com> <CA+FuTSee5EhrH4FgkWFnAPH9o9O6inh3f+7+qJKJW6PtQw=SAg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lw7rwZegr3T32+VUPFe8rZDJDj3LjT8WVDyoLJKiqHY=;
        b=SJamImsSC+3Pfe9dFQmZwXGRoUQ5ZFXHYSRfM1CvO1mvpB6V1vxkJ7oi0yxdhbG7g2
         tRQ9yGOWJRnRbY4wKY+l2a3YGtpgEjLb8DSlDZ9wH+17h7cO/SRzg/mS06+AuW9I0TUb
         /WsEmvQ+cYRv1OW0FFArEC7WpEGw5BLHrbsgulteCd4Uxyx9LfPbEcXn11B1UfPgMHe+
         h7Oj4vv7UhJLm19MQQlM6T4P3qN/VhK6xQz8O9cibPvTpzSl80x4eSbCVjnouKkxFnpP
         swFVkAMMxFEjJh3fLdz6mbf5fY+D1kowix+wOmE7boicU6xPmUQ/TDGXTYcG5BYCnyDR
         6T/A==
In-Reply-To: <CA+FuTSee5EhrH4FgkWFnAPH9o9O6inh3f+7+qJKJW6PtQw=SAg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Brian Norris <briannorris@chromium.org>

Thanks!

On Mon, Aug 3, 2020 at 2:50 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> It's [PATCH net v3], not [net v3]

Sorry. My mistake. I'll pay attention next time.

I'm currently thinking about changing the subject to reflect that we
added a "skb->len" check. Should I number the new patch as v1 or
continue to number it as v4?

> > +       if (skb->len < 1)
> > +               goto drop;
> > +
>
> Might be worth a comment along the lines of: /* upper layers pass a
> control byte. must validate pf_packet input */

OK. I'll add the comment before it to make its meaning clearer.

> > +       dev->hard_header_len = 0;
>
> Technically not needed. The struct is allocated with kvzalloc, z for
> __GFP_ZERO. Fine to leave if intended as self-describing comment, of
> course.

Thanks for pointing out! I think I can leave it as a self-describing comment.

Thanks!
