From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 4/4] [RFC] staging/net: move AF_X25 into drivers/staging
Date: Mon, 09 Dec 2019 10:29:50 -0800 (PST)
Message-ID: <20191209.102950.2248756181772063368.davem@davemloft.net>
References: <20191209151256.2497534-1-arnd@arndb.de>
        <20191209151256.2497534-4-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191209151256.2497534-4-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: arnd@arndb.de
Cc: khc@pm.waw.pl, gregkh@linuxfoundation.org, devel@driverdev.osuosl.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ebiggers@kernel.org, andrew.hendry@gmail.com, linux-x25@vger.kernel.org, kevin.curtis@farsite.com, bob.dunlop@farsite.com, qiang.zhao@nxp.com, syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com, syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  9 Dec 2019 16:12:56 +0100

> syzbot keeps finding issues in the X.25 implementation that nobody is
> interested in fixing.  Given that all the x25 patches of the past years
> that are not global cleanups tend to fix user-triggered oopses, is it
> time to just retire the subsystem?

I have a bug fix that I'm currently applying to 'net' right now actually:

	https://patchwork.ozlabs.org/patch/1205973/

So your proposal might be a bit premature.
