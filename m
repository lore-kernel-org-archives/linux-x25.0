Received: from mail-ot1-f78.google.com (mail-ot1-f78.google.com [209.85.210.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C17137DEA2
	for <linux-x25@vger.kernel.org>; Tue, 11 Aug 2026 08:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786436676; cv=none; b=AsP69pd9evULJ6/zXFzp0vQwO3aeLqrfitXZhmHJkVQ+jKZttMnvgDMNygN/Lge3TbcmQGCbNkDXOiNsmVty/4Us7mIRz1B5cYbupKgd1QxpZpJRIsvbLFHUKx/JXtSELQlLHSaykZLmSNjyfnz/qPGDpRsY/KI0ECUNNzat2s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786436676; c=relaxed/simple;
	bh=Sj42UF5/AeBVexajqf43UEswiqnqsFBUdnx2Ar8yyCU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AeF3iQVnLuS7iqPvl8UqZPVMGenNEHey3eWJC1DK1QPmfX0fdMmxNCCvPxpBV8sxudW4oZFQyPwXkjrUwHChnfvy0Dx5TuL2SPcx9iDdEFRsMSpC6Dp7PJynwbeB4V/TY+oftefWGYf5I9fiFQbk6cSvSa/XM/1NgrXuwMMRgsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f78.google.com with SMTP id 46e09a7af769-7e6b59d85dcso4901593a34.3
        for <linux-x25@vger.kernel.org>; Tue, 11 Aug 2026 01:24:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786436674; x=1787041474;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IfDOdJhJ/FL4bazj7JYe8n7z0DeOhYlFBjsPHkrL6Zk=;
        b=W9wGl7dWhKrvYIXDjBExRKIIHkZo2pdc06RHCZmJHuoineKGzUGwrajuxg1zDrrPmh
         oTbsFXDbcjGfl3AUJ4JN+I73CQkV6CEa2IEFxeRz3Nzw0YD0dv8R/BzKAz9EuuC37BvS
         wBMAA+IG5TnYkkWcpTi762keD0iVYkSffaF04dvBKGCnoILb2Mbr+ZBVXcixH+hJg2sc
         UWmtqY91BuSaLFLD5CgQIHUhxkXn9wcoZBsYUyx5wKxB1jjnY2k4eZ/h0OnlH2c0X35y
         l3VTujjoBj0GQYJEnLAEGnblA0st9Mle4b4oMmQEe1ZpWA8qK5pFFfB0CNpeko/RA1NM
         Rphg==
X-Forwarded-Encrypted: i=1; AHgh+Rooaw7rs4UK2zXcFhJRKEN5wN5qMG5i52QwrWSLrYNCOK2MZv/TZyNNFM695c6+9X5jQFKfa1Bbs4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzKGDhhbtYI5Ympc/0Ms6rvcoxRF/u2rQ9bTw1M9Jay2nzmjFw
	PvUoUf0rAwm5pQHZz9oPCqfy1tAm5IjivLXtJ0oey7OANketWkHcQNiXq6uxGVtyjRqjHYiAkLT
	9MKRQiyK8b1+xorNvf8LHnWMzw27BweXZPQI32bmHVoHtQfqBu8QMWgLB/V8=
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:60e:b0:6ac:9729:670d with SMTP id
 006d021491bc7-6b0a3254e6amr706290eaf.33.1786436674413; Tue, 11 Aug 2026
 01:24:34 -0700 (PDT)
Date: Tue, 11 Aug 2026 01:24:34 -0700
In-Reply-To: <6a7a68ea.9c11d2ce.289b96.00f3.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7adc42.01d0871a.3a0d52.00c4.GAE@google.com>
Subject: Re: [syzbot] [x25?] inconsistent lock state in valid_state (7)
From: syzbot <syzbot+15cbd86f569e8b084383@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, 
	ms@dev.tdt.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    3d08ff75a47a Add linux-next specific files for 20260810
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=141fca9e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5ba0556605934602
dashboard link: https://syzkaller.appspot.com/bug?extid=15cbd86f569e8b084383
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1030a879580000

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
ksoftirqd/1/24 [HC0[0]:SC1[1]:HE1:SE0] takes:
ffff88801dfcc260 (sk_lock-AF_X25){+.?.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
ffff88801dfcc260 (sk_lock-AF_X25){+.?.}-{0:0}, at: x25_kill_by_neigh+0x10d/0x250 net/x25/af_x25.c:1778
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
irq event stamp: 785046
hardirqs last  enabled at (785046): [<ffffffff8188d110>] __local_bh_enable_ip+0xd0/0x130 kernel/softirq.c:457
hardirqs last disabled at (785045): [<ffffffff8188d0b1>] __local_bh_enable_ip+0x71/0x130 kernel/softirq.c:434
softirqs last  enabled at (784822): [<ffffffff8188fdb6>] run_ksoftirqd+0x36/0x60 kernel/softirq.c:1078
softirqs last disabled at (784827): [<ffffffff8188fdb6>] run_ksoftirqd+0x36/0x60 kernel/softirq.c:1078

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sk_lock-AF_X25);
  <Interrupt>
    lock(sk_lock-AF_X25);

 *** DEADLOCK ***

locks held by ksoftirqd/1/24: 1, last CPU#1:
 #0: ffffffff8eb5c820 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8eb5c820 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8eb5c820 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_core+0x33/0x2b0 net/core/dev.c:6269

stack backtrace:
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
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
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1078
 smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
BUG: sleeping function called from invalid context at net/core/sock.c:3829
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 24, name: ksoftirqd/1
preempt_count: 100, expected: 0
RCU nest depth: 1, expected: 0
INFO: lockdep is turned off.
Preemption disabled at:
[<ffffffff8188d30b>] softirq_handle_begin kernel/softirq.c:465 [inline]
[<ffffffff8188d30b>] handle_softirqs+0xab/0x840 kernel/softirq.c:600
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
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
 run_ksoftirqd+0x36/0x60 kernel/softirq.c:1078
 smpboot_thread_fn+0x57c/0xa80 kernel/smpboot.c:160
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
