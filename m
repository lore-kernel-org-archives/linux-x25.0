From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] drivers/net/wan/x25_asy: Fix to make it work
Date: Tue, 21 Jul 2020 18:30:22 -0700 (PDT)
Message-ID: <20200721.183022.1464053417235565089.davem@davemloft.net>
References: <20200716234433.6490-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200716234433.6490-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xie.he.0141@gmail.com
Cc: kuba@kernel.org, edumazet@google.com, ms@dev.tdt.de, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

From: Xie He <xie.he.0141@gmail.com>
Date: Thu, 16 Jul 2020 16:44:33 -0700

> This driver is not working because of problems of its receiving code.
> This patch fixes it to make it work.
> 
> When the driver receives an LAPB frame, it should first pass the frame
> to the LAPB module to process. After processing, the LAPB module passes
> the data (the packet) back to the driver, the driver should then add a
> one-byte pseudo header and pass the data to upper layers.
> 
> The changes to the "x25_asy_bump" function and the
> "x25_asy_data_indication" function are to correctly implement this
> procedure.
> 
> Also, the "x25_asy_unesc" function ignores any frame that is shorter
> than 3 bytes. However the shortest frames are 2-byte long. So we need
> to change it to allow 2-byte frames to pass.
> 
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Applied, thank you.
