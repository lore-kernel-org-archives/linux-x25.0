From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/x25: fix nonblocking connect
Date: Thu, 09 Jan 2020 18:40:08 -0800 (PST)
Message-ID: <20200109.184008.1039668214219996565.davem@davemloft.net>
References: <CAK8P3a0LdF+aQ1hnZrVKkNBQaum0WqW1jyR7_Eb+JRiwyHWr6Q@mail.gmail.com>
        <20200109063114.23195-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200109063114.23195-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: arnd@arndb.de, andrew.hendry@gmail.com, edumazet@google.com, gregkh@linuxfoundation.org, tglx@linutronix.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com, syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com

From: Martin Schiller <ms@dev.tdt.de>
Date: Thu,  9 Jan 2020 07:31:14 +0100

> This patch fixes 2 issues in x25_connect():
> 
> 1. It makes absolutely no sense to reset the neighbour and the
> connection state after a (successful) nonblocking call of x25_connect.
> This prevents any connection from being established, since the response
> (call accept) cannot be processed.
> 
> 2. Any further calls to x25_connect() while a call is pending should
> simply return, instead of creating new Call Request (on different
> logical channels).
> 
> This patch should also fix the "KASAN: null-ptr-deref Write in
> x25_connect" and "BUG: unable to handle kernel NULL pointer dereference
> in x25_connect" bugs reported by syzbot.
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
> Reported-by: syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com
> Reported-by: syzbot+eec0c87f31a7c3b66f7b@syzkaller.appspotmail.com

Applied and queued up for -stable, thanks.
