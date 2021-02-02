From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Mon, 1 Feb 2021 22:25:17 -0800
Message-ID: <CAJht_ENcz1A+C8=tJ_wP8kQby4OuyWirJC+c+-ngg5D54dpHNg@mail.gmail.com>
References: <20210201055706.415842-1-xie.he.0141@gmail.com>
 <4d1988d9-6439-ae37-697c-d2b970450498@linux.ibm.com> <CAJht_EOw4d9h7LqOsXpucADV5=gAGws-fKj5q7BdH2+h0Yv9Vg@mail.gmail.com>
 <20210201204224.4872ce23@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdzoXk6LXCL/XJZQ9bhaClEN0pBSjRAU89qkEkTJ1ro=;
        b=WpDctFpAjxQC3G7i/CrGOY5P5vAzYvSQZ1DJ7ug65xvWqMu058k6tQ55kWTe4mNQ1Y
         aCKj73P49pFh1v29gECJjZSHS/0nlD/d5b83Vg6OorIHAAehpDXphlvkfDj+Fikrd0Tn
         f42RIHVu9CBa0Vv2XdIWp/ccMU26TFFY1fpqUtTJS1dkxAHYylOdqHaB2ablpM25HRFh
         d3p4/J451okEOShw7EnNAwSV5RzM5FpXSuI8bI5ZrIEXTc3Y+c/WptQsp60yiPqfg31I
         6mUS5XeILRFn1pz/ZlZmqpEd0vKPe5VRbKNcyQpsBfLt8udkOLDHFthNwM4uqGs//DaV
         HYFw==
In-Reply-To: <20210201204224.4872ce23@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Mon, Feb 1, 2021 at 8:42 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> On Mon, 1 Feb 2021 08:14:31 -0800 Xie He wrote:
> > On Mon, Feb 1, 2021 at 6:10 AM Julian Wiedmann <jwi@linux.ibm.com> wrote:
> > > This sounds a bit like you want skb_cow_head() ... ?
> >
> > Calling "skb_cow_head" before we call "skb_clone" would indeed solve
> > the problem of writes to our clones affecting clones in other parts of
> > the system. But since we are still writing to the skb after
> > "skb_clone", it'd still be better to replace "skb_clone" with
> > "skb_copy" to avoid interference between our own clones.
>
> Why call skb_cow_head() before skb_clone()? skb_cow_head should be
> called before the data in skb head is modified. I'm assuming you're only
> modifying "front" of the frame, right? skb_cow_head() should do nicely
> in that case.

The modification happens after skb_clone. If we call skb_cow_head
after skb_clone (before the modification), then skb_cow_head would
always see that the skb is a clone and would always copy it. Therefore
skb_clone + skb_cow_head is equivalent to skb_copy.
