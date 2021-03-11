From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: lapbether: Prevent racing when checking whether
 the netif is running
Date: Thu, 11 Mar 2021 13:12:25 -0800
Message-ID: <CAJht_EMToKj2OeeE1fMfwAVYvhbgZpENkv0C7ac+XHnWcTe2Tg@mail.gmail.com>
References: <20210311072311.2969-1-xie.he.0141@gmail.com> <20210311124309.5ee0ef02@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VzvYjKyt62IHiCr5kkB4Gy+4y5xhft1EvZve9BUvvPg=;
        b=nK76W7i+GqBliQ0em41v8QQPefEcafvPmbHVqWHH2+G0wKCus9aXEXbpnWfbmMy0dZ
         YYGPGwzKrguSGJ5ZsWHJ7SaH9K9h1ABpjbVbsyEXmO1FsBKxW42M/6d23yte3w0Qxi/+
         JBWMAvEc5ENsJ304hNUUkQC5AZjEK2eLoV4b9s0130ocKdWjdPs768nkBiZ9GaMeG1jT
         ebZzedR4hW/wKy6+ISW0nqc/QP7uHo3Aa+RgKhXd3MBzH+yDEIMfZu0GRKQKms81YJLs
         /T7lle7lXvPf+vBNXfMj6gjmg3w9bL/r6hLqy7wZYlJ2h0Uy+r+6u0clNL/WeLBfVS8s
         KbYQ==
In-Reply-To: <20210311124309.5ee0ef02@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Mar 11, 2021 at 12:43 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Is this a theoretical issues or do you see a path where it triggers?
>
> Who are the callers sending frames to a device which went down?

This is a theoretical issue. I didn't see this issue in practice.

When "__dev_queue_xmit" and "sch_direct_xmit" call
"dev_hard_start_xmit", there appears to be no locking mechanism
preventing the netif from going down while "dev_hard_start_xmit" is
doing its work.

David once confirmed in an email that a driver's "ndo_stop" function
would indeed race with its "ndo_start_xmit" function:
https://lore.kernel.org/netdev/20190520.200922.2277656639346033061.davem@davemloft.net/
