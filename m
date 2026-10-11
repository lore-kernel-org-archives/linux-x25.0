Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD52110E
	for <linux-x25@vger.kernel.org>; Sun, 11 Oct 2026 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791677017; cv=none; b=n/Kz0dLFDM4dEwj9cQVRHWHTdxecKWo3I6VYRknW9YN60OlNYfzbK9Oej52P1f1glgvtpn+hO7JUuuD0P7+Bl3CC8pM9W4G99My0jhBvxQLNTCJ0PH1JYCvAJfLv3QI/ePW73YvJGQwpJUkGsmepYhuD6HTH4eCCvBqojrflV/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791677017; c=relaxed/simple;
	bh=QSOP/kYCpEGF7svKaFsq3hzt3Oy8wWXLUjk1jQb3R38=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=PUR4yc4rqdlQNvn8P/RoWrku8W+nkmIWPCwzm+2EOO8lRBRfV5rj4BcgyK7HNahQWt2VC0V8sTJE+fVJqkSWmuzlj1kjnZhyWXh/ZepnYnmaywKBhpseBgt6T8iqEGv6uaV38j3D42v03lUoBrqnpWffCC5SYyiiYLRxV7qR6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4dab94dc3e7so1773651b6e.0
        for <linux-x25@vger.kernel.org>; Sat, 10 Oct 2026 17:03:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791677014; x=1792281814;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CHGlembCHFZmJ6IcSYqXwq5eMI0DR636Yv8gH9CHiDE=;
        b=v1Wp5pP4MQi6KgqhdBlbxElzMJVDlBb0Cu9D//7oOQmcfmHSTtyTV6q0/VD6BYEPfe
         nvBNK0b+dY/lycc0DQuoZq1AfKNtBQ7ySqaDIUSwglks2ZLVdZNZp+85ymov0MvLomI9
         CWfmGRM3SrHpfv9lFmeynerDVeHR2vR/iwIVFan38YswdcM+eqU9hdNZWm8B466QO0IS
         dG+liqYjJI6h4xZ01eYdzJhbwwGS+XG8oJzHSN+Ae3gtuOBU1VqzxrYcDbZ8l+9mqyGw
         I0yIGFatcNumwTiDO4/T6KACuQ/55yFbsehTdTUmBYj7ng1BkhNvYIkcXpO3u7iE2L14
         6oDg==
X-Forwarded-Encrypted: i=1; AKwUvBxi6XNJ/8c64bolMXQEBVeTxn7k1LEay0yo9FVIjfRqVOHkCIqRPMudUmh4vTUxkAYvHrQSBVjH2rQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3O7monRJoLgCs53BePGWO/mKu8vojWp8QY1OP42+UVyB+qFwm
	RU6B3Yd2aVqr+SlKLoFPYXitPYdlMA/KNGSWmxpUwkbIvIUlYfPUk5RqKSk0j9iQLAjvxPjj72u
	1642z7pm0nvbUEu3k22iQvWqN82iMe/8W/RQQOGSxVKL4jhhginHNqdnRCIQ=
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:e89:b0:4d5:27da:a496 with SMTP id
 5614622812f47-50c54842256mr4789336b6e.48.1791677014736; Sat, 10 Oct 2026
 17:03:34 -0700 (PDT)
Date: Sat, 10 Oct 2026 17:03:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6acad256.a150a118.27e199.0030.GAE@google.com>
Subject: [syzbot] [x25?] inconsistent lock state in x25_kill_by_neigh (2)
From: syzbot <syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, 
	ms@dev.tdt.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    602042bf29f6 Merge tag 'wq-for-7.3-rc6-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d66715580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=929e4854a828f434
dashboard link: https://syzkaller.appspot.com/bug?extid=300375dfd44665f063a6
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115d5f25580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146adff5580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-602042bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c804d2e9b640/vmlinux-602042bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d6cd162ae59e/bzImage-602042bf.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+300375dfd44665f063a6@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
syzkaller #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/0/15 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffff88802c938260 (sk_lock-AF_X25){+.?.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
ffff88802c938260 (sk_lock-AF_X25){+.?.}-{0:0}, at: x25_kill_by_neigh+0x168/0x280 net/x25/af_x25.c:1778
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire kernel/locking/lockdep.c:5942 [inline]
  lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
  lock_sock_nested+0x41/0xf0 net/core/sock.c:3837
  lock_sock include/net/sock.h:1713 [inline]
  x25_bind+0x221/0x5c0 net/x25/af_x25.c:694
  __sys_bind_socket net/socket.c:1945 [inline]
  __sys_bind_socket net/socket.c:1937 [inline]
  __sys_bind+0x1a9/0x260 net/socket.c:1976
  __do_sys_bind net/socket.c:1981 [inline]
  __se_sys_bind net/socket.c:1979 [inline]
  __x64_sys_bind+0x72/0xb0 net/socket.c:1979
  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
  do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
irq event stamp: 357794
hardirqs last  enabled at (357794): [<ffffffff81ca5245>] __local_bh_enable_ip+0xa5/0x120 kernel/softirq.c:478
hardirqs last disabled at (357793): [<ffffffff81ca526e>] __local_bh_enable_ip+0xce/0x120 kernel/softirq.c:455
softirqs last  enabled at (357466): [<ffffffff81ca4d98>] run_ksoftirqd kernel/softirq.c:1099 [inline]
softirqs last  enabled at (357466): [<ffffffff81ca4d98>] run_ksoftirqd+0x38/0x60 kernel/softirq.c:1091
softirqs last disabled at (357471): [<ffffffff81ca4d98>] run_ksoftirqd kernel/softirq.c:1099 [inline]
softirqs last disabled at (357471): [<ffffffff81ca4d98>] run_ksoftirqd+0x38/0x60 kernel/softirq.c:1091

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_X25);
  <Interrupt>
    lock(sk_lock-AF_X25);

 *** DEADLOCK ***

locks held by ksoftirqd/0/15: 1, last CPU#0:
 #0: ffffffff8edec5a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8edec5a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8edec5a0 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_core+0x25/0x1a0 net/core/dev.c:6321

stack backtrace:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_usage_bug.part.0+0x258/0x340 kernel/locking/lockdep.c:4086
 print_usage_bug kernel/locking/lockdep.c:4054 [inline]
 valid_state kernel/locking/lockdep.c:4100 [inline]
 mark_lock_irq kernel/locking/lockdep.c:4311 [inline]
 mark_lock+0x956/0x1020 kernel/locking/lockdep.c:4797
 mark_usage kernel/locking/lockdep.c:4686 [inline]
 __lock_acquire+0x7f1/0x1f40 kernel/locking/lockdep.c:5242
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 lock_sock_nested+0x41/0xf0 net/core/sock.c:3837
 lock_sock include/net/sock.h:1713 [inline]
 x25_kill_by_neigh+0x168/0x280 net/x25/af_x25.c:1778
 x25_lapb_receive_frame+0x4b1/0x1000 net/x25/x25_dev.c:138
 __netif_receive_skb_one_core+0x1b2/0x1e0 net/core/dev.c:6297
 netif_receive_skb_core+0x5a/0x1a0 net/core/dev.c:6322
 lapbeth_napi_poll+0x42/0xc0 drivers/net/wan/lapbether.c:100
 __napi_poll.constprop.0+0xaf/0x450 net/core/dev.c:7830
 napi_poll net/core/dev.c:7893 [inline]
 net_rx_action+0xa40/0xf20 net/core/dev.c:8050
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 run_ksoftirqd kernel/softirq.c:1099 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1091
 smpboot_thread_fn+0x3d3/0xab0 kernel/smpboot.c:160
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: sleeping function called from invalid context at net/core/sock.c:3839
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 15, name: ksoftirqd/0
preempt_count: 100, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff81ca41d3>] softirq_handle_begin kernel/softirq.c:486 [inline]
[<ffffffff81ca41d3>] handle_softirqs+0xf3/0x9d0 kernel/softirq.c:621
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 __might_resched.cold+0x1dc/0x222 kernel/sched/core.c:9264
 lock_sock_nested+0x52/0xf0 net/core/sock.c:3839
 lock_sock include/net/sock.h:1713 [inline]
 x25_kill_by_neigh+0x168/0x280 net/x25/af_x25.c:1778
 x25_lapb_receive_frame+0x4b1/0x1000 net/x25/x25_dev.c:138
 __netif_receive_skb_one_core+0x1b2/0x1e0 net/core/dev.c:6297
 netif_receive_skb_core+0x5a/0x1a0 net/core/dev.c:6322
 lapbeth_napi_poll+0x42/0xc0 drivers/net/wan/lapbether.c:100
 __napi_poll.constprop.0+0xaf/0x450 net/core/dev.c:7830
 napi_poll net/core/dev.c:7893 [inline]
 net_rx_action+0xa40/0xf20 net/core/dev.c:8050
 handle_softirqs+0x1e6/0x9d0 kernel/softirq.c:645
 run_ksoftirqd kernel/softirq.c:1099 [inline]
 run_ksoftirqd+0x38/0x60 kernel/softirq.c:1091
 smpboot_thread_fn+0x3d3/0xab0 kernel/smpboot.c:160
 kthread+0x373/0x450 kernel/kthread.c:436
 ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
