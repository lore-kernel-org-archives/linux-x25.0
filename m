From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 3/3] net/x25: handle call collisions
Date: Thu, 29 Nov 2018 14:26:15 -0800 (PST)
Message-ID: <20181129.142615.2049253532690656553.davem@davemloft.net>
References: <20181127085029.9589-1-ms@dev.tdt.de>
        <20181127085029.9589-3-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181127085029.9589-3-ms@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: andrew.hendry@gmail.com, stephen@networkplumber.org, joe@perches.com, anto.cardace@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 27 Nov 2018 09:50:29 +0100

> If a session in X25_STATE_1 (Awaiting Call Accept) receives a call
> request, the session will be closed (x25_disconnect), cause=0x01
> (Number Busy) and diag=0x48 (Call Collision) will be set and a clear
> request will be send.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

Applied.
