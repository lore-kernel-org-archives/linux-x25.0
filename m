From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] net/x25: do not hold the cpu too long in
 x25_new_lci()
Date: Mon, 11 Feb 2019 13:20:42 -0800 (PST)
Message-ID: <20190211.132042.529132709200315406.davem@davemloft.net>
References: <20190208204105.16314-1-edumazet@google.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190208204105.16314-1-edumazet@google.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: edumazet@google.com
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com, andrew.hendry@gmail.com, linux-x25@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  8 Feb 2019 12:41:05 -0800

> Due to quadratic behavior of x25_new_lci(), syzbot was able
> to trigger an rcu stall.
> 
> Fix this by not blocking BH for the whole duration of
> the function, and inserting a reschedule point when possible.
> 
> If we care enough, using a bitmap could get rid of the quadratic
> behavior.
> 
> syzbot report :
 ...
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reported-by: syzbot <syzkaller@googlegroups.com>

Applied, thanks.
