Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D21C860C
	for <linux-x25@vger.kernel.org>; Tue, 11 Aug 2026 00:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786407149; cv=none; b=uE7DU0sfYtsNTQLhAmInm8XlesBCcUoeH4aiKXx02JYTxyAZWZVrdry6opuS2qpPWF7y/ffBcA0qjUwGZTFGZSWxs/B4QIRHqDE2SPNB7tUaqO0aTMRncEmgUbTXDt9z1xJ85En3zGXNW/cKycybixtYpA5RH+P49q1FhyL6qXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786407149; c=relaxed/simple;
	bh=fMAMu8Pbg4vK3SAahWljnYKkSfWlnnDfHXITbkn3rF4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fVWXlCI4IGBnNybzGz/J3JEHRl7mKnsExYEONqz8vRoF5HHBNS2RO4vJraJRPT8Rf+FIyIVbbmDrU0PwWrSF3mkgDiMm2yBCNsU2lKSyZpP+EumTKGz1CebeVuf3vKxODr+iCBCFD+pzcKF5KNhtlhKOtXVDTTWqhNU9RdPdfRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6ae4622d842so1913770eaf.3
        for <linux-x25@vger.kernel.org>; Mon, 10 Aug 2026 17:12:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786407147; x=1787011947;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wK9kvsOWODvgjuPDmjY0aeFJRUxWIPVvNgbeBKxFK8A=;
        b=m90215m9f0bMj2QYDVXpw0ZCfOEcl17Xz+GYY5qSF/wSnEnMNc94wVboJnT0sgvhzP
         IZljX1BFWBUBZBaosLVzl2KWwsQ73rT50rO2Ov+13812afjdLlyb0L9M6jZi83xr2zhR
         lnUgk6B+POJ2MRMTTx7pMmzJozsgLxdAi8goQNjBBVZUlMsQlH2v5o1M53UxiELiWq4Z
         Z8V9S/KpmE09x91ABS7gotMP3UW2REBBiTqOfEfua62f0Ww5lOnwX0+oju36mszHzDWr
         vxd17jIwHMDaISIK1BbUCqv6YmS0ZLJ3wL4O5XAV9V3QlUhGJk9PCLdF2GZ0VlE90YBM
         VXeQ==
X-Forwarded-Encrypted: i=1; AHgh+RpOYimEEv5LBR9+TDaJMNJW8neXdYcn0q5eDpGT+EMbYgT3VgeF0S2yVO22jMnsb9m7T5HFwx4lEsI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfLR3em1J7cxdk5YLX2YjLSgTu0j5GWD1vyBZ31p6vHnXp75XF
	ku8ijWTasO8XB0RzAFoeHaaLa3iB1m2Uzg0ufABzIjeZAC0GNI/Ci97fOLKKJjcoTnxeA3zfQQv
	JL1US7tH0OrsF6gAj+EqhC3M6ICL0XW/SHgi26u5BtIkLHmGtP1vc8izpqSQ=
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:178c:b0:6ac:b1ae:6ce2 with SMTP id
 006d021491bc7-6b04210f78cmr12774126eaf.24.1786407146791; Mon, 10 Aug 2026
 17:12:26 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:12:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7a68ea.9c11d2ce.289b96.00f3.GAE@google.com>
Subject: [syzbot] [x25?] inconsistent lock state in valid_state (7)
From: syzbot <syzbot+15cbd86f569e8b084383@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, 
	ms@dev.tdt.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3d08ff75a47a Add linux-next specific files for 20260810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1635e079580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ba0556605934602
dashboard link: https://syzkaller.appspot.com/bug?extid=15cbd86f569e8b084383
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/227afac921c2/disk-3d08ff75.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/236f7cfe0ac3/vmlinux-3d08ff75.xz
kernel image: https://storage.googleapis.com/syzbot-assets/aea89831fd96/bzImage-3d08ff75.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15cbd86f569e8b084383@syzkaller.appspotmail.com

================================
WARNING: inconsistent lock state
syzkaller #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
syz.1.151/6419 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffff88807ca06260 (sk_lock-AF_X25){+.?.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
ffff88807ca06260 (sk_lock-AF_X25){+.?.}-{0:0}, at: x25_kill_by_neigh+0x10d/0x250 net/x25/af_x25.c:1778
{SOFTIRQ-ON-W} state was registered at:
  lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
  lock_sock_nested+0x41/0x100 net/core/sock.c:3827
  lock_sock include/net/sock.h:1713 [inline]
  x25_bind+0x209/0x450 net/x25/af_x25.c:694
  __sys_bind_socket net/socket.c:1945 [inline]
  __sys_bind+0x2e3/0x410 net/socket.c:1976
  __do_sys_bind net/socket.c:1981 [inline]
  __se_sys_bind net/socket.c:1979 [inline]
  __x64_sys_bind+0x7a/0x90 net/socket.c:1979
  do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
  do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
  entry_SYSCALL_64_after_hwframe+0x77/0x7f
irq event stamp: 47158
hardirqs last  enabled at (47158): [<ffffffff8188d110>] __local_bh_enable_ip+0xd0/0x130 kernel/softirq.c:457
hardirqs last disabled at (47157): [<ffffffff8188d0b1>] __local_bh_enable_ip+0x71/0x130 kernel/softirq.c:434
softirqs last  enabled at (47068): [<ffffffff8188dd8a>] __do_softirq kernel/softirq.c:658 [inline]
softirqs last  enabled at (47068): [<ffffffff8188dd8a>] invoke_softirq kernel/softirq.c:498 [inline]
softirqs last  enabled at (47068): [<ffffffff8188dd8a>] __irq_exit_rcu+0xca/0x220 kernel/softirq.c:737
softirqs last disabled at (47113): [<ffffffff8188dd8a>] __do_softirq kernel/softirq.c:658 [inline]
softirqs last disabled at (47113): [<ffffffff8188dd8a>] invoke_softirq kernel/softirq.c:498 [inline]
softirqs last disabled at (47113): [<ffffffff8188dd8a>] __irq_exit_rcu+0xca/0x220 kernel/softirq.c:737

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_X25);
  <Interrupt>
    lock(sk_lock-AF_X25);

 *** DEADLOCK ***

locks held by syz.1.151/6419: 1, last CPU#1:
 #0: ffffffff8eb5c820 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8eb5c820 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8eb5c820 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_core+0x33/0x2b0 net/core/dev.c:6269

stack backtrace:
CPU: 1 UID: 0 PID: 6419 Comm: syz.1.151 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_usage_bug+0x28b/0x2e0 kernel/locking/lockdep.c:4058
 valid_state+0xbe/0xf0 kernel/locking/lockdep.c:4072
 mark_lock_irq+0x36/0x380 kernel/locking/lockdep.c:4283
 mark_lock+0x117/0x190 kernel/locking/lockdep.c:4769
 mark_usage kernel/locking/lockdep.c:-1 [inline]
 __lock_acquire+0x6b7/0x2e50 kernel/locking/lockdep.c:5208
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5908
 lock_sock_nested+0x41/0x100 net/core/sock.c:3827
 lock_sock include/net/sock.h:1713 [inline]
 x25_kill_by_neigh+0x10d/0x250 net/x25/af_x25.c:1778
 x25_lapb_receive_frame+0x1b0/0xfb0 net/x25/x25_dev.c:138
 __netif_receive_skb_one_core net/core/dev.c:6245 [inline]
 netif_receive_skb_core+0x2a6/0x2b0 net/core/dev.c:6270
 lapbeth_napi_poll+0x42/0x90 drivers/net/wan/lapbether.c:100
 __napi_poll+0xaa/0x330 net/core/dev.c:7768
 napi_poll net/core/dev.c:7831 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:7988
 handle_softirqs+0x225/0x840 kernel/softirq.c:624
 __do_softirq kernel/softirq.c:658 [inline]
 invoke_softirq kernel/softirq.c:498 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:737
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:754
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x417/0xc60 kernel/sched/core.c:5361
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 e9 d5 06 00 00 49 83 c4 48 4c 89 e7 e8 33 c4 47 0a e8 9e e4 39 00 fb 4c 8b 65 c8 <49> 8d bc 24 10 17 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc9000da5f260 EFLAGS: 00000202
RAX: 000000000000b807 RBX: ffff8880b873ca60 RCX: 0000000080000001
RDX: 0000000000000000 RSI: ffffffff8e25543f RDI: ffffffff8c4c8980
RBP: ffffc9000da5f2b0 R08: ffffffff9058fd7f R09: 1ffffffff20b1faf
R10: dffffc0000000000 R11: fffffbfff20b1fb0 R12: ffff88803040ddc0
R13: ffff88803040ddc0 R14: dffffc0000000000 R15: 1ffff110170e794c
 context_switch kernel/sched/core.c:5513 [inline]
 __schedule+0x1b32/0x59a0 kernel/sched/core.c:7232
 __schedule_loop kernel/sched/core.c:7309 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7324
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 unix_wait_for_peer+0x1f5/0x2f0 net/unix/af_unix.c:1616
 unix_dgram_sendmsg+0xaf4/0x17b0 net/unix/af_unix.c:2252
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2709
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2763
 __sys_sendmmsg+0x273/0x4d0 net/socket.c:2852
 __do_sys_sendmmsg net/socket.c:2879 [inline]
 __se_sys_sendmmsg net/socket.c:2876 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2876
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa86c39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa86d19c028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fa86c625fa0 RCX: 00007fa86c39e0d9
RDX: 0400000000000041 RSI: 0000200000000000 RDI: 0000000000000006
RBP: 00007fa86c435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa86c626038 R14: 00007fa86c625fa0 R15: 00007fff05bd2b28
 </TASK>
BUG: sleeping function called from invalid context at net/core/sock.c:3829
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 6419, name: syz.1.151
preempt_count: 101, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff8bdc27cd>] __schedule_loop kernel/sched/core.c:7308 [inline]
[<ffffffff8bdc27cd>] schedule+0x15d/0x2b0 kernel/sched/core.c:7324
CPU: 1 UID: 0 PID: 6419 Comm: syz.1.151 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <IRQ>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x378/0x4d0 kernel/sched/core.c:9195
 lock_sock_nested+0x56/0x100 net/core/sock.c:3829
 lock_sock include/net/sock.h:1713 [inline]
 x25_kill_by_neigh+0x10d/0x250 net/x25/af_x25.c:1778
 x25_lapb_receive_frame+0x1b0/0xfb0 net/x25/x25_dev.c:138
 __netif_receive_skb_one_core net/core/dev.c:6245 [inline]
 netif_receive_skb_core+0x2a6/0x2b0 net/core/dev.c:6270
 lapbeth_napi_poll+0x42/0x90 drivers/net/wan/lapbether.c:100
 __napi_poll+0xaa/0x330 net/core/dev.c:7768
 napi_poll net/core/dev.c:7831 [inline]
 net_rx_action+0x61d/0xf50 net/core/dev.c:7988
 handle_softirqs+0x225/0x840 kernel/softirq.c:624
 __do_softirq kernel/softirq.c:658 [inline]
 invoke_softirq kernel/softirq.c:498 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:737
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:754
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1062 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1062
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:674
RIP: 0010:finish_task_switch+0x417/0xc60 kernel/sched/core.c:5361
Code: 04 00 00 41 c7 84 24 20 0e 00 00 00 00 00 00 e9 d5 06 00 00 49 83 c4 48 4c 89 e7 e8 33 c4 47 0a e8 9e e4 39 00 fb 4c 8b 65 c8 <49> 8d bc 24 10 17 00 00 48 89 f8 48 c1 e8 03 42 0f b6 04 30 84 c0
RSP: 0018:ffffc9000da5f260 EFLAGS: 00000202
RAX: 000000000000b807 RBX: ffff8880b873ca60 RCX: 0000000080000001
RDX: 0000000000000000 RSI: ffffffff8e25543f RDI: ffffffff8c4c8980
RBP: ffffc9000da5f2b0 R08: ffffffff9058fd7f R09: 1ffffffff20b1faf
R10: dffffc0000000000 R11: fffffbfff20b1fb0 R12: ffff88803040ddc0
R13: ffff88803040ddc0 R14: dffffc0000000000 R15: 1ffff110170e794c
 context_switch kernel/sched/core.c:5513 [inline]
 __schedule+0x1b32/0x59a0 kernel/sched/core.c:7232
 __schedule_loop kernel/sched/core.c:7309 [inline]
 schedule+0x164/0x2b0 kernel/sched/core.c:7324
 schedule_timeout+0xc0/0x2c0 kernel/time/sleep_timeout.c:75
 unix_wait_for_peer+0x1f5/0x2f0 net/unix/af_unix.c:1616
 unix_dgram_sendmsg+0xaf4/0x17b0 net/unix/af_unix.c:2252
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:800
 __sock_sendmsg net/socket.c:815 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2709
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2763
 __sys_sendmmsg+0x273/0x4d0 net/socket.c:2852
 __do_sys_sendmmsg net/socket.c:2879 [inline]
 __se_sys_sendmmsg net/socket.c:2876 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2876
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x510 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa86c39e0d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa86d19c028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fa86c625fa0 RCX: 00007fa86c39e0d9
RDX: 0400000000000041 RSI: 0000200000000000 RDI: 0000000000000006
RBP: 00007fa86c435024 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa86c626038 R14: 00007fa86c625fa0 R15: 00007fff05bd2b28
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 00                	add    %al,(%rax)
   2:	41 c7 84 24 20 0e 00 	movl   $0x0,0xe20(%r12)
   9:	00 00 00 00 00
   e:	e9 d5 06 00 00       	jmp    0x6e8
  13:	49 83 c4 48          	add    $0x48,%r12
  17:	4c 89 e7             	mov    %r12,%rdi
  1a:	e8 33 c4 47 0a       	call   0xa47c452
  1f:	e8 9e e4 39 00       	call   0x39e4c2
  24:	fb                   	sti
  25:	4c 8b 65 c8          	mov    -0x38(%rbp),%r12
* 29:	49 8d bc 24 10 17 00 	lea    0x1710(%r12),%rdi <-- trapping instruction
  30:	00
  31:	48 89 f8             	mov    %rdi,%rax
  34:	48 c1 e8 03          	shr    $0x3,%rax
  38:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax
  3d:	84 c0                	test   %al,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
