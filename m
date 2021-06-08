From: Wang Hai <wanghai38@huawei.com>
Subject: [PATCH net-next] net: x25: Use list_for_each_entry() to simplify code in x25_link.c
Date: Tue, 8 Jun 2021 08:05:05 +0000
Message-ID: <20210608080505.32466-1-wanghai38@huawei.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, kuba@kernel.org, ms@dev.tdt.de
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Convert list_for_each() to list_for_each_entry() where
applicable. This simplifies the code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/x25/x25_link.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/x25/x25_link.c b/net/x25/x25_link.c
index 57a81100c5da..5460b9146dd8 100644
--- a/net/x25/x25_link.c
+++ b/net/x25/x25_link.c
@@ -332,12 +332,9 @@ void x25_link_device_down(struct net_device *dev)
 struct x25_neigh *x25_get_neigh(struct net_device *dev)
 {
 	struct x25_neigh *nb, *use = NULL;
-	struct list_head *entry;
 
 	read_lock_bh(&x25_neigh_list_lock);
-	list_for_each(entry, &x25_neigh_list) {
-		nb = list_entry(entry, struct x25_neigh, node);
-
+	list_for_each_entry(nb, &x25_neigh_list, node) {
 		if (nb->dev == dev) {
 			use = nb;
 			break;
-- 
2.17.1

