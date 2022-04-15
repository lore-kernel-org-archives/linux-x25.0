From: syzbot <syzbot+780995ea16fd2fad8f9b@syzkaller.appspotmail.com>
Subject: [syzbot] memory leak in lapb_send_control
Date: Fri, 15 Apr 2022 14:55:22 -0700
Message-ID: <000000000000a0ea7305dcb877f4@google.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, ms@dev.tdt.de, netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com

Hello,

syzbot found the following issue on:

HEAD commit:    a19944809fe9 Merge tag 'hardening-v5.18-rc3' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10498e14f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b8f1a3425e05af27
dashboard link: https://syzkaller.appspot.com/bug?extid=780995ea16fd2fad8f9b
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15de1c67700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1402da98f00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+780995ea16fd2fad8f9b@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810d526a00 (size 232):
  comm "kworker/0:3", pid 3257, jiffies 4294947579 (age 18.730s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 6a 52 0d 81 88 ff ff  .........jR.....
    00 f0 40 0c 81 88 ff ff 00 00 00 00 00 00 00 00  ..@.............
  backtrace:
    [<ffffffff837dc4f6>] __alloc_skb+0x216/0x290 net/core/skbuff.c:414
    [<ffffffff83d9ed04>] alloc_skb include/linux/skbuff.h:1300 [inline]
    [<ffffffff83d9ed04>] lapb_send_control+0x34/0x1b0 net/lapb/lapb_subr.c:227
    [<ffffffff83d9f536>] __lapb_disconnect_request+0xa6/0xc0 net/lapb/lapb_iface.c:326
    [<ffffffff83d9f7c5>] lapb_device_event+0x195/0x250 net/lapb/lapb_iface.c:492
    [<ffffffff8127ad5d>] notifier_call_chain kernel/notifier.c:84 [inline]
    [<ffffffff8127ad5d>] raw_notifier_call_chain+0x5d/0xa0 kernel/notifier.c:392
    [<ffffffff837fd4b8>] call_netdevice_notifiers_info+0x78/0xe0 net/core/dev.c:1938
    [<ffffffff837fde06>] call_netdevice_notifiers_extack net/core/dev.c:1976 [inline]
    [<ffffffff837fde06>] call_netdevice_notifiers net/core/dev.c:1990 [inline]
    [<ffffffff837fde06>] __dev_close_many+0x76/0x150 net/core/dev.c:1483
    [<ffffffff838024f3>] dev_close_many+0xc3/0x1b0 net/core/dev.c:1534
    [<ffffffff8380523e>] dev_close net/core/dev.c:1560 [inline]
    [<ffffffff8380523e>] dev_close+0xae/0xf0 net/core/dev.c:1554
    [<ffffffff82ab3283>] lapbeth_device_event+0x333/0x580 drivers/net/wan/lapbether.c:462
    [<ffffffff8127ad5d>] notifier_call_chain kernel/notifier.c:84 [inline]
    [<ffffffff8127ad5d>] raw_notifier_call_chain+0x5d/0xa0 kernel/notifier.c:392
    [<ffffffff837fd4b8>] call_netdevice_notifiers_info+0x78/0xe0 net/core/dev.c:1938
    [<ffffffff837fde06>] call_netdevice_notifiers_extack net/core/dev.c:1976 [inline]
    [<ffffffff837fde06>] call_netdevice_notifiers net/core/dev.c:1990 [inline]
    [<ffffffff837fde06>] __dev_close_many+0x76/0x150 net/core/dev.c:1483
    [<ffffffff838024f3>] dev_close_many+0xc3/0x1b0 net/core/dev.c:1534
    [<ffffffff838081bf>] unregister_netdevice_many+0x1df/0xac0 net/core/dev.c:10726
    [<ffffffff83808bd4>] unregister_netdevice_queue net/core/dev.c:10683 [inline]
    [<ffffffff83808bd4>] unregister_netdevice_queue+0x134/0x190 net/core/dev.c:10673

BUG: memory leak
unreferenced object 0xffff88810c66c400 (size 232):
  comm "kworker/0:1", pid 42, jiffies 4294948655 (age 7.970s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 c4 66 0c 81 88 ff ff  ..........f.....
    00 b0 16 11 81 88 ff ff 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff837dc4f6>] __alloc_skb+0x216/0x290 net/core/skbuff.c:414
    [<ffffffff83d9ed04>] alloc_skb include/linux/skbuff.h:1300 [inline]
    [<ffffffff83d9ed04>] lapb_send_control+0x34/0x1b0 net/lapb/lapb_subr.c:227
    [<ffffffff83d9f536>] __lapb_disconnect_request+0xa6/0xc0 net/lapb/lapb_iface.c:326
    [<ffffffff83d9f7c5>] lapb_device_event+0x195/0x250 net/lapb/lapb_iface.c:492
    [<ffffffff8127ad5d>] notifier_call_chain kernel/notifier.c:84 [inline]
    [<ffffffff8127ad5d>] raw_notifier_call_chain+0x5d/0xa0 kernel/notifier.c:392
    [<ffffffff837fd4b8>] call_netdevice_notifiers_info+0x78/0xe0 net/core/dev.c:1938
    [<ffffffff837fde06>] call_netdevice_notifiers_extack net/core/dev.c:1976 [inline]
    [<ffffffff837fde06>] call_netdevice_notifiers net/core/dev.c:1990 [inline]
    [<ffffffff837fde06>] __dev_close_many+0x76/0x150 net/core/dev.c:1483
    [<ffffffff838024f3>] dev_close_many+0xc3/0x1b0 net/core/dev.c:1534
    [<ffffffff8380523e>] dev_close net/core/dev.c:1560 [inline]
    [<ffffffff8380523e>] dev_close+0xae/0xf0 net/core/dev.c:1554
    [<ffffffff82ab3283>] lapbeth_device_event+0x333/0x580 drivers/net/wan/lapbether.c:462
    [<ffffffff8127ad5d>] notifier_call_chain kernel/notifier.c:84 [inline]
    [<ffffffff8127ad5d>] raw_notifier_call_chain+0x5d/0xa0 kernel/notifier.c:392
    [<ffffffff837fd4b8>] call_netdevice_notifiers_info+0x78/0xe0 net/core/dev.c:1938
    [<ffffffff837fde06>] call_netdevice_notifiers_extack net/core/dev.c:1976 [inline]
    [<ffffffff837fde06>] call_netdevice_notifiers net/core/dev.c:1990 [inline]
    [<ffffffff837fde06>] __dev_close_many+0x76/0x150 net/core/dev.c:1483
    [<ffffffff838024f3>] dev_close_many+0xc3/0x1b0 net/core/dev.c:1534
    [<ffffffff838081bf>] unregister_netdevice_many+0x1df/0xac0 net/core/dev.c:10726
    [<ffffffff83808bd4>] unregister_netdevice_queue net/core/dev.c:10683 [inline]
    [<ffffffff83808bd4>] unregister_netdevice_queue+0x134/0x190 net/core/dev.c:10673



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
