From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/x25_asy: Fix to make it work
Date: Tue, 14 Jul 2020 02:55:11 -0700
Message-ID: <CAJht_EOu1cWt3bZJaWw3-TpbEVY3yr7HGeo3SLZb+6HDNed8gQ@mail.gmail.com>
References: <20200708043754.46554-1-xie.he.0141@gmail.com> <20200708.101321.1049330296069021543.davem@davemloft.net>
 <CAJht_EOqgWh0dShG258C3uoYdQga+EUae34tvL9HhqpztAv1PQ@mail.gmail.com> <490146353e9225245d8165b6edade1a9@dev.tdt.de>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=feWyy0YWmvWVEAuHgQpmSZhwHtPX9xjD6RVECBnCw3E=;
        b=szkV+r3apsHlELmwwhzxtkq1yixy/UbcMA1fZ4Ojl6hwP8YJWOUvxKilJEieNgl/mr
         CFKioRISpV6/4WG5XX8mpUMa7j+NitLI7/st6mguFQg8ExUFf5i9sDUUy77If+ucQVHq
         Hnci4wSGC5I7Zel6KvKxA9pR/hkKNSoeIf2W5P6THvDhpvEw6EaDHrsNA9Sz14hWivOS
         aaodikEJC3hSmcgtkFN3xjvr0J80158VGgrlXemKKvNTkGykwQeetuTuTsB823max8IV
         ND7qI01RAydtjE8w2L3J3QFMkXiGYPYaRUmsrSEJyExDAPRoQcScywiY28ytlVewnMVy
         8hmQ==
In-Reply-To: <490146353e9225245d8165b6edade1a9@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Shannon Nelson <snelson@pensando.io>, Martin Habets <mhabets@solarflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Linux X25 <linux-x25@vger.kernel.org>

On Tue, Jul 14, 2020 at 1:07 AM -0700
Martin Schiller <ms@dev.tdt.de> wrote:
>
> It really seems very strange that this driver seems to contain such
> fundamental errors. I have never used it.
>
> But the explanations and fixes look plausible to me.

Thank you for reviewing this patch, Martin!

Yes, this situation is very strange. I guess not so many people have
tried this driver. The comment of this driver says it doesn't
implement the checksum, which is required by the international
standard. So I guess it can't be used for practical purposes anyway. I
tried this driver because I was personally interested in X.25.
