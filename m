From: Wang Weidong <wangweidong1@huawei.com>
Subject: Re: [PATCH] x25: convert printks to pr_<level>
Date: Thu, 5 Dec 2013 12:19:00 +0800
Message-ID: <529FFEB4.2030908@huawei.com>
References: <529FEDBC.9030302@huawei.com> <1386216573.30493.86.camel@joe-AO722>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1386216573.30493.86.camel@joe-AO722>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Joe Perches <joe@perches.com>
Cc: David Miller <davem@davemloft.net>, andrew.hendry@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

On 2013/12/5 12:09, Joe Perches wrote:
> On Thu, 2013-12-05 at 11:06 +0800, Wang Weidong wrote:
>> use pr_<level> instead of printk(LEVEL)
> 
> Consider adding
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> or
> #define pr_fmt(fmt) "X25: " fmt
> to each of these files before any #include
> and removing the leading "X25: " in each of
> the formats.
> 

Thanks for your suggestions. I will fix it in v2.

Regards.

> 
> 
> 
> 

