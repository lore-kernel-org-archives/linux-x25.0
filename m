From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Mon, 1 Feb 2021 08:14:31 -0800
Message-ID: <CAJht_EOw4d9h7LqOsXpucADV5=gAGws-fKj5q7BdH2+h0Yv9Vg@mail.gmail.com>
References: <20210201055706.415842-1-xie.he.0141@gmail.com> <4d1988d9-6439-ae37-697c-d2b970450498@linux.ibm.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oe9kyxs1vAX/uhUOjLvSRTrrpJNRpCHgV3q3Ra/fPlI=;
        b=ftDEwVWojYxl00NqeNgdsQPlGCHIBg9DH+l7sy8IYd265AqJ48Wq9qdDTLcfWtBfHg
         SydNN2Fki+4FWKcIs+47Y4TNFN6kChxWYRh1KH7vQJ8S72cvL/q74WCYqxunfrkbnYQe
         +fzSBITqpRCl3zxUezpAwtBbNAzcrHOupprKpvbZLY3aZdm3bC63uPiDxwNqeJmsSah0
         pv1W2dPBpYKFfkATUNJAayGLkCaLQN0kNBQn8fBKJMKRDWheXudgCSGEQ3W/q9sxVlN/
         WZHAkqXZ0TYhhlC264IG/5kuRNfLwSyPfEmHQi+q79r5Y9xVTybwdlMagM/EDRfYWGEY
         yF4g==
In-Reply-To: <4d1988d9-6439-ae37-697c-d2b970450498@linux.ibm.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julian Wiedmann <jwi@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Mon, Feb 1, 2021 at 6:10 AM Julian Wiedmann <jwi@linux.ibm.com> wrote:
>
> This sounds a bit like you want skb_cow_head() ... ?

Calling "skb_cow_head" before we call "skb_clone" would indeed solve
the problem of writes to our clones affecting clones in other parts of
the system. But since we are still writing to the skb after
"skb_clone", it'd still be better to replace "skb_clone" with
"skb_copy" to avoid interference between our own clones.
