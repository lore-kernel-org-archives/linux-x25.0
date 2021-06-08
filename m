From: Wang Hai <wanghai38@huawei.com>
Subject: [PATCH net-next] net: x25: Use list_for_each_entry() to simplify code in x25_forward.c
Date: Tue, 8 Jun 2021 13:30:07 +0000
Message-ID: <20210608133007.69476-1-wanghai38@huawei.com>
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
 net/x25/x25_forward.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/net/x25/x25_forward.c b/net/x25/x25_forward.c
index d48ad6d29197..21b30b56e889 100644
--- a/net/x25/x25_forward.c
+++ b/net/x25/x25_forward.c
@@ -19,7 +19,6 @@ int x25_forward_call(struct x25_address *dest_addr, struct x25_neigh *from,
 {
 	struct x25_route *rt;
 	struct x25_neigh *neigh_new = NULL;
-	struct list_head *entry;
 	struct x25_forward *x25_frwd, *new_frwd;
 	struct sk_buff *skbn;
 	short same_lci = 0;
@@ -46,8 +45,7 @@ int x25_forward_call(struct x25_address *dest_addr, struct x25_neigh *from,
 	 * established LCI? It shouldn't happen, just in case..
 	 */
 	read_lock_bh(&x25_forward_list_lock);
-	list_for_each(entry, &x25_forward_list) {
-		x25_frwd = list_entry(entry, struct x25_forward, node);
+	list_for_each_entry(x25_frwd, &x25_forward_list, node) {
 		if (x25_frwd->lci == lci) {
 			pr_warn("call request for lci which is already registered!, transmitting but not registering new pair\n");
 			same_lci = 1;
@@ -92,15 +90,13 @@ int x25_forward_call(struct x25_address *dest_addr, struct x25_neigh *from,
 int x25_forward_data(int lci, struct x25_neigh *from, struct sk_buff *skb) {
 
 	struct x25_forward *frwd;
-	struct list_head *entry;
 	struct net_device *peer = NULL;
 	struct x25_neigh *nb;
 	struct sk_buff *skbn;
 	int rc = 0;
 
 	read_lock_bh(&x25_forward_list_lock);
-	list_for_each(entry, &x25_forward_list) {
-		frwd = list_entry(entry, struct x25_forward, node);
+	list_for_each_entry(frwd, &x25_forward_list, node) {
 		if (frwd->lci == lci) {
 			/* The call is established, either side can send */
 			if (from->dev == frwd->dev1) {
-- 
2.17.1

