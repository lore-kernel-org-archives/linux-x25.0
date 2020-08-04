From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Tue, 4 Aug 2020 03:13:00 -0700
Message-ID: <CAJht_EN5fRKMHZRtqOgYKZ4wmOZOQcrGnarEPWUxRD31eaftRA@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_EO1srhh68DifK61+hpY+zBRU8oOAbJOSpjOqePithc7gw@mail.gmail.com>
 <c88c0acc63cbc64383811193c5e1b184@dev.tdt.de> <CA+FuTSeCFn+t55R8G54bFt4i8zP_gOHT7eZ5TeqNmcX5yL3tGw@mail.gmail.com>
 <CAJht_EOeCpy_SLKk2KXJHBj79VCujUZWiZou_BDfMr+pVWKGPA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VUZ+5uaWO5tygxXuvOm55d3w56P1W5CNtNbPKcozm+o=;
        b=BbsTPuA4f+c97Mqm4Dhm66f9TB6s3p0y9+fl9la8dSQZ1b2w4EnvmGOkSZBlZVxEQi
         +mAkU4d3/nigMTMcM7HEC6B7H+1drbyVBb0RJc7P0/JU3g595pcwSRPU7RMk6djLgmZA
         Tbl1Dvre/iCIBqpldW1K0yGa6l7xkuj3dk/8rQVSOEgOCjCiEwzYUv6gSZQC4P6uwLcL
         MAq4Fwc9SDNxh0PEm2MTNSNHRODPIBO7AFqc+IkxqPjybdG1dyf5SgMd9VnehbaP8hw/
         6fhPTL/NW+557guMWBZx68Sjj5L1z4eX5LvEFxXfC2M4t3j/QQl0EdlFy/RAepYcv2r5
         Edhw==
In-Reply-To: <CAJht_EOeCpy_SLKk2KXJHBj79VCujUZWiZou_BDfMr+pVWKGPA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemb@google.com>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

On Tue, Aug 4, 2020 at 3:07 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> Maybe we could contact <majordomo@vger.kernel.org>. It seems to be the
> manager of VGER mail lists.

Oh. No. Majordomo seems to be a robot.
