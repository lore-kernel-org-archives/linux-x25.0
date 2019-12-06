From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: KASAN: null-ptr-deref Write in x25_connect
Date: Fri, 6 Dec 2019 13:41:10 +0100
Message-ID: <CAK8P3a0LdF+aQ1hnZrVKkNBQaum0WqW1jyR7_Eb+JRiwyHWr6Q@mail.gmail.com>
References: <0000000000009bd693059905b445@google.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <0000000000009bd693059905b445@google.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: syzbot <syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-x25@vger.kernel.org, Networking <netdev@vger.kernel.org>, syzkaller-bugs <syzkaller-bugs@googlegroups.com>, Thomas Gleixner <tglx@linutronix.de>, Willem de Bruijn <willemb@google.com>, Kevin Curtis <kevin.curtis@farsite.com>, "R.J.Dunlop" <bob.dunlop@farsite.com>

On Fri, Dec 6, 2019 at 10:31 AM syzbot
<syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    9bd19c63 net: emulex: benet: indent a Kconfig depends cont..

This is a whitespace change, so clearly not the root cause.

> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=14b858eae00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=333b76551307b2a0
> dashboard link: https://syzkaller.appspot.com/bug?extid=429c200ffc8772bfe070
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+429c200ffc8772bfe070@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: null-ptr-deref in atomic_fetch_sub
> include/asm-generic/atomic-instrumented.h:199 [inline]
> BUG: KASAN: null-ptr-deref in refcount_sub_and_test
> include/linux/refcount.h:253 [inline]
> BUG: KASAN: null-ptr-deref in refcount_dec_and_test
> include/linux/refcount.h:281 [inline]
> BUG: KASAN: null-ptr-deref in x25_neigh_put include/net/x25.h:252 [inline]
> BUG: KASAN: null-ptr-deref in x25_connect+0x974/0x1020 net/x25/af_x25.c:820
> Write of size 4 at addr 00000000000000c8 by task syz-executor.5/32400
>
> CPU: 1 PID: 32400 Comm: syz-executor.5 Not tainted 5.4.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 01/01/2011
> Call Trace:
>   __dump_stack lib/dump_stack.c:77 [inline]
>   dump_stack+0x197/0x210 lib/dump_stack.c:118
>   __kasan_report.cold+0x5/0x41 mm/kasan/report.c:510
>   kasan_report+0x12/0x20 mm/kasan/common.c:634
>   check_memory_region_inline mm/kasan/generic.c:185 [inline]
>   check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
>   __kasan_check_write+0x14/0x20 mm/kasan/common.c:98
>   atomic_fetch_sub include/asm-generic/atomic-instrumented.h:199 [inline]
>   refcount_sub_and_test include/linux/refcount.h:253 [inline]
>   refcount_dec_and_test include/linux/refcount.h:281 [inline]
>   x25_neigh_put include/net/x25.h:252 [inline]
>   x25_connect+0x974/0x1020 net/x25/af_x25.c:820
>   __sys_connect_file+0x25d/0x2e0 net/socket.c:1847
>   __sys_connect+0x51/0x90 net/socket.c:1860
>   __do_sys_connect net/socket.c:1871 [inline]
>   __se_sys_connect net/socket.c:1868 [inline]
>   __x64_sys_connect+0x73/0xb0 net/socket.c:1868
>   do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
>   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x45a679
> Code: ad b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7
> 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> ff 0f 83 7b b6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> RSP: 002b:00007fa58a10ec78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045a679
> RDX: 0000000000000012 RSI: 0000000020000000 RDI: 0000000000000004
> RBP: 000000000075bf20 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa58a10f6d4
> R13: 00000000004c0f1c R14: 00000000004d4088 R15: 00000000ffffffff
> ==================================================================

Eric Dumazet fixed a related bug in commit 95d6ebd53c79 ("net/x25: fix
use-after-free
in x25_device_event()"):

--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -820,8 +820,12 @@ static int x25_connect(struct socket *sock,
struct sockaddr *uaddr,
        sock->state = SS_CONNECTED;
        rc = 0;
 out_put_neigh:
-       if (rc)
+       if (rc) {
+               read_lock_bh(&x25_list_lock);
                x25_neigh_put(x25->neighbour);
+               x25->neighbour = NULL;
+               read_unlock_bh(&x25_list_lock);
+       }
 out_put_route:
        x25_route_put(rt);
 out:

The most likely explanation I see is that we have two concurrent calls
to x25_connect racing in this code, so x25->neighbour is set to NULL
in one thread while another thread calls x25_neigh_put() on that pointer.

Given that all the x25 patches of the past years that are not global cleanups
tend to fix user-triggered oopses, is it time to just retire the subsystem?

I looked a bit closer and found:

- we used to support x25 hardware in linux, but with WAN_ROUTER
  removed in linux-3.9 and isdn4linux removed in 5.3, there is only
  hdlc, ethernet and the N_X25 tty ldisc left. Out of these, only
  HDLC_X25 made it beyond the experimental stage, so this is
  probably what everyone uses if there are users at all.

- The only common hdlc hardware that people seem to be using are
  the "farsync" PCIe and USB adapters. Linux only has drivers for
  the older PCI devices from that series, but no hardware that works
  on modern systems.

- The manufacturer still updates their own kernel drivers and provides
  support, but ships that with a fork or rewrite of the subsystem code now.
  Kevin Curtis is also listed as maintainer, but appears to have given
  up in 2013 after [1].

- The most popular software implementation appears to be X25 over TCP
  (XOT), which is supported by Farsite and other out-of-tree stacks
  but never had an implementation in mainline.

- The subsystem is listed as "odd fixes", but the last reply on the netdev
  mailing list from the maintainer was also in 2013[2].

      Arnd

[1] https://lore.kernel.org/netdev/E603DC592C92B54A89CEF6B0919A0B1CAAAA787DA4@SOLO.hq.farsitecommunications.com/
[2] https://lore.kernel.org/netdev/CADo0ohh7jZhc_WJFkrYYxoYza8ZeSEadzwgwabJWwQ1TucdCcg@mail.gmail.com/
