From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
Subject: Re: x25_create initializing socket data twice ...
Date: Thu, 3 Mar 2005 16:37:13 -0300
Message-ID: <20050303193712.GC1587@cathedrallabs.org>
References: <20050303011413.GB11516@mail.13thfloor.at> <1109820054.3014.146.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1109820054.3014.146.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Hendry <ahendry@tusc.com.au>
Cc: Herbert Poetzl <herbert@13thfloor.at>, eis@baty.hanse.de, linux-x25@vger.kernel.org, Linux Kernel ML <linux-kernel@vger.kernel.org>

Hi,
> On the same path sk_set_owner also gets called twice, I think this
> causes double module use count when creating sockets. Module use count
> need some attention all over x25.
I'm working on it already. I hope to send patches soon.

Is linux-x25 list alive? if not, perhaps we should add netdev to Cc.

--
Aristeu
