From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next RFC v2] net: hdlc_x25: Queue outgoing LAPB frames
Date: Sun, 14 Feb 2021 23:00:10 -0800
Message-ID: <CAJht_EOrNaavomac8OVv8i0YxMgsX7oWAFDDRUzWTjpNhWpCcg@mail.gmail.com>
References: <20210210173532.370914-1-xie.he.0141@gmail.com> <f701aad45e35579c8b79836ffeb86ea9@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MLQN9t84WZNNwMBeSpSegbk2anC6/0CnhIjVKrMRW54=;
        b=CFeCL4lmp6j1rJ631/DYI4jxYOOXS3k735zBKpRs1937uFBu/I7d43iRwHcudtVEb3
         0/WyDNTf2PLMFrmkk8oGVZsIncvDU44urhIwRYD7kmHOtKYM+pZhZPEXJdf63agc1e6Q
         /hGuHrwA/hJGh/EWJ7+1QVgvOhlCveKsC8B6iu9OQdmXTibRqo+ENR7XtsPt83VbsPgE
         gNX3ekZ9tO2GdVFScVuxR/vXUN9iW3UhAsKztULuAxP5MqzifX+r4ZGi3VBTf6qZVeGC
         4OyvAJQkJCSu5BdZb1w+hZ6FCtrh/c7jbiSmZbtvFE/qNHUOvN2dSKdm4NRASz6GnFwX
         zcbw==
In-Reply-To: <f701aad45e35579c8b79836ffeb86ea9@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Krzysztof Halasa <khc@pm.waw.pl>

On Sun, Feb 14, 2021 at 10:27 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> At first glance, the patch looks quite reasonable. The only thing I
> noticed right away is that you also included the changes of your patch
> "Return meaningful error code in x25_open".

Thanks! It was because this patch was sent before that fix got merged
into "net-next". I will drop that part now.

I will also make the MTU of the virtual X.25 device be HDLC_MAX_MTU
(instead of HDLC_MAX_MTU - 2), because I see other HDLC Protocol
Drivers seem to also use this value as MTU (without subtracting the
header length).

> I hope to get back to the office this week and test it.

Thanks!
