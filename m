From: "David S. Miller" <davem@davemloft.net>
Subject: Re: [2.6 patch] net/x25/: some cleanups
Date: Mon, 27 Dec 2004 18:59:55 -0800
Message-ID: <20041227185955.132a8693.davem@davemloft.net>
References: <20041212212318.GB22324@stusta.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-bounce@oss.sgi.com>
In-Reply-To: <20041212212318.GB22324@stusta.de>
Sender: netdev-bounce@oss.sgi.com
Errors-to: netdev-bounce@oss.sgi.com
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Adrian Bunk <bunk@stusta.de>
Cc: eis@baty.hanse.de, linux-x25@vger.kernel.org, netdev@oss.sgi.com, linux-kernel@vger.kernel.org

On Sun, 12 Dec 2004 22:23:18 +0100
Adrian Bunk <bunk@stusta.de> wrote:

> The patch below includes the following cleanups:
> - make some needlessly global code static
> - remove the following unused global functions:
>   - net/x25/x25_dev.c: x25_llc_receive_frame
>   - net/x25/x25_link.c: x25_transmit_diagnostic

Applied, thanks Adrian.

