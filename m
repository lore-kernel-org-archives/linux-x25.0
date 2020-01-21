From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v4 1/2] wan/hdlc_x25: make lapb params configurable
Date: Tue, 21 Jan 2020 11:41:52 +0100 (CET)
Message-ID: <20200121.114152.532453946458399573.davem@davemloft.net>
References: <20200121060034.30554-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200121060034.30554-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: kubakici@wp.pl, khc@pm.waw.pl, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 21 Jan 2020 07:00:33 +0100

> This enables you to configure mode (DTE/DCE), Modulo, Window, T1, T2, N2 via
> sethdlc (which needs to be patched as well).
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied to net-next.
