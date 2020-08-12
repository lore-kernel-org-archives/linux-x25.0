From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a
 skb->len check
Date: Tue, 11 Aug 2020 19:26:32 -0700
Message-ID: <CAJht_EMyp5iXyGWVse7sqW0MDJ3iLH5cDcbGm1yyXt+07x9Naw@mail.gmail.com>
References: <20200809023548.684217-1-xie.he.0141@gmail.com>
 <CA+FuTSe-FaQFn4WNvVPJ1v+jVZAghgd1AZc-cWn2+GjPR4GzVQ@mail.gmail.com>
 <CAJht_EOao3-kA-W-SdJqKRiFMAFUxw7OARFGY5DL8pXvKd4TLw@mail.gmail.com>
 <CA+FuTSc7c+XTDU10Bh1ZviQomHgiTjiUvOO0iR1X95rq61Snrg@mail.gmail.com>
 <CAJht_EORX2intix=HxS+U+O1hiuSb25=GWi5ONHtFdEF_BS_Ng@mail.gmail.com> <CA+FuTSfS1XX9ag6npPM95Tiu_hhuan+Foxe1B+_66M-cf+26UA@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4S0WWMB8K9X5xf/fcDPieKk5CbZpA3YQu68v2r84ozM=;
        b=ArbPjg8QkFhzlEFc/0WRJUYz47qn5CbfqGpxvQwrdj6rrxwJ/Mv6fF+EKhAvhiS0HF
         gOW6IulINYs2Q3nInmUQ54fulZ7J2saNBsnC/foXVnYJ7X2f2D+7Z9I2jEzm6B8IxRHf
         66TQBygsqz+g/qjE08I1GyJTTw3R01k2OzLWb285ecKe4FpAMi0ZT99Udxx97WIMld+C
         vhgSCAIahF8maP4MSxbfv2LHnQb8Ia9t4z7D7kJp3OoZwaMVVpu/8hwbs1Lqv4+HLKpJ
         3XLMTBQPuIG1mRVcUgqWWrdlLyrbbsALufMH23X2cakll95ULjIiAdboq3wTJ20CLGzz
         EAxQ==
In-Reply-To: <CA+FuTSfS1XX9ag6npPM95Tiu_hhuan+Foxe1B+_66M-cf+26UA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Andrew Hendry <andrew.hendry@gmail.com>

On Tue, Aug 11, 2020 at 3:50 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> > I became interested in X.25 when I was trying different address
> > families that Linux supported. I tried AF_X25 sockets. And then I
> > tried to use the X.25 link layer directly through AF_PACKET. I believe
> > both AF_X25 sockets and AF_PACKET sockets need to work without
> > problems with X.25 drivers - lapbether and x25_asy. There is another
> > X.25 driver (hdlc_x25) in the kernel. I haven't been able to run that
> > driver. But that driver seems to be the real driver which is really
> > used, and I know Martin Schiller <ms@dev.tdt.de> is an active user and
> > developer of that driver.
>
> Great, sounds like we might have additional LAPB and X25 maintainers soon? :)

:)  I just want to fix any problems I see. I'll do this whenever I have time.

> MAINTAINERS lists Andrew Hendry as maintainer for X.25. Please do CC them.

OK. I'll surely do that. Thanks!
