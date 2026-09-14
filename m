Received: from mail-oi2-f4.google.com (mail-oi2-f4.google.com [74.125.231.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1CF44E038
	for <linux-x25@vger.kernel.org>; Mon, 14 Sep 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388499; cv=none; b=gCirjnV6wlYn9uKyFv/ebPasQKkKoFQPhRiLFDPW+6QnGBJ4UqhoNwvnXDwhHLoIZKH/RYeSvE0Lk7o9yQqhPomF2V+5E21oNBr5OZ/ZSCdpdCJ6pi9b6YxKp4lKoqK69F0dDqnCrKA9x9y5x0B1RlmM00zoInXNVlKAkUtj0uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388499; c=relaxed/simple;
	bh=Kmt3U6aCnvm8ODcbXPvtiqO1+mZ/LdmjAd6NR877ObQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GSrhyroS/3n5gL2nerEXzatk0JKcKYYbbT7F051zn8z5z9IHe9CZRn1iStWa4qNcCXVBa/uU62wwCQtaIf6oJnZE0uNiu+gQVR2rv4OjxLqOzEqIFntURRHG5nmZJBuMhq7ARGDd+1+L11NzDMYojNMmSZD/oas4F4/5n5dtab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=74.125.231.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi2-f4.google.com with SMTP id 5614622812f47-4ab2d8e7e4cso779709b6e.1
        for <linux-x25@vger.kernel.org>; Mon, 14 Sep 2026 05:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789388496; x=1789993296;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e7UDkI1nI2STLL0UfF59SCQqQeL0tsVPdReWpwLzv/Q=;
        b=m5GvA9Ysn1u/DCj318P1yFHziz8/mjvK3OjoAEsmm/R+195NbaHKcWOc0nQ8OB1AM0
         x8/EEQmKZIun1j+K+pyVzdHASBUxGEYaIvi951zSO2/OsXVWxzx8MgYsWWoXCyTtodJ1
         F9ax3XC5aFrtQjUbnRgRAavELMSovoNZIiye1ddkazGcBFCVuTJ386gBi7HgB9SpCVHa
         f5R7SUS9ROzTapJt8T4DjyDKHMJyV2G94rSrozP8Ad8lUYKsVTe1r3wlQj2zaJq85/co
         AJp6UhZhqJbqjplNUockfqJWii7LwGneEkMizGFzDUNCNYQD/iupAU6eMHfoZ6cWLuAA
         yCjw==
X-Forwarded-Encrypted: i=1; AKwUvByrGQdLxHK80loyDstBAF1cLR+r2fNQ9dFlzCNb5g73SvWcMb6QSsHatwjju9k4hdCV3bDqXqFBVVI=@vger.kernel.org
X-Gm-Message-State: AFuF++nDtHRqA1QoOgRl5OfiPV4tXJC0Y3BbLE/h0UGGGo5LF/kbcu1X
	Pnw119MhDHjNx9gjSRkFTiZvaRPHXIxC6+5/X4aV8KjNRx9JgR3i/x2dhYZUpV8DdeSDcbIy6cg
	KOAEGjRmKe9jJB/gKuv2G9jKPoGrBvSa+/e9Ggp9XNa0lzevUISamJsnyDD4=
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:bc8:b0:4b3:1e40:640b with SMTP id
 5614622812f47-4c7b34d5ff9mr1493286b6e.6.1789388496650; Mon, 14 Sep 2026
 05:21:36 -0700 (PDT)
Date: Mon, 14 Sep 2026 05:21:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aa7e6d0.4c28b7d0.c1bba.001c.GAE@google.com>
Subject: [syzbot] [x25?] BUG: sleeping function called from invalid context in x25_kill_by_neigh
From: syzbot <syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, 
	ms@dev.tdt.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    50d05c7c76c9 Merge tag 'landlock-7.3-rc3' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14abb749580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b454dc6b1b7acd30
dashboard link: https://syzkaller.appspot.com/bug?extid=9faa82ae2e94c5c7d2ef
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12445ef9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16445ef9580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7171282977df/disk-50d05c7c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb180d9b54d5/vmlinux-50d05c7c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff1f279b8f9e/bzImage-50d05c7c.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9faa82ae2e94c5c7d2ef@syzkaller.appspotmail.com

BUG: sleeping function called from invalid context at net/core/sock.c:3832
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 29, name: ktimers/1
preempt_count: 0, expected: 0
RCU nest depth: 2, expected: 0
locks held by ktimers/1/29: 4, last CPU#1:
 #0: ffffffff8e0594c0 (local_bh){.+.+}-{1:3}, at: __local_bh_disable_ip+0x3d/0x420 kernel/softirq.c:186
 #1: ffffffff8e1c3c40 (rcu_read_lock){....}-{1:3}, at: __local_bh_disable_ip+0x3d/0x420 kernel/softirq.c:186
 #2: ffffffff8e1c3c40 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:309 [inline]
 #2: ffffffff8e1c3c40 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e1c3c40 (rcu_read_lock){....}-{1:3}, at: netif_receive_skb_core+0x33/0x2b0 net/core/dev.c:6288
 #3: ffff888038d40358 (sk_lock-AF_X25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1713 [inline]
 #3: ffff888038d40358 (sk_lock-AF_X25){+.+.}-{0:0}, at: x25_kill_by_neigh+0x134/0x2a0 net/x25/af_x25.c:1778
CPU: 1 UID: 0 PID: 29 Comm: ktimers/1 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x31b/0x470 kernel/sched/core.c:9256
 lock_sock_nested+0x56/0x130 net/core/sock.c:3832
 lock_sock include/net/sock.h:1713 [inline]
 x25_kill_by_neigh+0x134/0x2a0 net/x25/af_x25.c:1778
 x25_lapb_receive_frame+0x1b0/0xfb0 net/x25/x25_dev.c:138
 __netif_receive_skb_one_core net/core/dev.c:6264 [inline]
 netif_receive_skb_core+0x2a6/0x2b0 net/core/dev.c:6289
 lapbeth_napi_poll+0x45/0x90 drivers/net/wan/lapbether.c:100
 __napi_poll+0xae/0x550 net/core/dev.c:7787
 napi_poll net/core/dev.c:7850 [inline]
 net_rx_action+0x621/0xd70 net/core/dev.c:8007
 handle_softirqs+0x1da/0x6d0 kernel/softirq.c:645
 __do_softirq kernel/softirq.c:679 [inline]
 run_ktimerd+0x6a/0x100 kernel/softirq.c:1174
 smpboot_thread_fn+0x565/0xa70 kernel/smpboot.c:160
 kthread+0x38b/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
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
