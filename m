From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/3] net/x25: fix called/calling length calculation in
 x25_parse_address_block
Date: Thu, 29 Nov 2018 14:26:02 -0800 (PST)
Message-ID: <20181129.142602.412517099403747959.davem@davemloft.net>
References: <20181127085029.9589-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127085029.9589-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: andrew.hendry@gmail.com, stephen@networkplumber.org, joe@perches.com, anto.cardace@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 27 Nov 2018 09:50:27 +0100

> The length of the called and calling address was not calculated
> correctly (BCD encoding).
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied.
