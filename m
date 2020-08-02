From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Sat, 1 Aug 2020 17:58:30 -0700
Message-ID: <CAJht_EOdrnuYn0COTW-6kEivbq+1FqzNnWgs8E_xsdyD_pwomA@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com> <CAJht_ENjHRExBEHx--xmqnOy1MXY_6F5XZ_exinSfa6xU_XDJg@mail.gmail.com>
 <CA+FuTSf_nuiah6rFy-KC1Taw+Wc4z0G7LzkAm-+Ms4FzYmTPEw@mail.gmail.com>
 <CAJht_ENYxy4pseOO9gY=0R0bvPPvs4GKrGJOUMx6=LPwBa2+Bg@mail.gmail.com>
 <CA+FuTSeusqdfkqZihFhTE9vhcL5or6DEh8UffaKM2Px82z6BZQ@mail.gmail.com>
 <CAJht_EO4b=jC8KarwZyF1M3T57MrFCDvo-+Agnm9qD4pSCmODQ@mail.gmail.com> <CA+FuTSdJ1c0R2qmKtm9vWpKnMv=-B0yAaronGkqg=jYZBfqceA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wtd1dTqkIQZNG0/L93HORXN7DmmIz2UILlkYQcDT6aM=;
        b=cDFC28TNCnBL9i2dwpdgSVKxiqUVFYdv7Is61GyKTALJ4OkNnKxhn7wQw0NdfUPgNT
         h659nPgUZhPC5HqFoFN+Hw250ELXr6du7JHOpzb4B5Oz+bC/xDfRUTqcV+9twoL4SDf0
         4mpXQpLJDoGZt1MG6A1bsyi8jIRbqmeUoau0G3Hq8XM9JHLtMsYGNOCaDsWyoCZk/ePd
         ukBM4BcNquw1FBowrXsJIJX+0Y2O7kpuq/1WdnKLyN/R/c4poi8YCRt4Cy+h4C9QNT8C
         /J9GROMbyEeZjsySqm4LoZe2owKJ0gLpoVRYOmwN2ittIlmtobeKMWi5AYTSNFb3owkd
         sEQQ==
In-Reply-To: <CA+FuTSdJ1c0R2qmKtm9vWpKnMv=-B0yAaronGkqg=jYZBfqceA@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Brian Norris <briannorris@chromium.org>

On Sat, Aug 1, 2020 at 6:31 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> The kernel interface cannot be changed. If packet sockets used to pass
> the first byte up to userspace, they have to continue to do so.
>
> So I think you can limit the header_ops to only dev_hard_header.

Actually if we want to keep the kernel interface unchanged, we
shouldn't implement header_ops for dev_hard_header either, because
this changes the way the user space program sends DGRAM packets, too.
Before the change the userspace program needs to add the 1-byte header
before sending, and after the change the userspace program will let
the kernel add the header via dev_hard_header.

> Fixes should be small and targeted. Any larger refactoring is
> best addressed in a separate net-next patch.

I guess the best way for this fix patch would be just add a 0-byte
packet check before the driver reads skb->data[0].

Thanks! I'll add the check and re-send the patch.
