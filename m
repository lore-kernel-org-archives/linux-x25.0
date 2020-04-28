From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/x25: Fix null-ptr-deref in x25_disconnect
Date: Tue, 28 Apr 2020 14:11:11 -0700 (PDT)
Message-ID: <20200428.141111.54288142814578996.davem@davemloft.net>
References: <000000000000cbf17205a452ad4f@google.com>
        <20200428081208.26308-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200428081208.26308-1-yuehaibing@huawei.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: yuehaibing@huawei.com
Cc: andrew.hendry@gmail.com, kuba@kernel.org, allison@lohutok.net, tglx@linutronix.de, gregkh@linuxfoundation.org, tanxin.ctf@gmail.com, xiyuyang19@fudan.edu.cn, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Tue, 28 Apr 2020 16:12:08 +0800

> We should check null before do x25_neigh_put in x25_disconnect,
> otherwise may cause null-ptr-deref like this:
...
> Reported-by: syzbot+6db548b615e5aeefdce2@syzkaller.appspotmail.com
> Fixes: 4becb7ee5b3d ("net/x25: Fix x25_neigh refcnt leak when x25 disconnect")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
