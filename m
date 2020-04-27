From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2] net/x25: Fix x25_neigh refcnt leak when x25
 disconnect
Date: Mon, 27 Apr 2020 11:20:54 -0700 (PDT)
Message-ID: <20200427.112054.486660514927430577.davem@davemloft.net>
References: <1587819994-40137-1-git-send-email-xiyuyang19@fudan.edu.cn>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1587819994-40137-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xiyuyang19@fudan.edu.cn
Cc: andrew.hendry@gmail.com, kuba@kernel.org, tanxin.ctf@gmail.com, gregkh@linuxfoundation.org, allison@lohutok.net, tglx@linutronix.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Date: Sat, 25 Apr 2020 21:06:25 +0800

> x25_connect() invokes x25_get_neigh(), which returns a reference of the
> specified x25_neigh object to "x25->neighbour" with increased refcnt.
> 
> When x25 connect success and returns, the reference still be hold by
> "x25->neighbour", so the refcount should be decreased in
> x25_disconnect() to keep refcount balanced.
> 
> The reference counting issue happens in x25_disconnect(), which forgets
> to decrease the refcnt increased by x25_get_neigh() in x25_connect(),
> causing a refcnt leak.
> 
> Fix this issue by calling x25_neigh_put() before x25_disconnect()
> returns.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Applied.
