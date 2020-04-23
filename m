From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/x25: Fix x25_neigh refcnt leak when reveiving frame
Date: Thu, 23 Apr 2020 15:49:49 -0700 (PDT)
Message-ID: <20200423.154949.459034580485896359.davem@davemloft.net>
References: <1587618786-13481-1-git-send-email-xiyuyang19@fudan.edu.cn>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1587618786-13481-1-git-send-email-xiyuyang19@fudan.edu.cn>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: xiyuyang19@fudan.edu.cn
Cc: andrew.hendry@gmail.com, kuba@kernel.org, gregkh@linuxfoundation.org, edumazet@google.com, allison@lohutok.net, tglx@linutronix.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, yuanxzhang@fudan.edu.cn, kjlu@umn.edu, tanxin.ctf@gmail.com

From: Xiyu Yang <xiyuyang19@fudan.edu.cn>
Date: Thu, 23 Apr 2020 13:13:03 +0800

> x25_lapb_receive_frame() invokes x25_get_neigh(), which returns a
> reference of the specified x25_neigh object to "nb" with increased
> refcnt.
> 
> When x25_lapb_receive_frame() returns, local variable "nb" becomes
> invalid, so the refcount should be decreased to keep refcount balanced.
> 
> The reference counting issue happens in one path of
> x25_lapb_receive_frame(). When pskb_may_pull() returns false, the
> function forgets to decrease the refcnt increased by x25_get_neigh(),
> causing a refcnt leak.
> 
> Fix this issue by calling x25_neigh_put() when pskb_may_pull() returns
> false.
> 
> Signed-off-by: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> Signed-off-by: Xin Tan <tanxin.ctf@gmail.com>

Applied and queued up for -stable, thanks.
