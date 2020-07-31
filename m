From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
Date: Thu, 30 Jul 2020 17:55:04 -0700
Message-ID: <CAJht_EMQvNknLFXVBJdb190jg8duD5DZ1c3HcOsUbYFOa6-5TA@mail.gmail.com>
References: <20200726110524.151957-1-xie.he.0141@gmail.com>
 <20200728195246.GA482576@google.com> <CAJht_EOcRx=J5PiZwsSh+0Yb0=QJFahqxVbeMgFbSxh+cNZLew@mail.gmail.com>
 <CA+ASDXPRLqq=vxnkF4z8=xvuqOKuuoqifvsNsERWg9uYJrFXgg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J8iGGRIMcGIJb/MfOVjMyzOROeLJmT2jzu/UJuU9MvU=;
        b=kTDYJMah73Fg+QPTvP5uhTBZ3ul1KmgZTaqpWq7DOJcwvAGT3c0mctPQcF7k5gMaG+
         2quOgxPsiod+KO0OK6SnFlowjse7oq+iM0WAxSs/Zqg5fz005p6RVQ0jNAa6RkaITP2O
         UzSQk3IbtESV6RWUTNxB1JjJ1yE57kfBjUNXDFowpA25NCeLYUr+dqdUf5qhlrJnO657
         5FyCR1WXvna5gCgYpbTICjgPr0tHnSJ4XPZ+T47dzebwtAgyWbPSiQBjZl7QmqOcDHBm
         xfXp5LJl7cwr+QE/z0qISIkfCdUy3smpPSd3Tt4Wu/HQkyo9MMaKC93EaLZNvYBrd7nd
         HYQA==
In-Reply-To: <CA+ASDXPRLqq=vxnkF4z8=xvuqOKuuoqifvsNsERWg9uYJrFXgg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Norris <briannorris@chromium.org>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Cong Wang <xiyou.wangcong@gmail.com>

On Thu, Jul 30, 2020 at 5:24 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Sure, I can do that:
>
> Reviewed-by: Brian Norris <briannorris@chromium.org>

Thank you so much for your review, Brian!

> I guess x25 is basically an abandoned project, if you're coming to me for this?

Yes, it does seem to me that X.25 is unmaintained. I'm submitting
patches for it because I'm personally interested in X.25 and I want to
fix things that I find to be having issues. But it's very hard for me
to do so because it's hard to find reviewers for X.25 code. So I
really appreciate that you review this patch. Thanks!

I don't know if it is the right thing to continue submitting patches
for X.25, or we should just keep the code as is. Maybe the kernel
community can have a discussion some time to decide what to do with
it.
