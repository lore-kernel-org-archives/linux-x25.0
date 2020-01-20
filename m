From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 1/2] wan/hdlc_x25: make lapb params configurable
Date: Mon, 20 Jan 2020 13:14:24 +0100 (CET)
Message-ID: <20200120.131424.39658950858121597.davem@davemloft.net>
References: <20200120061416.27714-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200120061416.27714-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: kubakici@wp.pl, khc@pm.waw.pl, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Mon, 20 Jan 2020 07:14:15 +0100

> +static struct x25_state *state(hdlc_device *hdlc)
> +{
> +	return (struct x25_state *)hdlc->state;
> +}

Because hdlc->state is "void *", this cast is unnecessary.
