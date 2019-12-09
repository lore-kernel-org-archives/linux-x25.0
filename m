From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] net/x25: add new state X25_STATE_5
Date: Mon, 09 Dec 2019 10:33:01 -0800 (PST)
Message-ID: <20191209.103301.2153422263511234336.davem@davemloft.net>
References: <20191209072134.19746-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191209072134.19746-1-ms@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: andrew.hendry@gmail.com, edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Mon,  9 Dec 2019 08:21:34 +0100

> This is needed, because if the flag X25_ACCPT_APPRV_FLAG is not set on a
> socket (manual call confirmation) and the channel is cleared by remote
> before the manual call confirmation was sent, this situation needs to
> be handled.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied, thank you.
