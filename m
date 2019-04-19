From: syzbot <syzbot+b0775615fa4c4479b691@syzkaller.appspotmail.com>
Subject: Re: KASAN: use-after-free Read in refcount_sub_and_test_checked (2)
Date: Fri, 19 Apr 2019 01:21:00 -0700
Message-ID: <0000000000008265310586ddcc2a@google.com>
References: <0000000000004a6d7c057e77e97e@google.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0000000000004a6d7c057e77e97e@google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"; delsp="yes"
Content-Transfer-Encoding: 7bit
To: -O-request@vger.kernel.org, acme@kernel.org, aisheng.dong@nxp.com, alexander.shishkin@linux.intel.com, andrew.hendry@gmail.com, ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net, dvlasenk@redhat.com, fabio.estevam@nxp.com, gregkh@linuxfoundation.org, jolsa@redhat.com, kafai@fb.com, kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, mingo@redhat.com, ms@dev.tdt.de, mturquette@baylibre.com, namhyung@kernel.org, netdev@vger.kernel.org, peterz@infradead.org, sboyd@kernel.org, shawnguo@kernel.org, songliubraving@fb.com, syzkaller-bugs@googlegroups.com, yhs@fb.com

syzbot has bisected this bug to:

commit cd67d3272768aa3f44c0f7cc71b82a112dce01fa
Author: Aisheng Dong <aisheng.dong@nxp.com>
Date:   Thu Jan 24 13:22:49 2019 +0000

     clk: imx: scu: add fallback compatible string support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f0432d200000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13f0432d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f0432d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=b0775615fa4c4479b691
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15df396b200000

Reported-by: syzbot+b0775615fa4c4479b691@syzkaller.appspotmail.com
Fixes: cd67d3272768 ("clk: imx: scu: add fallback compatible string  
support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
