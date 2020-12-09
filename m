From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net/x25: fix restart request/confirm handling
Date: Wed, 9 Dec 2020 01:01:11 -0800
Message-ID: <CAJht_EMZqcPdE5n3Vp+jJa1sVk9+vbwd-Gbi8Xqy19bEdbNNuA@mail.gmail.com>
References: <20201126063557.1283-1-ms@dev.tdt.de> <20201126063557.1283-5-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4rpxUTzufCBNH+H443ssFvPa1VAOqL2A+09wFH4lKh0=;
        b=F3F81rp1cViSLFdGeG2bug5lkQlam3ZHbEAUyzrcWeM/gI0NEtEZZXHyrwJ3Ulkosn
         jVgolld4KbCsggi7SOrMYNXOscoEvfTxYUkfezHpuU4amZfIS65HvXWIpVQP8xMgLN6E
         fEn6sPNfqD/NtOaSKfSca+RuXE717Gys8spVQWWeFcTn/jhU7Nj9uzUPhixUToCSbCJv
         Y91q3KMRmXIA7dJ4hbGqrXzJaL7zP+jh6MB2kzsG9/TmdCleVtTlIzhCBwTKDmeCg0Ju
         wadrJaXDxo5p3XgwY255Uzh83K8UeWFbisbOXq1B8XvHK5FXWcRxf/TJZ0/mIe0m0vP5
         qhxA==
In-Reply-To: <20201126063557.1283-5-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Nov 25, 2020 at 10:36 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> We have to take the actual link state into account to handle
> restart requests/confirms well.
>
> @@ -214,8 +241,6 @@ void x25_link_established(struct x25_neigh *nb)
>  {
>         switch (nb->state) {
>         case X25_LINK_STATE_0:
> -               nb->state = X25_LINK_STATE_2;
> -               break;
>         case X25_LINK_STATE_1:
>                 x25_transmit_restart_request(nb);
>                 nb->state = X25_LINK_STATE_2;

What is the reason for this change? Originally only the connecting
side will transmit a Restart Request; the connected side will not and
will only wait for the Restart Request to come. Now both sides will
transmit Restart Requests at the same time. I think we should better
avoid collision situations like this.
