From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v5] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Tue, 6 Apr 2021 16:55:23 -0700
Message-ID: <CAJht_EOZoxyb7+4910vcyz9D7j828nPOLGZv++AozWWGGj4bHw@mail.gmail.com>
References: <20210402093000.72965-1-xie.he.0141@gmail.com> <20210406.161431.1568805748449868568.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SZG0o9Sq8gSXLCWuHmzcPqeuL417DqZYkn8x8MyGxHQ=;
        b=NTZwWhEZKlVya/n8yYBxyZOzXySnL1bjqtcIrcZa2I5L+9keFY9Xt9vneXC/ePKFw9
         wGOl66BIuNcN7bXuhRQxn4yO1aH7kygPDf2xUZJQRqWk2/5Okz7GJ0Lik4rgr41+HFX5
         L16awqaWfiUxsTfMU1Jk2DgXbFbA6Ug9GAGKykhkW2zp12xkSoJ1Yr0aoGV3kPtHXej6
         jaU3kvJDpNnDdhhLeOA8nvTd6la9GvU6SGQVQqko0TLxPnzClXCM1K2hLgBSdNhXGDZT
         p2N4I1pfTKGa1I0E6vT953p4/UP2gHgLEo5WUExn4+JfcFR1lc7YsseSD0+hmVJFRJAd
         4kRw==
In-Reply-To: <20210406.161431.1568805748449868568.davem@davemloft.net>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Martin Schiller <ms@dev.tdt.de>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Halasa <khc@pm.waw.pl>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Tue, Apr 6, 2021 at 4:14 PM David Miller <davem@davemloft.net> wrote:
>
> This no longe applies to net-next, please respin.

Oh. I see this has already been applied to net-next. Thank you!
There's no need to apply again.

Thanks!
