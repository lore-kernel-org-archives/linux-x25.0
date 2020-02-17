From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net: x25: convert to list_for_each_entry_safe()
Date: Sun, 16 Feb 2020 18:59:58 -0800 (PST)
Message-ID: <20200216.185958.576122723709663295.davem@davemloft.net>
References: <1581671906-25193-1-git-send-email-qiwuchen55@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1581671906-25193-1-git-send-email-qiwuchen55@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: qiwuchen55@gmail.com
Cc: andrew.hendry@gmail.com, kuba@kernel.org, allison@lohutok.net, tglx@linutronix.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org, chenqiwu@xiaomi.com

From: qiwuchen55@gmail.com
Date: Fri, 14 Feb 2020 17:18:26 +0800

> From: chenqiwu <chenqiwu@xiaomi.com>
> 
> Use list_for_each_entry_safe() instead of list_for_each_safe()
> to simplify the code.
> 
> Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>

Applied to net-next.
