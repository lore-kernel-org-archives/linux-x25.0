From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v5] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Tue, 6 Apr 2021 01:49:14 -0700
Message-ID: <CAJht_EPxzyLe-byO8heA-YNHG6RAG5=6MPDZ4=MHnDP2vy5xRg@mail.gmail.com>
References: <20210402093000.72965-1-xie.he.0141@gmail.com> <CAJht_EO7ufuRPj2Bbp7PyXbBT+jrpxR2pckT9JOPyve_tWj9DA@mail.gmail.com>
 <f77ea411add46de10d1b9e72576a0ec2@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gCYr1I03X+k+4zRvDqbVMs/E1N9JK1gf4mt4xGLcXBw=;
        b=R9QcK1HUWPmv4xUu7Lrnago7GFe0qYseGzj5RjG23v7PgZimeVXCpuAjRijP0Akdi6
         UCK3dGgVSFawUntzQk955de9zWVkxoZcAsE5EqxjVaRPnPwdDlQDnmbpv8MmWA+4XSts
         8NIw5SN3O06dPQYesj3bjUyOoUhjdC+rn3MjkHKZz/B6KME8y5bjZNOhlqhG8ObrZ25D
         X3U6KPG1KkPbZSicK2A8KWQqpbqiDaIPQlmaKAowdcO/VmBWBel3dz1FadyLczeWR/WQ
         ZV9BJO3J6yVm5WtBZRR61sTWD2kxYSZgJsh/qOsMsQT/WXLd3ibdZo67BpM6m6PVYJK2
         F0tA==
In-Reply-To: <f77ea411add46de10d1b9e72576a0ec2@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Halasa <khc@pm.waw.pl>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Mon, Apr 5, 2021 at 11:17 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Acked-by: Martin Schiller <ms@dev.tdt.de>
>
> Just for the record: I'm certainly not always the fastest,
> but I don't work holidays or weekends. So you also need to have some
> patience.

Oh. Thank you! Sorry, I didn't know there was a holiday in Germany.
Happy holiday! :)
