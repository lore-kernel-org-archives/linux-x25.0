From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] net/x25: use designated initializers
Date: Fri, 16 Dec 2016 17:03:39 -0800
Message-ID: <20161217010339.GA140529@beast>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MIeg6kOuCMdVfuo9LjJs2drPgcyusla2AEX1pMTedRw=;
        b=nR1hutRaC7IZ7qO3koBkmPD9LRhQBqM1Ot4arK4TontsUEHbvmmY9FJRzbLD3WQeK2
         8pXqpwlvkvL2pWDnohd4BDvWxaN9KpOHZv3knOXLoyYUY8gsFSk0VhJqUNnA5wo10vAz
         nPnDuo2ueSGVjI3gop6wM7E5OU2iDn33ZXaBA=
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org

Prepare to mark sensitive kernel structures for randomization by making
sure they're using designated initializers. These were identified during
allyesconfig builds of x86, arm, and arm64, with most initializer fixes
extracted from grsecurity.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/x25/sysctl_net_x25.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/x25/sysctl_net_x25.c b/net/x25/sysctl_net_x25.c
index 43239527a205..a06dfe143c67 100644
--- a/net/x25/sysctl_net_x25.c
+++ b/net/x25/sysctl_net_x25.c
@@ -70,7 +70,7 @@ static struct ctl_table x25_table[] = {
 		.mode = 	0644,
 		.proc_handler = proc_dointvec,
 	},
-	{ 0, },
+	{ },
 };
 
 void __init x25_register_sysctl(void)
-- 
2.7.4


-- 
Kees Cook
Nexus Security
