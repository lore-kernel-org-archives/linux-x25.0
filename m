From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/x25_asy: Fix to make it work
Date: Mon, 13 Jul 2020 15:19:40 -0700
Message-ID: <CAJht_ENaDzwwtqupZf=pK4MBUsU1=OdXO=TRVn0a44YxC5U1SQ@mail.gmail.com>
References: <20200708043754.46554-1-xie.he.0141@gmail.com> <4b46b0f6-8424-5a6e-a4ae-3729f54c5d4b@gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wlS+SrJ1At0Y30vYRvZttOy99z1jpaOiiIPmyhb9Ml4=;
        b=SZc0mePOLPkM8suKnl42aCZU8qbo1+nkeiK4zK/rppBg5PIKM2/oVqznAx/L5S9HGu
         f2Oy+1Ows+HGeq8g3ZfrMcp+vds2KCDZCxdibGJE0IPMfhk6us7P8OBJwXnVSBuBios2
         EtYw5FkGy7iBsR0yisc8uUNEBz0Ak+4nizxWnl91L6juu5qlwDYFKdQa82kdNPXa8Uqp
         oWLRLfHgFngnfWzfV9ftTfTTtxLZ+awdREZZRF1nQl3/omEy3MedgKvbqMLnOxAjf5E7
         BBn5YQ1gBF4o6eIc9JpVvZ1+L78TquyiKOOs+/E2+hHWJ8c0ZIi0nPjZEKmhQ38TBplC
         m2ZQ==
In-Reply-To: <4b46b0f6-8424-5a6e-a4ae-3729f54c5d4b@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Shannon Nelson <snelson@pensando.io>, Martin Habets <mhabets@solarflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

On Mon, Jul 13, 2020 at 2:21 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> It is not clear to me what guarantee we have to have one byte of headroom in the skb
> at this point.
>
> You might add to be safe : (as done in lapbeth_data_indication(), but after the skb_push() which seems wrong)
>
>       if (skb_cow(skb, 1)) {
>             kfree_skb(skb); /* This line I am not sure, but looking at
>                              * lapb_data_indication() this might be needed.
>                              */
>             return NET_RX_DROP;
>       }
>
Thank you for your review, Eric!

The function "x25_asy_data_indication" is called by the "lapb" module
(net/lapb/). Before the "lapb" module calls this function, it has
removed from the skb an LAPB header which is at least 2 bytes (in the
function "lapb_decode"). So I thought there would always be a headroom
of one byte at this point.

But yes, it is always safer to add "skb_cow" at this point, so that it
is clearer the code would not crash here. I'll add it in the second
version of this patch. Thank you for your suggestion!

And yes, I agree that in "lapbeth_data_indication", the order of
"skb_push" and "skb_cow" is probably wrong. Let us submit another
patch to fix this problem!
