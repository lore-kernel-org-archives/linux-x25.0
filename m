From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/x25: add new state X25_STATE_5
Date: Sat, 07 Dec 2019 11:59:22 -0800 (PST)
Message-ID: <20191207.115922.532322440743611081.davem@davemloft.net>
References: <20191206133418.14075-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191206133418.14075-1-ms@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: andrew.hendry@gmail.com, edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Fri,  6 Dec 2019 14:34:18 +0100

> +	switch (frametype) {
> +
> +		case X25_CLEAR_REQUEST:

Please remove this unnecessary empty line.

> +			if (!pskb_may_pull(skb, X25_STD_MIN_LEN + 2))
> +				goto out_clear;

A goto path for a single call site?  Just inline the operations here.

