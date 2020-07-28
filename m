From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Use needed_headroom instead of hard_header_len
Date: Mon, 27 Jul 2020 23:59:28 -0700
Message-ID: <CAJht_EOFREE7oc_jiA5=OS22D2y0y-6ydh+bvqBx-zJ0HihL3Q@mail.gmail.com>
References: <20200726110524.151957-1-xie.he.0141@gmail.com>
 <CAJht_EOAGFkVXsrJefWNMDn_D5HhH+ODkqE03BULyzb_Ma8A5A@mail.gmail.com> <CAM_iQpV8GDu2U_+4LwSy=uHc6_0FvCx_7ZPCOQ15=hccpaOCig@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j8ZnOfNbyvBr0XEMDZWI56PsvQaHIfE1fSeq4rdZwUg=;
        b=XvYlkBGbkIpwwP9YCIrSkPZMFfE79qRMVDhq+0C0e2o6IOPNjAlVA47TPCWELitlUl
         pkfXruU9G/B7GxeriFXOvvVzRS+d/TqJ8BRkmjzCkSmVC5Ht6s+mj7NMWxNcWOrzbPcm
         8Yk0KnRZ/bahHCUHMeMezl3DWkEug+5V4cQqsm+1O0cq4euBSippCEb58r8HSj0c6mJk
         xIgthEPkH5l5xUXx+Dn/Gfh6c3rQRxA5N6vp6mMMqZ5Wa05gm3xV0nU31UZrGcqjZ0ur
         +tW2cRzABPU2I5WHtD4Dr+pHAerLpX7/yAY3lEwTAgIRN0BzYTxO7eG4TnZAvcJxZXNk
         LRMQ==
In-Reply-To: <CAM_iQpV8GDu2U_+4LwSy=uHc6_0FvCx_7ZPCOQ15=hccpaOCig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Brian Norris <briannorris@chromium.org>, Cong Wang <xiyou.wangcong@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

Hi Brian Norris,

I'm wishing to change a driver from using "hard_header_len" to using
"needed_headroom" to declare its needed headroom. I submitted a patch
and it is decided it needs to be reviewed. I see you submitted a similar
patch in the past. So I think you might be able to help review my patch.
Can you help review my patch? Thanks!

The patch is at:
http://patchwork.ozlabs.org/project/netdev/patch/20200726110524.151957-1-xie.he.0141@gmail.com/

As you have noted in the commit message of your patch, hard_header_len
has special meaning in AF_PACKET so we need to use needed_headroom
instead when we just need to reserve some header space. I believe the
value of hard_header_len should be the same as the length of the header
created by dev_hard_header.
