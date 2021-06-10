From: Wang Hai <wanghai38@huawei.com>
Subject: [PATCH net-next] net: x25: Use list_for_each_entry() to simplify code in x25_route.c
Date: Thu, 10 Jun 2021 20:48:26 +0800
Message-ID: <20210610124826.3833818-1-wanghai38@huawei.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <linux-x25-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: davem@davemloft.net, kuba@kernel.org, ms@dev.tdt.de
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Convert list_for_each() to list_for_each_entry() where
applicable. This simplifies the code.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 net/x25/x25_route.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/net/x25/x25_route.c b/net/x25/x25_route.c
index 9fbe4bb38d94..647f325ed867 100644
--- a/net/x25/x25_route.c
+++ b/net/x25/x25_route.c
@@ -27,14 +27,11 @@ static int x25_add_route(struct x25_address *address, unsigned int sigdigits,
 			 struct net_device *dev)
 {
 	struct x25_route *rt;
-	struct list_head *entry;
 	int rc = -EINVAL;
 
 	write_lock_bh(&x25_route_list_lock);
 
-	list_for_each(entry, &x25_route_list) {
-		rt = list_entry(entry, struct x25_route, node);
-
+	list_for_each_entry(rt, &x25_route_list, node) {
 		if (!memcmp(&rt->address, address, sigdigits) &&
 		    rt->sigdigits == sigdigits)
 			goto out;
@@ -78,14 +75,11 @@ static int x25_del_route(struct x25_address *address, unsigned int sigdigits,
 			 struct net_device *dev)
 {
 	struct x25_route *rt;
-	struct list_head *entry;
 	int rc = -EINVAL;
 
 	write_lock_bh(&x25_route_list_lock);
 
-	list_for_each(entry, &x25_route_list) {
-		rt = list_entry(entry, struct x25_route, node);
-
+	list_for_each_entry(rt, &x25_route_list, node) {
 		if (!memcmp(&rt->address, address, sigdigits) &&
 		    rt->sigdigits == sigdigits && rt->dev == dev) {
 			__x25_remove_route(rt);
@@ -141,13 +135,10 @@ struct net_device *x25_dev_get(char *devname)
 struct x25_route *x25_get_route(struct x25_address *addr)
 {
 	struct x25_route *rt, *use = NULL;
-	struct list_head *entry;
 
 	read_lock_bh(&x25_route_list_lock);
 
-	list_for_each(entry, &x25_route_list) {
-		rt = list_entry(entry, struct x25_route, node);
-
+	list_for_each_entry(rt, &x25_route_list, node) {
 		if (!memcmp(&rt->address, addr, rt->sigdigits)) {
 			if (!use)
 				use = rt;
-- 
2.17.1

