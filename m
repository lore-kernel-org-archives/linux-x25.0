Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792437621;
	b=YhegJl3GAtrc/eHl9lq5Rv0wW9+khF+uvytcim1t/o0/EgWRfoiEHBeuQ5UgairjL5fP
	 3OhNKEs6COP43J/elLfSPEoOfPXnIyd2WKGpvA92WaXx9buzAEfmcQ9+HctL2SPjm/fUf
	 TeeXz9wGQ17R6s6yhL2Df1mf2P0VuwMfuNOogophhgVtcgFdkC5ghZMF/T7G1/uFfyQ7w
	 5diGrW9bTE2dIrjbeQrH99tQ4oc+JeQXQNSvxvfCg4O19zmcfwq2GU3OVWvQksZw+unvs
	 KigdSSUDgMuR0BQXclbgygXjvJCbrooumJZHMVyM2CaM8ggqvEpVAG8hChkUaBw5GSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792437621;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=2cwznlz+EdWN+doPcioMiDQlvM6SENL3VPQBjPnsKVs=;
	b=nXD5hisI2ID4VNHYbw4P4cFfyoHhEpPasBa1NgzybuvLsrOy9gczZt6QdGkIWQdqrk1i
	 xnuORCisYfS/hZcjNUf8czpLiwS7HDlAyATJfk0IZTmaFDObOCEhvjXrtQgWDdp7YcydZ
	 SSza9lRErtHz2ide7hgdvhCVsDcoxWeML+82Yvjfuh+bG1A6lYGACEHMvNVzsSlxkaTo0
	 YgZKPDy5SHh4e7TJrOy5BvgFIfbf9yUAeGES8+HIMdbrFf+9kPgtknwx8wx3RBJCyyhKT
	 DQhYvsnWKlLTQJ8DaQGFPFJOjsEOQp0wjvXctK9QwFY1JAKvACedZqgI3fBaNY8xa8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.200
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4BD606A323
	for <linux-x25@vger.kernel.org>; Mon, 19 Oct 2026 19:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC4BD606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4ab4f652f9bso2070069b6e.0
        for <linux-x25@vger.kernel.org>; Mon, 19 Oct 2026 12:20:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792437620; x=1793042420;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2cwznlz+EdWN+doPcioMiDQlvM6SENL3VPQBjPnsKVs=;
        b=IKtSuYGZQgyKLeDJfUAxELgrdXtPFo5S3Xvl5PLY5I1tR8/3L31vnAGi5rpJfGM65Z
         2AlWwy4fAaBoKyWTJoqd0HYtqEPMjN4V5U7TsWC4WoU4KuYz/A8ZTFIFrlWO9Ci122FF
         8Uj38OqVkJz878ZaCN72yQIeI+aP+O9fbOd2DPnrQ9SS+RLjWXasIYgk77RA/1Rhr40T
         OoB3ZsaeXta6MKKPOkTj+6x6/PdcZGGrjwCHaa8TT/atMlIr2YvP+oEtwvfHLRsO3xDb
         ummPuytkYLdCKExZmT8VFRxxZFotES6Ek0OJlDObH+RUVKDh+znmkKQE7VzJ8uO0REqt
         jTvg==
X-Forwarded-Encrypted: i=1; AKwUvBz36ZE5XS2g/e2NW6hPEww8AUDQHxziQJFd4XsrM2RU/MxlU65bK3RWBHcjfWpKevH8YNdQr4QX2E8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJLAbIFVAmRrX7ZtnKAzV90xr8HuVmJTQCzMhnFsUlHopOnEMVe
	3cXc+34443WJimo874xZ56Ic+OmPqSYcj5Hoxr2USNkoUxpj7CVkGMSrhHfCsNwLQC5/3rqXgMz
	T6gmnbF8HywpvnxwrP2VWFB8NIBh3rmueSg6ELBTMcbSxK+wjAfLE6xFLkhw=
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:4f62:b0:4f4:b5ba:a236 with SMTP id
 5614622812f47-53ccaf299bdmr8642635b6e.10.1792437619938; Mon, 19 Oct 2026
 12:20:19 -0700 (PDT)
Date: Mon, 19 Oct 2026 12:20:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad66d73.2431563d.3b88b.0026.GAE@google.com>
Subject: [syzbot] [x25?] possible deadlock in lapb_data_received
From: syzbot <syzbot+059a2795ad4cff2a2695@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, ms@dev.tdt.de, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c7935600733 Merge branch 'bpf-zero-extend-the-index-in-in..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13598f01580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=964a8fc052e56fe5
dashboard link: https://syzkaller.appspot.com/bug?extid=059a2795ad4cff2a2695
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=117c5031580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+059a2795ad4cff2a2695@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
syzkaller #0 Not tainted
------------------------------------------------------
syz-executor220/6011 is trying to acquire lock:
ffffffff913da7b8 (lapb_list_lock){++..}-{3:3}, at: lapb_devtostruct net/lapb/lapb_iface.c:102 [inline]
ffffffff913da7b8 (lapb_list_lock){++..}-{3:3}, at: lapb_data_received+0x2f/0x1c0 net/lapb/lapb_iface.c:394

but task is already holding lock:
ffff88802af94f00 (&lapbeth->up_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:353 [inline]
ffff88802af94f00 (&lapbeth->up_lock){+...}-{3:3}, at: lapbeth_rcv+0x24e/0x640 drivers/net/wan/lapbether.c:131

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&lapbeth->up_lock){+...}-{3:3}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:182 [inline]
       _raw_spin_lock_bh+0x36/0x50 kernel/locking/spinlock.c:205
       spin_lock_bh include/linux/spinlock.h:353 [inline]
       lapbeth_xmit+0x32/0x260 drivers/net/wan/lapbether.c:191
       __netdev_start_xmit include/linux/netdevice.h:5432 [inline]
       netdev_start_xmit include/linux/netdevice.h:5441 [inline]
       xmit_one net/core/dev.c:3953 [inline]
       dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3969
       __dev_queue_xmit+0x14d1/0x3920 net/core/dev.c:4958
       dev_queue_xmit include/linux/netdevice.h:3464 [inline]
       tx+0x6b/0x190 drivers/block/aoe/aoenet.c:62
       kthread+0x1ed/0x420 drivers/block/aoe/aoecmd.c:1241
       kthread+0x38b/0x480 kernel/kthread.c:436
       ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

-> #2 (_xmit_X25#2){+...}-{3:3}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:190 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:173
       spin_lock include/linux/spinlock.h:347 [inline]
       __netif_tx_lock include/linux/netdevice.h:4841 [inline]
       __dev_queue_xmit+0xe9d/0x3920 net/core/dev.c:4952
       neigh_output include/net/neighbour.h:560 [inline]
       ip_finish_output2+0xc4b/0x10b0 net/ipv4/ip_output.c:236
       NF_HOOK_COND include/linux/netfilter.h:314 [inline]
       ip_output+0x29f/0x450 net/ipv4/ip_output.c:437
       iptunnel_xmit+0x626/0xd10 net/ipv4/ip_tunnel_core.c:97
       udp_tunnel_xmit_skb+0x29b/0x3e0 net/ipv4/udp_tunnel_core.c:187
       vxlan_xmit_one+0x21f6/0x2eb0 drivers/net/vxlan/vxlan_core.c:2571
       vxlan_xmit+0x1e19/0x33b0 drivers/net/vxlan/vxlan_core.c:2860
       __netdev_start_xmit include/linux/netdevice.h:5432 [inline]
       netdev_start_xmit include/linux/netdevice.h:5441 [inline]
       xmit_one net/core/dev.c:3953 [inline]
       dev_hard_start_xmit+0x2cd/0x830 net/core/dev.c:3969
       __dev_queue_xmit+0x14d1/0x3920 net/core/dev.c:4958
       lapb_data_transmit+0x90/0xb0 net/lapb/lapb_iface.c:447
       lapb_transmit_buffer+0x163/0x200 net/lapb/lapb_out.c:149
       lapb_establish_data_link+0x89/0xe0 net/lapb/lapb_out.c:-1
       lapb_device_event+0x4eb/0x680 net/lapb/lapb_iface.c:-1
       notifier_call_chain+0x1a5/0x3d0 kernel/notifier.c:85
       call_netdevice_notifiers_extack net/core/dev.c:2313 [inline]
       call_netdevice_notifiers net/core/dev.c:2327 [inline]
       __dev_notify_flags+0x31e/0x510 net/core/dev.c:9896
       netif_change_flags+0xde/0x1b0 net/core/dev.c:9925
       dev_change_flags+0x128/0x260 net/core/dev_api.c:68
       devinet_ioctl+0x966/0x1c50 net/ipv4/devinet.c:1199
       inet_ioctl+0x42a/0x560 net/ipv4/af_inet.c:1010
       sock_do_ioctl+0x101/0x320 net/socket.c:1325
       sock_ioctl+0x57a/0x7e0 net/socket.c:1446
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&lapb->lock){+.-.}-{3:3}:
       __raw_spin_lock_bh include/linux/spinlock_api_smp.h:182 [inline]
       _raw_spin_lock_bh+0x36/0x50 kernel/locking/spinlock.c:205
       spin_lock_bh include/linux/spinlock.h:353 [inline]
       lapb_unregister+0x1e1/0x450 net/lapb/lapb_iface.c:187
       lapbeth_close+0x56/0xb0 drivers/net/wan/lapbether.c:350
       __dev_close_many+0x366/0x6e0 net/core/dev.c:1798
       __dev_close net/core/dev.c:1811 [inline]
       __dev_change_flags+0x3f5/0x820 net/core/dev.c:9853
       netif_change_flags+0x7c/0x1b0 net/core/dev.c:9920
       dev_change_flags+0x128/0x260 net/core/dev_api.c:68
       devinet_ioctl+0x966/0x1c50 net/ipv4/devinet.c:1199
       inet_ioctl+0x42a/0x560 net/ipv4/af_inet.c:1010
       sock_do_ioctl+0x101/0x320 net/socket.c:1325
       sock_ioctl+0x57a/0x7e0 net/socket.c:1446
       vfs_ioctl fs/ioctl.c:51 [inline]
       __do_sys_ioctl fs/ioctl.c:597 [inline]
       __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (lapb_list_lock){++..}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3209 [inline]
       check_prevs_add kernel/locking/lockdep.c:3328 [inline]
       validate_chain kernel/locking/lockdep.c:3952 [inline]
       __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
       lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
       __raw_read_lock_bh include/linux/rwlock_api_smp.h:192 [inline]
       _raw_read_lock_bh+0x3e/0x50 kernel/locking/spinlock.c:287
       lapb_devtostruct net/lapb/lapb_iface.c:102 [inline]
       lapb_data_received+0x2f/0x1c0 net/lapb/lapb_iface.c:394
       lapbeth_rcv+0x34d/0x640 drivers/net/wan/lapbether.c:142
       __netif_receive_skb_one_core net/core/dev.c:6297 [inline]
       __netif_receive_skb net/core/dev.c:6410 [inline]
       netif_receive_skb_internal net/core/dev.c:6496 [inline]
       netif_receive_skb+0x4af/0xbf0 net/core/dev.c:6555
       tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1571
       tun_get_user+0x2be0/0x44d0 drivers/net/tun.c:2045
       tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2091
       new_sync_write fs/read_write.c:595 [inline]
       vfs_write+0x612/0xba0 fs/read_write.c:687
       ksys_write+0x150/0x270 fs/read_write.c:739
       do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
       do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
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

locks held by syz-executor220/6011: 4, last CPU#0:
 #0: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #0: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: tun_get_user+0x27b0/0x44d0 drivers/net/tun.c:1986
 #1: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #1: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_internal net/core/dev.c:6483 [inline]
 #1: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb+0x102/0xbf0 net/core/dev.c:6555
 #2: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #2: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8fd5ce60 (rcu_read_lock){....}-{1:3}, at: lapbeth_rcv+0x12f/0x640 drivers/net/wan/lapbether.c:127
 #3: ffff88802af94f00 (&lapbeth->up_lock){+...}-{3:3}, at: spin_lock_bh include/linux/spinlock.h:353 [inline]
 #3: ffff88802af94f00 (&lapbeth->up_lock){+...}-{3:3}, at: lapbeth_rcv+0x24e/0x640 drivers/net/wan/lapbether.c:131

stack backtrace:
CPU: 0 UID: 0 PID: 6011 Comm: syz-executor220 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/07/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_circular_bug+0x2e2/0x300 kernel/locking/lockdep.c:2087
 check_noncircular+0x12f/0x150 kernel/locking/lockdep.c:2219
 check_prev_add kernel/locking/lockdep.c:3209 [inline]
 check_prevs_add kernel/locking/lockdep.c:3328 [inline]
 validate_chain kernel/locking/lockdep.c:3952 [inline]
 __lock_acquire+0x164c/0x2de0 kernel/locking/lockdep.c:5288
 lock_acquire+0x115/0x350 kernel/locking/lockdep.c:5942
 __raw_read_lock_bh include/linux/rwlock_api_smp.h:192 [inline]
 _raw_read_lock_bh+0x3e/0x50 kernel/locking/spinlock.c:287
 lapb_devtostruct net/lapb/lapb_iface.c:102 [inline]
 lapb_data_received+0x2f/0x1c0 net/lapb/lapb_iface.c:394
 lapbeth_rcv+0x34d/0x640 drivers/net/wan/lapbether.c:142
 __netif_receive_skb_one_core net/core/dev.c:6297 [inline]
 __netif_receive_skb net/core/dev.c:6410 [inline]
 netif_receive_skb_internal net/core/dev.c:6496 [inline]
 netif_receive_skb+0x4af/0xbf0 net/core/dev.c:6555
 tun_rx_batched+0x1de/0x790 drivers/net/tun.c:1571
 tun_get_user+0x2be0/0x44d0 drivers/net/tun.c:2045
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:2091
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f523ead1137
Code: 48 89 fa 4c 89 df e8 98 1d 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007ffcbef91f00 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00005555890c4400 RCX: 00007f523ead1137
RDX: 0000000000000010 RSI: 00007ffcbef91fb0 RDI: 0000000000000006
RBP: 0000000000000006 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000a
R13: 00007ffcbef91fb0 R14: 00007ffcbef91fa0 R15: 000000000000002c
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
