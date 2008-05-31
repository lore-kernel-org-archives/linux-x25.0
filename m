From: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH 4/4] Hold RTNL while calling dev_close()
Date: Sat, 31 May 2008 17:01:30 +0100
Message-ID: <20080531160129.GO1743@solarflare.com>
References: <20080506182654.GF2217@solarflare.com> <20080506184147.GJ2217@solarflare.com> <20080508.025414.182489217.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080508.025414.182489217.davem@davemloft.net>
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-x25@vger.kernel.org
Cc: davem@davemloft.net, jgarzik@pobox.com

David Miller wrote:
> From: Ben Hutchings <bhutchings@solarflare.com>
> Date: Tue, 6 May 2008 19:41:48 +0100
> 
> > dev_close() must be called holding the RTNL.  Compile-tested only.
> > 
> > Signed-off-by: Ben Hutchings <bhutchings@solarflare.com>
> 
> Acked-by: David S. Miller <davem@davemloft.net>
> 
> Jeff, please grab this one too.

I don't see any sign that this has been applied.  Could maybe do
with an ACK or NAK from linux-x25?

Ben.

-- 
Ben Hutchings, Senior Software Engineer, Solarflare Communications
Not speaking for my employer; that's the marketing department's job.
