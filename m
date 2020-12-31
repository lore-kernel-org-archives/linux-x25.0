From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] net: lapb: Decrease the refcount of "struct lapb_cb" in lapb_device_event
Date: Thu, 31 Dec 2020 09:43:31 -0800
Message-ID: <20201231174331.64539-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ia8tv0h5ZzJ5gNszPbUc817/+eyTpNW6AgHWJu4KE0Y=;
        b=vh4Al7TqcE4Rzb9O5aoDb84kXwnxrrNb53k3LgYmbhsbaxGJNktNhFbYmODUnEMEBy
         DIujNqCXaIKxUgK8Vsa+803NJa5flHuEYx/GXMqG+wwCbanP7BdLiGkgZwi7C+M+/0Ay
         PTVPl1/NoS7SHHXjXrijudUoGg5AtpFBvJ0BoyMKzDbI3zSqmNySh7O3CK9XPg0ohcdM
         aEiArn6py+h/xLadFZ6BfAyGS7c89rLZIYhyejflPTNAUr3KQySVnAumumIbuGXrRGCL
         9aF+EKtzpmiK2boJEjGSCRJR0fIV4x9vdOH+44PjRZkgdUtfVMukTfhQXbFH6WcxhBAW
         xY2Q==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>
Cc: Xie He <xie.he.0141@gmail.com>

In lapb_device_event, lapb_devtostruct is called to get a reference to
an object of "struct lapb_cb". lapb_devtostruct increases the refcount
of the object and returns a pointer to it. However, we didn't decrease
the refcount after we finished using the pointer. This patch fixes this
problem.

Fixes: a4989fa91110 ("net/lapb: support netdev events")
Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 net/lapb/lapb_iface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index 213ea7abc9ab..40961889e9c0 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -489,6 +489,7 @@ static int lapb_device_event(struct notifier_block *this, unsigned long event,
 		break;
 	}
 
+	lapb_put(lapb);
 	return NOTIFY_DONE;
 }
 
-- 
2.27.0

