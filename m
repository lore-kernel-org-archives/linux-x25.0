From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: hdlc_x25: Use qdisc to queue outgoing LAPB frames
Date: Sat, 30 Jan 2021 06:29:20 -0800
Message-ID: <CAJht_EPMtn5E-Y312vPQfH2AwDAi+j1OP4zzpg+AUKf46XE1Yw@mail.gmail.com>
References: <20210127090747.364951-1-xie.he.0141@gmail.com>
 <20210128114659.2d81a85f@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EOSB-m--Ombr6wLMFq4mPy8UTpsBri2CPsaRTU-aks7Uw@mail.gmail.com>
 <3f67b285671aaa4b7903733455a730e1@dev.tdt.de> <20210129173650.7c0b7cda@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nkx9uFScRqctjDlwBC992ocBDlhUqlgA/eQzRKO6pEo=;
        b=np49WVh5Hdtn/4dlc9UfL4hMeh3AM37lFA867olQjLMMGUr9rc1YHeMvq2H2c6mvnb
         X/oFZtkBP7PwcirZHNoYsNtTJnjTFVevA7XXtu4arT6BAc+viA38faGtljoyKWO8XUPs
         K2CSYrR64K9hr2lIgeRER7Uu+wicIstBS5JqCucyoFx5jqrJro267wNL6fKJokDKTOEx
         vAXfHTBpgvPuwoZi/cbeie3nwhXMtDY9F9pLHIS2y0R0ve927dWvR8wNiHcjI8Ism+ek
         9ntuImRyQgg6Xpur8TntWnIpbsqSNOnl92DP8FOKzQ4lzhSBn9q46P+QeNabTFoGrOKZ
         ZzCw==
In-Reply-To: <20210129173650.7c0b7cda@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Fri, Jan 29, 2021 at 5:36 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> I'm still struggling to wrap my head around this.
>
> Did you test your code with lockdep enabled? Which Qdisc are you using?
> You're queuing the frames back to the interface they came from - won't
> that cause locking issues?

Hmm... Thanks for bringing this to my attention. I indeed find issues
when the "noqueue" qdisc is used.

When using a qdisc other than "noqueue", when sending an skb:
"__dev_queue_xmit" will call "__dev_xmit_skb";
"__dev_xmit_skb" will call "qdisc_run_begin" to mark the beginning of
a qdisc run, and if the qdisc is already running, "qdisc_run_begin"
will fail, then "__dev_xmit_skb" will just enqueue this skb without
starting qdisc. There is no problem.

When using "noqueue" as the qdisc, when sending an skb:
"__dev_queue_xmit" will try to send this skb directly. Before it does
that, it will first check "txq->xmit_lock_owner" and will find that
the current cpu already owns the xmit lock, it will then print a
warning message "Dead loop on virtual device ..." and drop the skb.

A solution can be queuing the outgoing L2 frames in this driver first,
and then using a tasklet to send them to the qdisc TX queue.

Thanks! I'll make changes to fix this.
