From: Zhengchao Shao <shaozhengchao@huawei.com>
Subject: [PATCH net] net: lapbether: fix issue of invalid opcode in lapbeth_open()
Date: Mon, 7 Nov 2022 09:14:45 +0800
Message-ID: <20221107011445.207372-1-shaozhengchao@huawei.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-x25@vger.kernel.org, netdev@vger.kernel.org, ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: xie.he.0141@gmail.com, weiyongjun1@huawei.com, yuehaibing@huawei.com, shaozhengchao@huawei.com

If lapb_register() failed when lapb device goes to up for the first time,
the NAPI is not disabled. As a result, the invalid opcode issue is
reported when the lapb device goes to up for the second time.

The stack info is as follows:
[ 1958.311422][T11356] kernel BUG at net/core/dev.c:6442!
[ 1958.312206][T11356] invalid opcode: 0000 [#1] PREEMPT SMP KASAN
[ 1958.315979][T11356] RIP: 0010:napi_enable+0x16a/0x1f0
[ 1958.332310][T11356] Call Trace:
[ 1958.332817][T11356]  <TASK>
[ 1958.336135][T11356]  lapbeth_open+0x18/0x90
[ 1958.337446][T11356]  __dev_open+0x258/0x490
[ 1958.341672][T11356]  __dev_change_flags+0x4d4/0x6a0
[ 1958.345325][T11356]  dev_change_flags+0x93/0x160
[ 1958.346027][T11356]  devinet_ioctl+0x1276/0x1bf0
[ 1958.346738][T11356]  inet_ioctl+0x1c8/0x2d0
[ 1958.349638][T11356]  sock_ioctl+0x5d1/0x750
[ 1958.356059][T11356]  __x64_sys_ioctl+0x3ec/0x1790
[ 1958.365594][T11356]  do_syscall_64+0x35/0x80
[ 1958.366239][T11356]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
[ 1958.377381][T11356]  </TASK>

Fixes: 514e1150da9c ("net: x25: Queue received packets in the drivers instead of per-CPU queues")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 drivers/net/wan/lapbether.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index 960f1393595c..c485b371e844 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -325,6 +325,7 @@ static int lapbeth_open(struct net_device *dev)
 
 	err = lapb_register(dev, &lapbeth_callbacks);
 	if (err != LAPB_OK) {
+		napi_disable(&lapbeth->napi);
 		pr_err("lapb_register error: %d\n", err);
 		return -ENODEV;
 	}
-- 
2.17.1

