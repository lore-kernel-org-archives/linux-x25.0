From: Cong Wang <xiyou.wangcong@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
Date: Mon, 27 Jul 2020 22:24:45 -0700
Message-ID: <CAM_iQpV8GDu2U_+4LwSy=uHc6_0FvCx_7ZPCOQ15=hccpaOCig@mail.gmail.com>
References: <20200726110524.151957-1-xie.he.0141@gmail.com> <CAJht_EOAGFkVXsrJefWNMDn_D5HhH+ODkqE03BULyzb_Ma8A5A@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bJEzDOwJp0ny5xLDIyqDpHcyByjEwZuqOl/iPSQ9qGE=;
        b=klax/3Q/dpB3FmxME9JntHGTjDCGdpH6466ptElrE2PHnQuwZIphwo3vWsib87seqI
         J0Xe6Jv43A2RhMJ8H/QA/K7fl3gV1UyA/0y4ma9dRoapiDNNyXHS+9gboxs0C5fDt3ld
         9TB+A+ZD9Ac1eEIkM6oNKUW2FBxdVAPAy+S02+q+S0UYbDJrbq+LUJ5mou4Juztm9fcB
         qiYdfdkgdprfGPdV2E6HDtHnRqC1fhIArD3Kv9jB91MXbkfS/Y5AmoOT65JoiEbnxUbY
         t/u5xBMdta70CXFySjlFETkrWJu47J62Vy5uKgApf5qpeTXq7ekjouE3l/b+9Snsa5xT
         44Ww==
In-Reply-To: <CAJht_EOAGFkVXsrJefWNMDn_D5HhH+ODkqE03BULyzb_Ma8A5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

Hello,

On Mon, Jul 27, 2020 at 12:41 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> Hi Cong Wang,
>
> I'm wishing to change a driver from using "hard_header_len" to using
> "needed_headroom" to declare its needed headroom. I submitted a patch
> and it is decided it needs to be reviewed. I see you participated in
> "hard_header_len vs needed_headroom" discussions in the past. Can you
> help me review this patch? Thanks!
>
> The patch is at:
> http://patchwork.ozlabs.org/project/netdev/patch/20200726110524.151957-1-xie.he.0141@gmail.com/
>
> In my understanding, hard_header_len should be the length of the header
> created by dev_hard_header. Any additional headroom needed should be
> declared in needed_headroom instead of hard_header_len. I came to this
> conclusion by examining the logic of net/packet/af_packet.c:packet_snd.

I am not familiar with this WAN driver, but I suggest you to look at
the following commit, which provides a lot of useful information:

commit 9454f7a895b822dd8fb4588fc55fda7c96728869
Author: Brian Norris <briannorris@chromium.org>
Date:   Wed Feb 26 16:05:11 2020 -0800

    mwifiex: set needed_headroom, not hard_header_len

    hard_header_len provides limitations for things like AF_PACKET, such
    that we don't allow transmitting packets smaller than this.

    needed_headroom provides a suggested minimum headroom for SKBs, so that
    we can trivally add our headers to the front.

    The latter is the correct field to use in this case, while the former
    mostly just prevents sending small AF_PACKET frames.

    In any case, mwifiex already does its own bounce buffering [1] if we
    don't have enough headroom, so hints (not hard limits) are all that are
    needed.

    This is the essentially the same bug (and fix) that brcmfmac had, fixed
    in commit cb39288fd6bb ("brcmfmac: use ndev->needed_headroom to reserve
    additional header space").

    [1] mwifiex_hard_start_xmit():
            if (skb_headroom(skb) < MWIFIEX_MIN_DATA_HEADER_LEN) {
            [...]
                    /* Insufficient skb headroom - allocate a new skb */

Hope this helps.

Thanks.
