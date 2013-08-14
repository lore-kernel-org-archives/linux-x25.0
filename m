From: Dave Jones <davej@redhat.com>
Subject: Re: s2disk broken (bisected) in 3.10.4
Date: Wed, 14 Aug 2013 18:23:22 -0400
Message-ID: <20130814222322.GA2621@redhat.com>
References: <520BE4CA.8090000@gmx.de>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <520BE4CA.8090000@gmx.de>
Sender: stable-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: stable@vger.kernel.org, linux-x25@vger.kernel.org

On Wed, Aug 14, 2013 at 10:12:58PM +0200, Toralf F=F6rster wrote:
 > The following bisected commit=20
 >=20
 >=20
 > commit ea4c218f2c3e67f1bca8078ff1f80d7e0c2ab791
 > Author: Dave Jones <davej@redhat.com>
 > Date:   Fri Jun 28 12:13:52 2013 -0400
 >=20
 >     x25: Fix broken locking in ioctl error paths.
 >=20
 >     [ Upstream commit 4ccb93ce7439b63c31bc7597bfffd13567fa483d ]
 >=20
 >     Two of the x25 ioctl cases have error paths that break out of th=
e function without
 >     unlocking the socket, leading to this warning:
 >=20
 >=20
 >=20
 > breaks s2disk at a 32 bit stable Gentoo Linux (booted from an extern=
al USB drive).
 > Reverting that commit on top of 3.10.6 solved the issue.
 >=20
 > After wakeup the cursor doesn't blink and the systems just hangs, ma=
gic sysrq works fortunately.

<sceptical hat on>

Are you actually using x25 ?

	Dave
