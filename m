From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/x25_asy: Fix to make it work
Date: Mon, 20 Jul 2020 10:58:03 -0700
Message-ID: <CAJht_EOZZFE0-Os90-CyO9M8xX-B7UYWaTHcLiFOcGvHh3TB7A@mail.gmail.com>
References: <20200716234433.6490-1-xie.he.0141@gmail.com> <b2836ae012e0c57ba01ba1dee0a9eacd@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dn+bkLkSM2KuCKSXgr83y2+KLzl+K9NcQTzlSg6shOw=;
        b=IVPx3/vUOZoleX2si86P7GBZQhDQfBmNSj5bNfeOjTPe/PcJT/frdYfHefwROvyw8y
         dmsNiVTu7IYvZkKTvIHonXifIDXWA29zGL0oCiEqssPnxmqeXDE2T+Ymm4FkFLl2h4Kq
         FvY8d8chMcK9tRBQc2CV5xQt46ujwWlyg04GNGGMX1qpVZ74B3LdMgqkRxT/EEPVO1D8
         PmV9VZ7D3n7j713ejV9r7cHZ/srYMvzFFJ4UeUlE6lbsW81D+uIIeEudiebAIlyOZA+7
         VdqYJQrmWPuUU3wfCe40/4ERIXixMWHX0Q5he2KrDL5jmhGN0zne09zYUlR8GNUMYwDX
         2VhQ==
In-Reply-To: <b2836ae012e0c57ba01ba1dee0a9eacd@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Linux X25 <linux-x25@vger.kernel.org>

On Mon, Jul 20, 2020 at 4:23 AM -0700
Martin Schiller <ms@dev.tdt.de> wrote:
>
> LGTM.
>
> I have never used the driver, but the adjustments look conclusive. The
> functionality is now comparable to the one in the drivers lapbether or
> hdlc_x25.
>
> Reviewed-by: Martin Schiller <ms@dev.tdt.de>
>
Thank you so much!
