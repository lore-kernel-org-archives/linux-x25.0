From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH net-next] net: x25: Remove unimplemented X.25-over-LLC
 code stubs
Date: Wed, 9 Dec 2020 21:21:53 +0000
Message-ID: <801dc0320e484bf7a5048c0cddac12af@AcuMS.aculab.com>
References: <20201209033346.83742-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20201209033346.83742-1-xie.he.0141@gmail.com>
Content-Language: en-US
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Xie He' <xie.he.0141@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

From: Xie He
> Sent: 09 December 2020 03:34
> 
> According to the X.25 documentation, there was a plan to implement
> X.25-over-802.2-LLC. It never finished but left various code stubs in the
> X.25 code. At this time it is unlikely that it would ever finish so it
> may be better to remove those code stubs.

I always wondered about running Class 2 transport directly over LLC2
(rather than Class 4 over LLC1).
But the only LLC2 user was netbios - and microsoft's LLC2 was broken.
Not to mention the window probing needed to handle systems that
said they supported a window of (IIRC) 15 but would discard the
5th back to back frame.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

