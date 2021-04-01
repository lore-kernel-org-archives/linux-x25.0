From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Thu, 1 Apr 2021 11:15:04 -0700
Message-ID: <CAJht_EMpRd8KhLQLZeDOVrhi2KHi5aLUkDknv=Ujw6MniesRHg@mail.gmail.com>
References: <20210328221205.726511-1-xie.he.0141@gmail.com>
 <CAJht_EMVAV1eyredF+VEF=hxTTMVRMx+89XdpVAWpD5Lq1Y9Tw@mail.gmail.com> <21ec9eafa230f2e20dd88d31fd95faa0@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fCN7HFcnvMpvphnepoCBtJplYkwECQXR2iZTdliGiTg=;
        b=dchZIDlXtJvfkwTLzGyyTve5opr2+bltojKqDNPOcF3IJah1ARE+lv/AfJNEYHb/TV
         X8l/y3PNjPzZn1ybq4INWmCQ5Jsi0zNqPyXruuFXDm9l3XVQ6HJx2rKc3r8kmX/Lshk4
         WYHPFuWfsI60CZQ1749BHQdDkUz8EWZMs+7J/IViwV3xaOa1gtOtMOCffQf8vSYN9qBc
         2LIrHnWB6srdpRIbHBuVCFEsqFW6O/cl6vdrRdSYhZbKHzsnWf0QimI0vTvty7gSty+C
         ofIXArAXVbH6xCJofuvId4hFanWuN4A+0qZW/8hZ4Q5TARRI3A1rCsCM5o9xGYspGPPf
         3dUw==
In-Reply-To: <21ec9eafa230f2e20dd88d31fd95faa0@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Halasa <khc@pm.waw.pl>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

On Thu, Apr 1, 2021 at 3:06 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Hi!
>
> Sorry for my late answer.
> Can you please also fix this line length warning?
> https://patchwork.hopto.org/static/nipa/442445/12117801/checkpatch/stdout

OK! Sure! I'll fix the line length warning and resubmit.

Thanks!
