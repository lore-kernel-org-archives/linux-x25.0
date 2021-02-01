From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Sun, 31 Jan 2021 21:57:06 -0800
Message-ID: <20210201055706.415842-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u9WcgY/7dzWX3O9rNeZQ45WY9vESYPTTGXpSkl0YUkI=;
        b=Ih0G2mIOJJKmBb2ZACWolGcOpStbwLKcyk6kFoADEB0DP5RFHVEQumuS4q1QL6gRhx
         XymbM/t3dKVkAO2sV6yIHPRjw93zfHa/7CSinrC2hfs9k0QVVs5hJ8g8APHdfTjetOtk
         yKHRMGH37CXPXbVtEgNJSPQ9s5dHSs7HprVGRGLZHFR7i7UMz3NO2acZuKmAHVqlUcQp
         q4z627DeuguOgMLczPFgl5UeNWiVCe1dPCmCEf2VosjvxwZs9qHAW927MooWjH0hbFF2
         4cIngYZIjDY/Pa2MflMjZSp1hHe1eHHaFX/koE6Ag5nd/4yQ/aVtpBOKd0HXf798WSU7
         vHpg==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>
Cc: Xie He <xie.he.0141@gmail.com>

When sending a packet, we will prepend it with an LAPB header.
This modifies the shared parts of a cloned skb, so we should copy the
skb rather than just clone it, before we prepend the header.

In "Documentation/networking/driver.rst" (the 2nd point), it states
that drivers shouldn't modify the shared parts of a cloned skb when
transmitting.

The "dev_queue_xmit_nit" function in "net/core/dev.c", which is called
when an skb is being sent, clones the skb and sents the clone to
AF_PACKET sockets. Because the LAPB drivers first remove a 1-byte
pseudo-header before handing over the skb to us, if we don't copy the
skb before prepending the LAPB header, the first byte of the packets
received on AF_PACKET sockets can be corrupted.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 net/lapb/lapb_out.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/lapb/lapb_out.c b/net/lapb/lapb_out.c
index 7a4d0715d1c3..a966d29c772d 100644
--- a/net/lapb/lapb_out.c
+++ b/net/lapb/lapb_out.c
@@ -82,7 +82,8 @@ void lapb_kick(struct lapb_cb *lapb)
 		skb = skb_dequeue(&lapb->write_queue);
 
 		do {
-			if ((skbn = skb_clone(skb, GFP_ATOMIC)) == NULL) {
+			skbn = skb_copy(skb, GFP_ATOMIC);
+			if (!skbn) {
 				skb_queue_head(&lapb->write_queue, skb);
 				break;
 			}
-- 
2.27.0

