From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net v2] drivers/net/wan/lapbether: Added needed_tailroom
Date: Mon, 24 Aug 2020 16:48:58 -0700
Message-ID: <CAJht_ENk-8ziaJ7FFPr9DVRinDOxaXaH2mJHoYcDw3CCHgx-Zg@mail.gmail.com>
References: <20200821212659.14551-1-xie.he.0141@gmail.com> <20200824.160949.2284526241463900498.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MRFtcPoCikAVvKJYCXbUBDj9joKfZP9gvPiffFziVs4=;
        b=UtFLoRdmhkURy9IIpmgJFC0bgeJ1qVxQ0QHeMe2UlDPEPmZ6paDRATFFCezcM2Qxj2
         ZF/iQHVjRDhyDlHIJ8DtJ4948A3fOqdsASI0586Ex3zP9rBxxE5A/1HtEt6LhJ8Awon3
         R0rDvRFkpO4NK784e+/Yr5aR9BBbET8aF1P6dfUSC2MoYo8+PrYloZRK4n2v1R44P5pX
         N21ZOA7CsN6CSqJELOakhDVX57F53/HLExqfk66OssaZgKc6tevxnTmUdEdIGiQIKu8t
         9i/cHb8iapf7NtaC0cbFyN1XO/u6KV3ZRH08ebogDH6mcPSGxhze/2adaSa2eQP4zArZ
         EtEw==
In-Reply-To: <20200824.160949.2284526241463900498.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin Schiller <ms@dev.tdt.de>

On Mon, Aug 24, 2020 at 4:09 PM David Miller <davem@davemloft.net> wrote:
>
> Applied, thank you.

Thank you!
