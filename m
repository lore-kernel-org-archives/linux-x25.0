From: Andrew Hendry <ahendry@tusc.com.au>
Subject: Re: [PATCH] 2.6.11.7  X.25 : x25tap
Date: Fri, 29 Apr 2005 10:03:51 +1000
Message-ID: <1114733031.3725.5.camel@localhost.localdomain>
References: <1114576764.4789.36.camel@localhost.localdomain>
	 <20050428174309.GP23013@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20050428174309.GP23013@shell0.pdx.osdl.net>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Chris Wright <chrisw@osdl.org>
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org

Thanks for the feedback.

> Can this not be done with tun/tap?  Ethertap is gone:

I don't think tun/tap itself can do it. I'll look how it works and see
if something similar could do what we need.

Andrew.

