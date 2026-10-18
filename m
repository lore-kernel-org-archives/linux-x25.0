Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD438F947
	for <linux-x25@vger.kernel.org>; Sun, 18 Oct 2026 03:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295495; cv=none; b=gl/hg8TuAPYB+BXP6Ka/pJV0xuVUSw8R3VQmcoXWdVXYyqIiavSO0++NGuDf/F9z8B1E4eedl5CKQ7PxGPp8KZLvRToOMCbIxOUrzB2wjz56GDDbKxzO3CRwWlCrXL767qYKR6codNaUXq4EaGAHqHb+80yfi9hAIgeXr9f20gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295495; c=relaxed/simple;
	bh=Muw+RHg1wjXS9SBgZ2Ry+LC17JJDMHuSsx+60erN1U0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lBHrLqAflAXMocPZJgZaTqmqb7fcHflFqzxSVeB0BtyIB+UI82WncWISoVVDauZZRlvXFgpOGAqqJnbsXU+n6NOenJf9EdtviSeOxpb4ya6z8iSXMOb5PC99YBVxyaRF4iMvh02TOR/6fFVzl9FYapu9BvDZcjuD9CTGD3beuLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4a41f46d629so2196244b6e.3
        for <linux-x25@vger.kernel.org>; Sat, 17 Oct 2026 20:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295492; x=1792900292;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=wEkTcMvHp/qYXQqFO/6DZl3RBJMXuTcnmz1AQzeCtG0=;
        b=EnFImO5vCjE1QmDo5pAJS7Q9xqrjXY+330e3/qjKqA+vzrSkAGWOU6jIKI9zgiUlZs
         NK5pxpDA3qEN8gJu1RJfhDR50Mc9hm+6rs/TIjRG0cgHf2Jsq3VKC0/pUEy8IWQw/yEk
         WAt9H4pLUi5YCl+VKZ/WvBPoBXKw7kS3qP/6o9kfG+4q+5wNpCD+teGV0T9yYB2sIa+c
         RPxEZYn9piifAyVHKrkr1+dSVht+14I2pMUrlPHg34DUswIFXPlCg+K/nQ6dJ4mJPL2L
         gkra99NC2/WMpvhMWH+Pz//sJmounlCFCW5KbA4Sg13JNHidUu5Sgi6uB3kjXumN5HlH
         5J8Q==
X-Forwarded-Encrypted: i=1; AKwUvBwzTADZ3DSswQcOZfBslQRFxVEzrqV2UUuRO5D6iLyklfWoBZZ6LSkXARv2outeTSRMiIahfjB4pxg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZsffgIVzEph9np6iGwjwFkic+4lCeDjyJ/UZ/f/bIIBE/Z1i8
	0Dqoafyn6vqlmdLgVub+uCjnJZASaSwtwYz0vTZ+/srrEd1Og3nyOWjT9FvSQTZI359ntdeNoXa
	UCYZ5dF2IxGTyxhBXTf8cEDMhXspp7/ntbOI8UEg7Mcgih701NZ6BHX+IcfA=
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1206:b0:4f0:1b0b:4dae with SMTP id
 5614622812f47-53ccb4ea805mr3155325b6e.20.1792295492629; Sat, 17 Oct 2026
 20:51:32 -0700 (PDT)
Date: Sat, 17 Oct 2026 20:51:32 -0700
In-Reply-To: <6ad2e6e0.6814cce4.34c49f.0026.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad44244.7f4e89eb.3d59aa.00ac.GAE@google.com>
Subject: Re: [syzbot] [x25?] possible deadlock in lapb_connect_request
From: syzbot <syzbot+8328573e4d0514392471@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, ms@dev.tdt.de, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    58161ead29e5 Merge tag 'drm-fixes-2026-10-17' of https://g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1212098e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=129d675874dbf896
dashboard link: https://syzkaller.appspot.com/bug?extid=8328573e4d0514392471
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1612098e580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8328573e4d0514392471@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor333/5939 is trying to acquire lock:
ffffffff91f49b18 (lapb_list_lock){++..}-{3:3}, at: lapb_devtostruct net/lapb/lapb_iface.c:102 [inline]
ffffffff91f49b18 (lapb_list_lock){++..}-{3:3}, at: lapb_connect_request+0x26/0x1a0 net/lapb/lapb_iface.c:287

but task is already holding lock:
ffff88807a54cf00 (&lapbeth->up_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:353 [inline]
ffff88807a54cf00 (&lapbeth->up_lock){+...}-{3:3}, at: lapbeth_xmit+0x24/0x250 drivers/net/wan/lapbether.c:191

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&lapbeth->up_lock){+...}-{3:3}:
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

-> #2 (_xmit_X25#2){+...}-{3:3}:
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

-> #1 (&lapb->lock){+.-.}-{3:3}:
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:182 [inline]
       _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:205
       spin_lock_bh include/linux/spinlock.h:353 [inline]
       lapb_unregister+0x112/0x400 net/lapb/lapb_iface.c:187
       lapbeth_close+0x56/0x90 drivers/net/wan/lapbether.c:350
       __dev_close_many+0x312/0x710 net/core/dev.c:1798
       __dev_close net/core/dev.c:1811 [inline]
       __dev_change_flags+0x307/0x850 net/core/dev.c:9853
       netif_change_flags+0x8d/0x160 net/core/dev.c:9920
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

-> #0 (lapb_list_lock){++..}-{3:3}:
       check_prev_add+0xeb/0xe60 kernel/locking/lockdep.c:3209
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x1528/0x1f40 kernel/locking/lockdep.c:5288
       lock_acquire kernel/locking/lockdep.c:5942 [inline]
       lock_acquire+0x1d1/0x380 kernel/locking/lockdep.c:5899
       __raw_read_lock_bh include/linux/rwlock_api_smp.h:192 [inline]
       _raw_read_lock_bh+0x3f/0x70 kernel/locking/spinlock.c:287
       lapb_devtostruct net/lapb/lapb_iface.c:102 [inline]
       lapb_connect_request+0x26/0x1a0 net/lapb/lapb_iface.c:287
       lapbeth_xmit+0x1cb/0x250 drivers/net/wan/lapbether.c:205
       __netdev_start_xmit include/linux/netdevice.h:5432 [inline]
       netdev_start_xmit include/linux/netdevice.h:5441 [inline]
       xmit_one net/core/dev.c:3953 [inline]
       dev_hard_start_xmit+0x121/0x760 net/core/dev.c:3969
       __dev_queue_xmit+0x1c25/0x4a40 net/core/dev.c:4958
       dev_queue_xmit include/linux/netdevice.h:3464 [inline]
       packet_xmit+0x243/0x310 net/packet/af_packet.c:277
       packet_snd net/packet/af_packet.c:3149 [inline]
       packet_sendmsg+0x32ee/0x5040 net/packet/af_packet.c:3181
       sock_sendmsg_nosec net/socket.c:800 [inline]
       __sock_sendmsg net/socket.c:815 [inline]
       __sys_sendto+0x48b/0x4e0 net/socket.c:2281
       __do_sys_sendto net/socket.c:2288 [inline]
       __se_sys_sendto net/socket.c:2284 [inline]
       __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2284
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  lapb_list_lock --> _xmit_X25#2 --> &lapbeth->up_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&lapbeth->up_lock);
                               lock(_xmit_X25#2);
                               lock(&lapbeth->up_lock);
  rlock(lapb_list_lock);

 *** DEADLOCK ***

locks held by syz-executor333/5939: 3, last CPU#0:
 #0: ffffffff8fdec580 (rcu_read_lock_bh){....}-{1:3}, at: local_bh_disable include/linux/bottom_half.h:20 [inline]
 #0: ffffffff8fdec580 (rcu_read_lock_bh){....}-{1:3}, at: rcu_read_lock_bh include/linux/rcupdate.h:902 [inline]
 #0: ffffffff8fdec580 (rcu_read_lock_bh){....}-{1:3}, at: __dev_queue_xmit+0x296/0x4a40 net/core/dev.c:4872
 #1: ffff888023beb558 (_xmit_X25#2){+...}-{3:3}, at: spin_lock include/linux/spinlock.h:347 [inline]
 #1: ffff888023beb558 (_xmit_X25#2){+...}-{3:3}, at: __netif_tx_lock include/linux/netdevice.h:4841 [inline]
 #1: ffff888023beb558 (_xmit_X25#2){+...}-{3:3}, at: __dev_queue_xmit+0x1ac6/0x4a40 net/core/dev.c:4952
 #2: ffff88807a54cf00 (&lapbeth->up_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:353 [inline]
 #2: ffff88807a54cf00 (&lapbeth->up_lock){+...}-{3:3}, at: lapbeth_xmit+0x24/0x250 drivers/net/wan/lapbether.c:191

stack backtrace:
CPU: 0 UID: 0 PID: 5939 Comm: syz-executor333 Not tainted syzkaller #0 PREEMPT(full) 
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
 __raw_read_lock_bh include/linux/rwlock_api_smp.h:192 [inline]
 _raw_read_lock_bh+0x3f/0x70 kernel/locking/spinlock.c:287
 lapb_devtostruct net/lapb/lapb_iface.c:102 [inline]
 lapb_connect_request+0x26/0x1a0 net/lapb/lapb_iface.c:287
 lapbeth_xmit+0x1cb/0x250 drivers/net/wan/lapbether.c:205
 __netdev_start_xmit include/linux/netdevice.h:5432 [inline]
 netdev_start_xmit include/linux/netdevice.h:5441 [inline]
 xmit_one net/core/dev.c:3953 [inline]
 dev_hard_start_xmit+0x121/0x760 net/core/dev.c:3969
 __dev_queue_xmit+0x1c25/0x4a40 net/core/dev.c:4958
 dev_queue_xmit include/linux/netdevice.h:3464 [inline]
 packet_xmit+0x243/0x310 net/packet/af_packet.c:277
 packet_snd net/packet/af_packet.c:3149 [inline]
 packet_sendmsg+0x32ee/0x5040 net/packet/af_packet.c:3181
 sock_sendmsg_nosec net/socket.c:800 [inline]
 __sock_sendmsg net/socket.c:815 [inline]
 __sys_sendto+0x48b/0x4e0 net/socket.c:2281
 __do_sys_sendto net/socket.c:2288 [inline]
 __se_sys_sendto net/socket.c:2284 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2284
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x123/0x790 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff79ae040b7
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffe8b1e5860 EFLAGS: 00000202 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000555590b13400 RCX: 00007ff79ae040b7
RDX: 0000000000000001 RSI: 00007ffe8b1e58bf RDI: 0000000000000005
RBP: 0000000000000004 R08: 00007ffe8b1e58c0 R09: 0000000000000014
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000003
R13: 0000000000000005 R14: 00007ff79ae3d059 R15: 00007ff79ae3d044
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
