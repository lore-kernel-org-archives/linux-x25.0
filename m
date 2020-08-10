From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
Date: Mon, 10 Aug 2020 11:13:46 -0700
Message-ID: <CAJht_EPGD1RmnU6-ZJYocXCY-qcPxXeEuurQ6GJod=WGO69-jg@mail.gmail.com>
References: <20200808175251.582781-1-xie.he.0141@gmail.com>
 <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com>
 <CAJht_EM9q9u34LMAeYsYe5voZ54s3Z7OzxtvSomcF9a9wRvuCQ@mail.gmail.com> <CA+FuTSdBNn218kuswND5OE4vZ4mxz3_hTDkcRmZn2Z9-gaYQZg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QWRjJz03fN2iX6SwFzIlTiyYOq7QYK9vU0Yu9DQQqFg=;
        b=B/RWcC5SUXP+AjseWeNvooqu2enNHgumz6rl6RK/sm6OxOMjpNAPqfgwbC2Uj/pCM2
         B6EI2DkyqlZY48bqmKCkvj6P7Z9gQxtGM0E9oS6mp1ZMfizCc2/VtqecTG+YJXQFBVpr
         P8UBvN1bTyo8RHgkypE4UW6SCVoQoDGJKKz0f4s1xKCbDOdfWY82/1eve6yzJaG0lQCi
         tH0oCJooIUESQKV/+DL6Er88LPwYDlQp8hK2EQT1rIK7gyPas2uDRMsBkDJnECgkBGSR
         5w1CZVYDTeJ8C+0oZS3iY29eCS5MnHmyz2pTcgNMJN1zErCg/R35id1oJ1Mt8s15lwKN
         jSJQ==
In-Reply-To: <CA+FuTSdBNn218kuswND5OE4vZ4mxz3_hTDkcRmZn2Z9-gaYQZg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Mon, Aug 10, 2020 at 12:32 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> What happens when a tunnel device passes a packet to these devices?
> That will also not have allocated the extra tailroom. Does that cause
> a bug?

I looked at the code in net/ipv4/ip_tunnel.c. It indeed appeared to me
that it didn't take needed_tailroom into consideration. However it
does take needed_headroom into consideration through the macro
LL_RESERVED_SPACE. I think it would be better for it to take
needed_tailroom into consideration, too.

However, looking at the comment of needed_tailroom in
include/linux/netdevice.h, it says "Extra tailroom the hardware may
need, but not in all cases can this be guaranteed". So if we take this
comment as the spec, we can consider this to be not a bug. The reason
the author of this comment said so, might be that he wanted to add
needed_tailroom to solve some problems, but he was not able to change
all code to take needed_tailroom into consideration, so he wrote in
the comment saying that it was not necessary to always guarantee
needed_tailroom.

If we take this comment as the spec, to prevent bugs, any driver that
sets needed_tailroom must always check (and re-allocate if necessary)
before using the tailroom.

However, I still think it would be better to always take into
consideration needed_tailroom (and needed_headroom, too), so that
eventually we can remove the words of "but not in all cases can this
be guaranteed" from the comment. That would make the code more logical
and consistent.

Thank you for raising this important question about needed_tailroom!
