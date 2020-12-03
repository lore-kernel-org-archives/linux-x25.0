From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2] net/x25: prevent a couple of overflows
Date: Wed, 2 Dec 2020 17:27:28 -0800
Message-ID: <20201202172728.43f387a3@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <X8ZeAKm8FnFpN//B@mwanda>
        <41de2a35016a1eb9a188a71d11709f16@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1606958850;
        bh=NWkqSZZ3ZS7bYCRKGHHjz3mlOO7zls+THqz0Y/Q51Q0=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=MNtOcI6WV8EHJGBU7QUuJXEWVoVTyE2klWVjhX2Q5oABIV+cYxP3hsL8l2UuThLxR
         iaIY6ZMhn2cRjZkUPUPPa6CuBgONYKwyBro5FORhXJiTMoe2wSzocfRlTXBDVYdGB0
         erWjz5cJSNmNHvbSaX6XJP/hO15aK8FBK1kXajq4RRMwOrRzOYsHq7yE/NWRYLkpHk
         3ICSzx3ZzUSkTRhpC8HOmA9o1csI23PZegqZxwRl2GAJRmU9XAqZflCibCudH2mZQl
         sIvJuuBMSMKU2fC/ZQuQYbOJ6xvxHdqNpg3AomjhWilmPFIOpx3P6KkhkKK+HCZscf
         o7jkVk5OsQt0A==
In-Reply-To: <41de2a35016a1eb9a188a71d11709f16@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Martin Schiller <ms@dev.tdt.de>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, Andrew Hendry <andrew.hendry@gmail.com>, "=?UTF-8?B?a2l5aW4=?=( =?UTF-8?B?5bC55Lqu?=) " <kiyin@tencent.com>, security@kernel.org, linux-distros@vs.openwall.org, "=?UTF-8?B?aHVudGNoZW4=?=(=?UTF-8?B?6ZmI?= =?UTF-8?B?6Ziz?=) " <huntchen@tencent.com>, "=?UTF-8?B?ZGFubnl3?= =?UTF-8?B?YW5n?=(=?UTF-8?B?546L5a6H?=) " <dannywang@tencent.com>, kernel-janitors@vger.kernel.org

On Wed, 02 Dec 2020 10:27:18 +0100 Martin Schiller wrote:
> On 2020-12-01 16:15, Dan Carpenter wrote:
> > The .x25_addr[] address comes from the user and is not necessarily
> > NUL terminated.  This leads to a couple problems.  The first problem is
> > that the strlen() in x25_bind() can read beyond the end of the buffer.
> >=20
> > The second problem is more subtle and could result in memory=20
> > corruption.
> > The call tree is:
> >   x25_connect() =20
> >   --> x25_write_internal()
> >       --> x25_addr_aton() =20
> >=20
> > The .x25_addr[] buffers are copied to the "addresses" buffer from
> > x25_write_internal() so it will lead to stack corruption.
> >=20
> > Verify that the strings are NUL terminated and return -EINVAL if they
> > are not.
> >=20
> > Reported-by: "kiyin(=E5=B0=B9=E4=BA=AE)" <kiyin@tencent.com>
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>=20
> Acked-by: Martin Schiller <ms@dev.tdt.de>

Applied, thanks!
