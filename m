From: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: x25 forward
Date: Sat, 27 Nov 2004 17:24:57 +0100
Message-ID: <m3wtw745uu.fsf@defiant.pm.waw.pl>
References: <41A5B137.6070405@siemens.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <41A5B137.6070405@siemens.com> (Ferenci Daniel's message of
 "Thu, 25 Nov 2004 11:17:27 +0100")
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ferenci Daniel <Daniel.Ferenci@siemens.com>
Cc: linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

Ferenci Daniel <Daniel.Ferenci@siemens.com> writes:

> +++ linux-2.4.25.intel/net/x25/af_x25.c	Sat Nov 13 09:30:12 2004
> @@ -26,6 +26,7 @@
>   *	2000-10-02	Henner Eisen	Made x25_kick() single threaded per socket.
>   *	2000-10-27	Henner Eisen    MSG_DONTWAIT for fragment allocation.
>   *	2000-11-14	Henner Eisen    Closing datalink from NETDEV_GOING_DOWN
> + *	2000-11-12	Daniel Ferenci	Forward capability added
        ^^^^
Some time warp machine, eh? :-)
-- 
Krzysztof Halasa
