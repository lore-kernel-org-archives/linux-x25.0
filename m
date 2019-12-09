From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/4] [RFC] staging/net: move AF_X25 into drivers/staging
Date: Mon, 9 Dec 2019 20:26:56 +0100
Message-ID: <CAK8P3a25UGV1KS1ufZsyQJk1+9Rp9is0x6eOU7pr5Xf6Z3N2gA@mail.gmail.com>
References: <20191209151256.2497534-1-arnd@arndb.de> <20191209151256.2497534-4-arnd@arndb.de>
 <20191209.102950.2248756181772063368.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209.102950.2248756181772063368.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: khc@pm.waw.pl, gregkh <gregkh@linuxfoundation.org>, driverdevel <devel@driverdev.osuosl.org>, Networking <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Biggers <ebiggers@kernel.org>, Andrew Hendry <andrew.hendry@gmail.com>, linux-x25@vger.kernel.org, Kevin Curtis <kevin.curtis@farsite.com>, "R.J.Dunlop" <bob.dunlop@farsite.com>, Qiang Zhao <qiang.zhao@nxp.com>, Martin Schiller <ms@dev.tdt.de>

On Mon, Dec 9, 2019 at 7:29 PM David Miller <davem@davemloft.net> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Mon,  9 Dec 2019 16:12:56 +0100
>
> > syzbot keeps finding issues in the X.25 implementation that nobody is
> > interested in fixing.  Given that all the x25 patches of the past years
> > that are not global cleanups tend to fix user-triggered oopses, is it
> > time to just retire the subsystem?
>
> I have a bug fix that I'm currently applying to 'net' right now actually:
>
>         https://patchwork.ozlabs.org/patch/1205973/
>
> So your proposal might be a bit premature.

Ok, makes sense. Looking back in the history, I also see other bugfixes
from the same author.

Adding Martin Schiller to Cc: for a few questions:

- What hardware are you using for X.25?
- Would you be available to be listed in the MAINTAINERS file
  as a contact for net/x25?
- Does your bug fix address the latest issue found by syzbot[1],
  or do you have an idea to fix it if not?

        Arnd

[1] https://lore.kernel.org/netdev/CAK8P3a0LdF+aQ1hnZrVKkNBQaum0WqW1jyR7_Eb+JRiwyHWr6Q@mail.gmail.com/
