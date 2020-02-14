From: qiwuchen55@gmail.com
Subject: [PATCH] net: x25: convert to list_for_each_entry_safe()
Date: Fri, 14 Feb 2020 17:18:26 +0800
Message-ID: <1581671906-25193-1-git-send-email-qiwuchen55@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UzYbwtwKA1AGrhFZKB3Ip5Yi+gAW9TQK1zZ/5sDugks=;
        b=SVae4BfApQzyb7YjOJUfBEMzPKrdEnNYKj0XGWfGfHP43HqNwuISRfIon4XPOn6Ocq
         3aTjwGIkhOQk75xC0g9C3pA2FQ7RI1cokJ5G9OIhBJ1O64ZsGc/6h7JR2V6f2ss0VyaB
         D49sI1GuODI45DtB/tvcdesuJLzEU6uKyMK6DJWvUANQ7BshLMncbPU2UXLXiUIYJ0Ci
         GrNZVgd7TGkBG2d7wurrmtpy0Y3pXE655TXHPK8fieQnl/Y604AmoY1tSf7kuVJLNEYZ
         BaxPH+7iLFUd14OczZrbAh4ErLLrC3/sc4kOhwvZ9G4lBDL8kiRg41SPy2pEGOowrIot
         faaw==
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org
Cc: allison@lohutok.net, tglx@linutronix.de, linux-x25@vger.kernel.org, netdev@vger.kernel.org, chenqiwu <chenqiwu@xiaomi.com>

From: chenqiwu <chenqiwu@xiaomi.com>

Use list_for_each_entry_safe() instead of list_for_each_safe()
to simplify the code.

Signed-off-by: chenqiwu <chenqiwu@xiaomi.com>
---
 net/x25/x25_forward.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/x25/x25_forward.c b/net/x25/x25_forward.c
index c829999..d48ad6d 100644
--- a/net/x25/x25_forward.c
+++ b/net/x25/x25_forward.c
@@ -131,13 +131,11 @@ int x25_forward_data(int lci, struct x25_neigh *from, struct sk_buff *skb) {
 
 void x25_clear_forward_by_lci(unsigned int lci)
 {
-	struct x25_forward *fwd;
-	struct list_head *entry, *tmp;
+	struct x25_forward *fwd, *tmp;
 
 	write_lock_bh(&x25_forward_list_lock);
 
-	list_for_each_safe(entry, tmp, &x25_forward_list) {
-		fwd = list_entry(entry, struct x25_forward, node);
+	list_for_each_entry_safe(fwd, tmp, &x25_forward_list, node) {
 		if (fwd->lci == lci) {
 			list_del(&fwd->node);
 			kfree(fwd);
@@ -149,13 +147,11 @@ void x25_clear_forward_by_lci(unsigned int lci)
 
 void x25_clear_forward_by_dev(struct net_device *dev)
 {
-	struct x25_forward *fwd;
-	struct list_head *entry, *tmp;
+	struct x25_forward *fwd, *tmp;
 
 	write_lock_bh(&x25_forward_list_lock);
 
-	list_for_each_safe(entry, tmp, &x25_forward_list) {
-		fwd = list_entry(entry, struct x25_forward, node);
+	list_for_each_entry_safe(fwd, tmp, &x25_forward_list, node) {
 		if ((fwd->dev1 == dev) || (fwd->dev2 == dev)){
 			list_del(&fwd->node);
 			kfree(fwd);
-- 
1.9.1

