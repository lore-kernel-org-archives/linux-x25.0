From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 2/3] net/x25: fix null_x25_address handling
Date: Thu, 29 Nov 2018 14:26:09 -0800 (PST)
Message-ID: <20181129.142609.820562472340154653.davem@davemloft.net>
References: <20181127085029.9589-1-ms@dev.tdt.de>
        <20181127085029.9589-2-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181127085029.9589-2-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: andrew.hendry@gmail.com, stephen@networkplumber.org, joe@perches.com, anto.cardace@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 27 Nov 2018 09:50:28 +0100

>  o x25_find_listener(): the compare for the null_x25_address was wrong.
>    We have to check the x25_addr of the listener socket instead of the
>    x25_addr of the incomming call.
> 
>  o x25_bind(): it was not possible to bind a socket to null_x25_address
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied.
