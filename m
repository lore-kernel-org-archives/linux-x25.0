From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v5] net: x25: Queue received packets in the
 drivers instead of per-CPU queues
Date: Mon, 5 Apr 2021 12:34:07 -0700
Message-ID: <CAJht_EO7ufuRPj2Bbp7PyXbBT+jrpxR2pckT9JOPyve_tWj9DA@mail.gmail.com>
References: <20210402093000.72965-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=qs2UgpNHrs9qIOZOqKSGGqFmmr2tm9Rf+HF/JQPX6rg=;
        b=Bog2xAWbsFjf4t2sh5sRaIdqTHdj0i1/lahuvIcL897SGc7Yh4M2/rxw8y0Pvs2FKA
         XNY7bfly/L7IZSl1kPoI/tADIPhvjaBbo1SKkU1yj2kpO7gL2SsUxlyVtWOT0RJ2VWbU
         LXxfz1CYFLOeXGqyWFiih97wL0fTjlsAU6YscJYvD3Axfku6QiQIAQhV6HKomlGuEsnR
         7Z07fNbBwIS5BC/iETs4MjEvOfX3O1/eKDdWAC8OJdif0U0ituoq8ohJ4DMmdqs/qvGE
         iQsyn+9xaEvoUeuwUtYVeNdQJHob4kABvi6K4N4/qcY+LjCn+Eb5iMrlPC8mypO3wYuA
         5ItA==
In-Reply-To: <20210402093000.72965-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Krzysztof Halasa <khc@pm.waw.pl>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

Hi Martin,

Could you ack? Thanks!
