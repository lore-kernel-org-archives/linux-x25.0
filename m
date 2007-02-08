From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] X.25: Adds /proc/sys/net/x25/x25_forward to
 control forwarding.
Date: Thu, 08 Feb 2007 13:34:43 -0800 (PST)
Message-ID: <20070208.133443.30185813.davem@davemloft.net>
References: <1170890071.5189.40.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1170890071.5189.40.camel@localhost>
Sender: netdev-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ahendry@tusc.com.au
Cc: linux-x25@vger.kernel.org, eis@baty.hanse.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org

From: ahendry <ahendry@tusc.com.au>
Date: Thu, 08 Feb 2007 10:14:31 +1100

> echo "1" > /proc/sys/net/x25/x25_forward 
> To turn on x25_forwarding, defaults to off
> Requires the previous patch.
> 
> Signed-off-by: Andrew Hendry <andrew.hendry@gmail.com>

Applied.
