From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Mon, 1 Feb 2021 20:42:24 -0800
Message-ID: <20210201204224.4872ce23@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20210201055706.415842-1-xie.he.0141@gmail.com>
        <4d1988d9-6439-ae37-697c-d2b970450498@linux.ibm.com>
        <CAJht_EOw4d9h7LqOsXpucADV5=gAGws-fKj5q7BdH2+h0Yv9Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612240945;
        bh=tYCsOmxa9vAOxS56RR54t3aluwDqJ5tlt5Hhdw54r8k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fOdk9Y5SuX9ktsk46981mYflp1qJKiAokcln8Q/J3wVTJnutGlKVsy1EnDPRJlUBP
         X3o3M6Iv3wKxVgi5crlhoLWj8OuCLg0XieRBmSYOgyuvG8X/oMKZMM02DE4oyH382Z
         yeGJcKqcmcf9/IkeM+cgkPJoMeEQwDltqkV56JgFocaCdAn1CK63SaOlxtIn1XFPW/
         NFIyibw9DbmGrOci2/mKRjZLg8WmY+GZVE7u69C5o/Ad7lLirYGRkKMQnH1m3tpVXj
         0UHVuh19Yb5t3LIFQ2ZSJukhafQKV3CBfAWbnN06DNwsBMxPk2AFoe4kqBi/ZWHnDw
         idPLMeS3faKsg==
In-Reply-To: <CAJht_EOw4d9h7LqOsXpucADV5=gAGws-fKj5q7BdH2+h0Yv9Vg@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Xie He <xie.he.0141@gmail.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Mon, 1 Feb 2021 08:14:31 -0800 Xie He wrote:
> On Mon, Feb 1, 2021 at 6:10 AM Julian Wiedmann <jwi@linux.ibm.com> wrote:
> > This sounds a bit like you want skb_cow_head() ... ?  
> 
> Calling "skb_cow_head" before we call "skb_clone" would indeed solve
> the problem of writes to our clones affecting clones in other parts of
> the system. But since we are still writing to the skb after
> "skb_clone", it'd still be better to replace "skb_clone" with
> "skb_copy" to avoid interference between our own clones.

Why call skb_cow_head() before skb_clone()? skb_cow_head should be
called before the data in skb head is modified. I'm assuming you're only
modifying "front" of the frame, right? skb_cow_head() should do nicely
in that case.
