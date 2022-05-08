From: Colin Ian King <colin.i.king@gmail.com>
Subject: [PATCH] x25: remove redundant pointer dev
Date: Sun,  8 May 2022 22:45:00 +0100
Message-ID: <20220508214500.60446-1-colin.i.king@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sz9yDMbWolCR5CSm2J/3vC7zIKazVJISgiLAk/Sxmjk=;
        b=odEgRES1w3ohIoQJFJMZIgwiqx0w9ikZ5ahO6mKSOCp5MV2nmKdXmMa7ejQCzBEk4V
         6R1CSUB6tZptfCRhrKnB1vNWbOLi64YT2Hi+c0HL9+oYjINMASi5tDhYdw1fCJODPbC0
         10rOjcK0UOKfoJ9Xc2hOCRXvC4k93g2wuIfbmyvn8OAYISHIKxVyzlFQ6Z5BC1EeRkS8
         TNbylN5WqYiOAPbiz7hubby5HgaJazQtdpHYw8dsoEzhyXIqBJQyR2QLMLXiSuU4ogmj
         mHCIC/h9Ee/4LheQ8KaApm5E5dDQkinwP02y2XvlLjowe5BZWJZSU3awpGaNzlP1y1Or
         98Hw==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

Pointer dev is being assigned a value that is never used, the assignment
and the variable are redundant and can be removed. Also replace null check
with the preferred !ptr idiom.

Cleans up clang scan warning:
net/x25/x25_proc.c:94:26: warning: Although the value stored to 'dev' is
used in the enclosing expression, the value is never actually read
from 'dev' [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 net/x25/x25_proc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/x25/x25_proc.c b/net/x25/x25_proc.c
index 3bddcbdf2e40..91a2aade3960 100644
--- a/net/x25/x25_proc.c
+++ b/net/x25/x25_proc.c
@@ -79,7 +79,6 @@ static int x25_seq_socket_show(struct seq_file *seq, void *v)
 {
 	struct sock *s;
 	struct x25_sock *x25;
-	struct net_device *dev;
 	const char *devname;
 
 	if (v == SEQ_START_TOKEN) {
@@ -91,7 +90,7 @@ static int x25_seq_socket_show(struct seq_file *seq, void *v)
 	s = sk_entry(v);
 	x25 = x25_sk(s);
 
-	if (!x25->neighbour || (dev = x25->neighbour->dev) == NULL)
+	if (!x25->neighbour || !x25->neighbour->dev)
 		devname = "???";
 	else
 		devname = x25->neighbour->dev->name;
-- 
2.35.1

