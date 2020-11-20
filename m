From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v4 0/5] net/x25: netdev event handling
Date: Fri, 20 Nov 2020 14:40:35 -0800
Message-ID: <CAJht_EN0vTTzmd3WRLY96M0OO3V8a=Y987pWDu+O-fXQHRQYLg@mail.gmail.com>
References: <20201120054036.15199-1-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sgtncp9FPigEcaXHQf1sv5gXWmKILLQAAH0peI9rJmI=;
        b=FtS4PJN799vGwsAvEZlBzBju3wKNl5Aie1A6KJxxdG25b9oLyJmUJ+HrU27trZ21SZ
         IPWoSBuyc7eriH1qab2mi+wSGdgPx+LrBeZCx2nWYTTh+hEQNZG9WalPDVSNVFFzf0vJ
         bI/guDxtU0fm3bkpRp1kjosaHz9+QD6drgLgUJRTqJeiw5sAcjkqIcvUaKspH90TKma3
         13XHbS7mfz3VXT/7pE/Fbh8Qq3XX/qVrdOboHE8YXELAL+Mil6CopOoijKJo+QwhSGrA
         mjEMFAv8Es1s8CCTjtIjZyjRBwn4cOvvKJHJZwOeLf5xJ1wQQhLYV5SW654u5idEHdJh
         JJ6A==
In-Reply-To: <20201120054036.15199-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Thu, Nov 19, 2020 at 9:40 PM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Changes to v3:
> o another complete rework of the patch-set to split event handling
>   for layer2 (LAPB) and layer3 (X.25)

Thanks for your work!!
