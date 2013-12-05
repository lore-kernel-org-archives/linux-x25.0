From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] x25: convert printks to pr_<level>
Date: Wed, 04 Dec 2013 20:09:33 -0800
Message-ID: <1386216573.30493.86.camel@joe-AO722>
References: <529FEDBC.9030302@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <529FEDBC.9030302@huawei.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Wang Weidong <wangweidong1@huawei.com>
Cc: David Miller <davem@davemloft.net>, andrew.hendry@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

On Thu, 2013-12-05 at 11:06 +0800, Wang Weidong wrote:
> use pr_<level> instead of printk(LEVEL)

Consider adding
#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
or
#define pr_fmt(fmt) "X25: " fmt
to each of these files before any #include
and removing the leading "X25: " in each of
the formats.


