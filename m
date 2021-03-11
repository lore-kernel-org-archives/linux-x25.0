From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: lapbether: Prevent racing when checking whether
 the netif is running
Date: Thu, 11 Mar 2021 15:13:01 -0800
Message-ID: <CAJht_EMR6kqsetwNUbJJziLW97T0pXBSqSNZ5ma-q175cxoKyQ@mail.gmail.com>
References: <20210311072311.2969-1-xie.he.0141@gmail.com> <20210311124309.5ee0ef02@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <CAJht_EMToKj2OeeE1fMfwAVYvhbgZpENkv0C7ac+XHnWcTe2Tg@mail.gmail.com> <20210311145230.5f368151@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bU9j8QS9UEqtU91hrNDexuTDXigIeltrQEJrDXB39JU=;
        b=f/kuHReiRdBMXdOa966VBks+JO5X0AAmZaiPPeBGrQwvKqvQ+CoD8qjV0uQPREWRWw
         kadZC5M5uY7DFdui29GRMfDwEtxCy3Wbx118+IUwqSe+lPsb54h4N0OYNNB9yyxg00oa
         L0KycMqH4/jDv7S43dH6PV3jHzLfhkS7HX0mScTYZ2tZUpAL0oiSv9xzVWPDelvLGrBE
         Perdg5mKo4+BR34Hk3I/luPCkFHgGSD7Qpn4cChs+DVRKr9k2sAXmNndgBhMMKHk7MS6
         MQkYlftREEuPfE9Zt8D2QQbjv0u8QpWSfRODvd0owNP62OcuPwIrGZDIC5QOlYlnEO6m
         wDZA==
In-Reply-To: <20210311145230.5f368151@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Mar 11, 2021 at 2:52 PM Jakub Kicinski <kuba@kernel.org> wrote:
>
> Normally driver's ndo_stop() calls netif_tx_disable() which takes TX
> locks, so unless your driver is lockless (LLTX) there should be no xmit
> calls after that point.

Do you mean I should call "netif_tx_disable" inside my "ndo_stop"
function as a fix for the racing between "ndo_stop" and
"ndo_start_xmit"?

I can't call "netif_tx_disable" inside my "ndo_stop" function because
"netif_tx_disable" will call "netif_tx_stop_queue", which causes
another racing problem. Please see my recent commit f7d9d4854519
("net: lapbether: Remove netif_start_queue / netif_stop_queue")
