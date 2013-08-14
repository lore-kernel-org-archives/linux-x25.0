From: =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: s2disk broken (bisected) in 3.10.4
Date: Wed, 14 Aug 2013 22:12:58 +0200
Message-ID: <520BE4CA.8090000@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Dave Jones <davej@redhat.com>
Cc: stable@vger.kernel.org, linux-x25@vger.kernel.org

The following bisected commit=20


commit ea4c218f2c3e67f1bca8078ff1f80d7e0c2ab791
Author: Dave Jones <davej@redhat.com>
Date:   Fri Jun 28 12:13:52 2013 -0400

    x25: Fix broken locking in ioctl error paths.

    [ Upstream commit 4ccb93ce7439b63c31bc7597bfffd13567fa483d ]

    Two of the x25 ioctl cases have error paths that break out of the f=
unction without
    unlocking the socket, leading to this warning:



breaks s2disk at a 32 bit stable Gentoo Linux (booted from an external =
USB drive).
Reverting that commit on top of 3.10.6 solved the issue.

After wakeup the cursor doesn't blink and the systems just hangs, magic=
 sysrq works fortunately.

--=20
MfG/Sincerely
Toralf F=C3=B6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
