From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH 1/6] net/x25: add/remove x25_link_device by NETDEV_REGISTER/UNREGISTER
Date: Mon, 16 Nov 2020 00:45:38 -0800
Message-ID: <CAJht_ENxZhW9MK_HsY_6c_VjUbubQCYZwkVMYbHL-4aWJkaxuQ@mail.gmail.com>
References: <20201116073149.23219-1-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eE6kgra1YlTXQSwDwoBMLKyVfTjYvNxtsHARlvdv6S4=;
        b=goB7l1s/y8wJCBe1/fDM9JnlskpuHR+y6FluwWjlY05HpO62jX5xvTQZM5jicww7hC
         9bxMGsEnqTMpnOVphEa2Hiq0+tjONnY63Mw2h3/qm/qPxzMfGfUoCzwo8V/rWEe3SUFH
         wbfUd7DyHqoxehpsJ1/+hforL7ptxEUhU0G2DMGCbwKdQiZS5QTc2ro07hHU5RFkEfjN
         Uum732C6Emz1vrQZIRWMVZpLk/e91RUcRz+b15EW+nqlmMYlvjiJeAS10e53WNFlJ8sA
         rwBHC5PAFB5S1WhXBICorQp4RtGo4psnzzRuokrkZGcESA4xe2eZrH9J++86wyP7aq3h
         jtqw==
In-Reply-To: <20201116073149.23219-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Martin,

Thanks for the series. To get the series applied faster, could you
address the warnings and failures shown on this page?
https://patchwork.kernel.org/project/netdevbpf/list/?submitter=174539
Thanks!

To let the netdev robot know which tree this series should be applied,
we can use [PATCH net-next 1/6] as the subject prefix.
