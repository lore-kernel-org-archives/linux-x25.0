Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210D3B71BD
	for <linux-x25@vger.kernel.org>; Sat, 17 Oct 2026 03:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206563; cv=none; b=ozzqB78G6jZhGw26a53ry+h63/y3gFSOR2N/nnATU3q5/u5P/Br6aC4bBoBLUmHMsBB/2eNXJsnt6xPZEnJmLT3+b3TDm8pXCeYIUme0t21SHJFZmetFodORQnY8efF1I/gAZeDTCLiobUrcEqGiN7gNmU1uQhpR7+EW6MSqpRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206563; c=relaxed/simple;
	bh=qWZscB2I+FYzj/bKFGPuKuzE61mBCR8+wImSbMhOBwk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Xtcw76H/J7cdLzlixW37fBGthfVpYaFXT+rR7E3h4v2FTGIB/5oKJsysDzbTq9vNJ2EBPbBPu/j6yJlOABpqSE1yqHU5fHXZNz+/x3ln22BznGGoW95JRIZa9dCSV4He8rL7y0hNxOqblSG+9PDPl0vFzMqin7K2ux/UrRpVg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4c7f887ac6bso896776b6e.3
        for <linux-x25@vger.kernel.org>; Fri, 16 Oct 2026 20:09:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792206561; x=1792811361;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JaJZcBIKqUWusrosJzXIs+je6PTOrghJY1sZP6GKQWI=;
        b=K2LpHAmcpkrRJC700GEb9IiAS+mDh82xqxASZHAP/bF7BjkISqTmkV62AoP+LoFBhS
         86ctfUxfqOWDWico4y/OKhOZbeh3Jmb2UeKNPCEZAE6ydSjuu/H180WiggbCm6A43tCV
         cPShc54eUX0t/lvTCu3/bHPafbpGaj/kAxnzxltstlZ5JWAozwI+pCcqMSrC78OYTcMO
         Jp9KcJ4bMYCkfdRnyOIKrL/pPA7PeBeB4+g5CJ66izul2Tn63aqFWCeAM8+hIsRXIXL4
         rJLY7KErDvmqrqfD7EtjjBwGtu5jbQtWPjVtao6TpsC9hkL1PfSy8Z+eWaoIJ3cWaL4/
         mAzw==
X-Forwarded-Encrypted: i=1; AKwUvBzSKd4HLi/iVfySeGmz4OErwjLzCMGq1uBizAz/VxSC++P76am/pNTqM3otkJ/jJjETLLO5dhik1KU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKNKXZH5HQ/u9Vt7X3hSQ0upLbmYgyVBACHHqeuuL+U/EhU+nke
	WIWWm9THKq4dezDSy6lW3iTzk4SWY6eIIHjA2B3letpaPR2dDCvPVyr+JPgzcd5q6MuO5RSV6Wz
	K/FWj7D2aFtlV+Ob75Bih4p4WM4NA5fHLP2sIr2bqPbJw0Wdl7HC9qrLpvRo=
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1488:b0:4cb:f21b:6f8e with SMTP id
 5614622812f47-53ccfcb392dmr1461275b6e.33.1792206560901; Fri, 16 Oct 2026
 20:09:20 -0700 (PDT)
Date: Fri, 16 Oct 2026 20:09:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad2e6e0.6814cce4.34c49f.0026.GAE@google.com>
Subject: [syzbot] [x25?] possible deadlock in lapb_connect_request
From: syzbot <syzbot+8328573e4d0514392471@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, 
	ms@dev.tdt.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    24a19b953e2a Linux 7.3-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=101e883c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
dashboard link: https://syzkaller.appspot.com/bug?extid=8328573e4d0514392471
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c36b6926be3e/disk-24a19b95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/413d898eaf27/vmlinux-24a19b95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ada3e66b70fc/bzImage-24a19b95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8328573e4d0514392471@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Tainted: G             L     
------------------------------------------------------
syz.5.1726/12729 is trying to acquire lock:
ffff8880793f6dc0 (&lapb->lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:353 [inline]
ffff8880793f6dc0 (&lapb->lock){+.-.}-{3:3}, at: lapb_connect_request+0x5e/0x1a0 net/lapb/lapb_iface.c:293

but task is already holding lock:
ffff88802bd78f00 (&lapbeth->up_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:353 [inline]
ffff88802bd78f00 (&lapbeth->up_lock){+.-.}-{3:3}, at: lapbeth_xmit+0x24/0x250 drivers/net/wan/lapbether.c:191

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&lapbeth->up_lock){+.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:182 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:205
       spin_lock_bh include/linux/spinlock.h:353 [inline]
       lapbeth_xmit+0x24/0x250 drivers/net/wan/lapbether.c:191
       __netdev_start_xmit include/linux/netdevice.h:5432 [inline]
       netdev_start_xmit include/linux/netdevice.h:5441 [inline]
       xmit_one net/core/dev.c:3953 [inline]
       dev_hard_start_xmit+0x121/0x760 net/core/dev.c:3969
       __dev_queue_xmit+0x1c25/0x4a40 net/core/dev.c:4958
       dev_queue_xmit include/linux/netdevice.h:3464 [inline]
       tx+0xc4/0x130 drivers/block/aoe/aoenet.c:62
       kthread+0x1d8/0x3c0 drivers/block/aoe/aoecmd.c:1241
       kthread+0x373/0x450 kernel/kthread.c:436
       ret_from_fork+0x730/0xd60 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #1 (_xmit_X25#2){+.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
       spin_lock include/linux/spinlock.h:347 [inline]
       __netif_tx_lock include/linux/netdevice.h:4841 [inline]
       __dev_queue_xmit+0x1ac6/0x4a40 net/core/dev.c:4952
       neigh_output include/net/neighbour.h:560 [inline]
       ip_finish_output2+0x851/0x2400 net/ipv4/ip_output.c:236
       __ip_finish_output.part.0+0x444/0x6f0 net/ipv4/ip_output.c:314
       __ip_finish_output net/ipv4/ip_output.c:302 [inline]
       ip_finish_output net/ipv4/ip_output.c:324 [inline]
       NF_HOOK_COND include/linux/netfilter.h:314 [inline]
       ip_output+0x39b/0xc10 net/ipv4/ip_output.c:437
       dst_output include/net/dst.h:471 [inline]
       ip_local_out+0x193/0x1f0 net/ipv4/ip_output.c:131
       iptunnel_xmit+0x722/0xd30 net/ipv4/ip_tunnel_core.c:97
       ip_tunnel_xmit+0x1b91/0x3210 net/ipv4/ip_tunnel.c:848
       __gre_xmit+0x91a/0xc90 net/ipv4/ip_gre.c:488
       gre_tap_xmit+0x44e/0x700 net/ipv4/ip_gre.c:783
       __netdev_start_xmit include/linux/netdevice.h:5432 [inline]
       netdev_start_xmit include/linux/netdevice.h:5441 [inline]
       xmit_one net/core/dev.c:3953 [inline]
       dev_hard_start_xmit+0x121/0x760 net/core/dev.c:3969
       sch_direct_xmit+0x1b2/0xc70 net/sched/sch_generic.c:372
       __dev_xmit_skb net/core/dev.c:4277 [inline]
       __dev_queue_xmit+0x2812/0x4a40 net/core/dev.c:4916
       lapb_data_transmit+0x96/0xc0 net/lapb/lapb_iface.c:447
       lapb_transmit_buffer+0xce/0x3a0 net/lapb/lapb_out.c:149
       lapb_send_control+0x1ce/0x330 net/lapb/lapb_subr.c:251
       lapb_establish_data_link+0xeb/0x110 net/lapb/lapb_out.c:163
       lapb_device_event+0x315/0x580 net/lapb/lapb_iface.c:512
       notifier_call_chain+0x99/0x3f0 kernel/notifier.c:85
       call_netdevice_notifiers_info+0xbe/0x110 net/core/dev.c:2275
       call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
       call_netdevice_notifiers net/core/dev.c:2327 [inline]
       __dev_notify_flags+0x22c/0x4b0 net/core/dev.c:9896
       netif_change_flags+0x108/0x160 net/core/dev.c:9925
       dev_change_flags+0xba/0x260 net/core/dev_api.c:68
       devinet_ioctl+0x110b/0x1f10 net/ipv4/devinet.c:1199
       inet_ioctl+0x3aa/0x3f0 net/ipv4/af_inet.c:1009
       sock_do_ioctl+0x118/0x280 net/socket.c:1325
       sock_ioctl+0x599/0x6b0 net/socket.c:1446
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl fs/ioctl.c:583 [inline]
       __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&lapb->lock){+.-.}-{3:3}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:182 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:205
       spin_lock_bh include/linux/spinlock.h:353 [inline]
       lapb_connect_request+0x5e/0x1a0 net/lapb/lapb_iface.c:293
       lapbeth_xmit+0x1cb/0x250 drivers/net/wan/lapbether.c:205
       __netdev_start_xmit include/linux/netdevice.h:5432 [inline]
       netdev_start_xmit include/linux/netdevice.h:5441 [inline]
       xmit_one net/core/dev.c:3953 [inline]
       dev_hard_start_xmit+0x121/0x760 net/core/dev.c:3969
       __dev_queue_xmit+0x1c25/0x4a40 net/core/dev.c:4958
       dev_queue_xmit include/linux/netdevice.h:3464 [inline]
       x25_establish_link+0x16f/0x1d0 net/x25/x25_dev.c:170
       x25_transmit_link+0x92/0x100 net/x25/x25_link.c:218
       x25_write_internal+0x522/0xc80 net/x25/x25_subr.c:255
       x25_connect+0x728/0x1080 net/x25/af_x25.c:810
       connect_socket net/socket.c:2141 [inline]
       connect_socket net/socket.c:2131 [inline]
       __sys_connect_file+0x146/0x1a0 net/socket.c:2166
       __sys_connect+0x141/0x170 net/socket.c:2183
       __do_sys_connect net/socket.c:2189 [inline]
       __se_sys_connect net/socket.c:2186 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2186
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &lapb->lock --> _xmit_X25#2 --> &lapbeth->up_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&lapbeth->up_lock);
                               lock(_xmit_X25#2);
                               lock(&lapbeth->up_lock);
  lock(&lapb->lock);

 *** DEADLOCK ***

locks held by syz.5.1726/12729: 4, last CPU#1:
 #0: ffff88805f65e260 (sk_lock-AF_X25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #0: ffff88805f65e260 (sk_lock-AF_X25){+.+.}-{0:0}, at: x25_connect+0xba/0x1080 net/x25/af_x25.c:751
 #1: ffffffff8fdec580 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #1: ffffffff8fdec580 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:902 [inline]
 #1: ffffffff8fdec580 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x296/0x4a40 net/core/dev.c:4872
 #2: ffff8880257f8958 (_xmit_X25#2){+.-.}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
 #2: ffff8880257f8958 (_xmit_X25#2){+.-.}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4841 [inline]
 #2: ffff8880257f8958 (_xmit_X25#2){+.-.}-{3:3}, at: __dev_queue_xmit+0x1ac6/0x4a40 net/core/dev.c:4952
 #3: ffff88802bd78f00 (&lapbeth->up_lock){+.-.}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:353 [inline]
 #3: ffff88802bd78f00 (&lapbeth->up_lock){+.-.}-{3:3}, at: lapbeth_xmit+0x24/0x250 drivers/net/wan/lapbether.c:191

stack backtrace:
CPU: 1 UID: 0 PID: 12729 Comm: syz.5.1726 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/05/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_circular_bug.cold+0x178/0x1be kernel/locking/lockdep.c:2087
 check_noncircular+0x146/0x160 kernel/locking/lockdep.c:2219
 check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
 lock_acquire kernel/locking/lockdep.c:5942 [inline]
 lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:182 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:205
 spin_lock_bh include/linux/spinlock.h:353 [inline]
 lapb_connect_request+0x5e/0x1a0 net/lapb/lapb_iface.c:293
 lapbeth_xmit+0x1cb/0x250 drivers/net/wan/lapbether.c:205
 __netdev_start_xmit include/linux/netdevice.h:5432 [inline]
 netdev_start_xmit include/linux/netdevice.h:5441 [inline]
 xmit_one net/core/dev.c:3953 [inline]
 dev_hard_start_xmit+0x121/0x760 net/core/dev.c:3969
 __dev_queue_xmit+0x1c25/0x4a40 net/core/dev.c:4958
 dev_queue_xmit include/linux/netdevice.h:3464 [inline]
 x25_establish_link+0x16f/0x1d0 net/x25/x25_dev.c:170
 x25_transmit_link+0x92/0x100 net/x25/x25_link.c:218
 x25_write_internal+0x522/0xc80 net/x25/x25_subr.c:255
 x25_connect+0x728/0x1080 net/x25/af_x25.c:810
 connect_socket net/socket.c:2141 [inline]
 connect_socket net/socket.c:2131 [inline]
 __sys_connect_file+0x146/0x1a0 net/socket.c:2166
 __sys_connect+0x141/0x170 net/socket.c:2183
 __do_sys_connect net/socket.c:2189 [inline]
 __se_sys_connect net/socket.c:2186 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2186
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9e4619e1d9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e443d5028 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f9e46426090 RCX: 00007f9e4619e1d9
RDX: 0000000000000012 RSI: 0000200000003340 RDI: 000000000000000a
RBP: 00007f9e46235888 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9e46426128 R14: 00007f9e46426090 R15: 00007ffe340b8688
 </TASK>


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
