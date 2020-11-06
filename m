From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next] net: x25_asy: Delete the x25_asy driver
Date: Fri, 06 Nov 2020 06:43:53 +0100
Message-ID: <927918413d7c2e515e61d751b2424886@dev.tdt.de>
References: <20201105073434.429307-1-xie.he.0141@gmail.com>
 <CAK8P3a2bk9ZpoEvmhDpSv8ByyO-LevmF-W4Or_6RPRtV6gTQ1w@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a2bk9ZpoEvmhDpSv8ByyO-LevmF-W4Or_6RPRtV6gTQ1w@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Arnd Bergmann <arnd@kernel.org>
Cc: Xie He <xie.he.0141@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Andrew Hendry <andrew.hendry@gmail.com>, linux-x25@vger.kernel.org

On 2020-11-05 16:06, Arnd Bergmann wrote:
> ...
> Adding Martin Schiller and Andrew Hendry, plus the linux-x25 mailing
> list to Cc. When I last looked at the wan drivers, I think I concluded
> that this should still be kept around, but I do not remember why.
> OTOH if it was broken for a long time, that is a clear indication that
> it was in fact unused.

As Xie has already mentioned, the linux-x25 mailing list unfortunately
is broken for a long time. Maybe David could have a look at this.

I still use the X.25 subsystem together with the hdlc-x25 driver and as
I wrote some time ago this will continue for some time.

I'm also still contributing patches for it (even if only drop by drop).

But I have never used the x25_asy driver.

> ...
> 
> Hopefully Martin or Andrew can provide a definite Ack or Nack on this.
> 

ACK from my side, even if I'm a bit sorry about the work of Xie.

Acked-by: Martin Schiller <ms@dev.tdt.de>
