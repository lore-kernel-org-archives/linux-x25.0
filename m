From: Wang Hai <wanghai38@huawei.com>
Subject: [PATCH net-next] net: lapb: Use list_for_each_entry() to simplify code in lapb_iface.c
Date: Tue, 8 Jun 2021 08:13:01 +0000
Message-ID: <20210608081301.15264-1-wanghai38@huawei.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ms@dev.tdt.de, davem@davemloft.net, kuba@kernel.org
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Convert list_for_each() to list_for_each_entry() where
applicable. This simplifies the code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/lapb/lapb_iface.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index 1078e14f1acf..0971ca48ba15 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -80,11 +80,9 @@ static void __lapb_insert_cb(struct lapb_cb *lapb)
 
 static struct lapb_cb *__lapb_devtostruct(struct net_device *dev)
 {
-	struct list_head *entry;
 	struct lapb_cb *lapb, *use = NULL;
 
-	list_for_each(entry, &lapb_list) {
-		lapb = list_entry(entry, struct lapb_cb, node);
+	list_for_each_entry(lapb, &lapb_list, node) {
 		if (lapb->dev == dev) {
 			use = lapb;
 			break;
-- 
2.17.1

