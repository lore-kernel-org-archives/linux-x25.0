From: Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] 2.6.11.7  X.25 : x25tap
Date: Thu, 28 Apr 2005 10:43:09 -0700
Message-ID: <20050428174309.GP23013@shell0.pdx.osdl.net>
References: <1114576764.4789.36.camel@localhost.localdomain>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1114576764.4789.36.camel@localhost.localdomain>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Hendry <ahendry@tusc.com.au>
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org

* Andrew Hendry (ahendry@tusc.com.au) wrote:
> 
> Adds an x25tap module, like ethertap for X.25.

Can this not be done with tun/tap?  Ethertap is gone:

ChangeSet@1.2199.8.34, 2005-03-22 19:20:39-08:00, davem@sunset.davemloft.net
  [NET]: Kill NETLINK_DEV and its only user, ethertap.

  This stuff has been scheduled to die for 2 years.

thanks,
-chris
