From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net-next] net: x25: Remove unimplemented X.25-over-LLC code stubs
Date: Tue,  8 Dec 2020 19:33:46 -0800
Message-ID: <20201209033346.83742-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a83b//FaNAazZrbKxCVDpq5sDqquOZMLq79muQFPdAk=;
        b=YjwpSU8/1igV9WXVOWfx2ksH7iKlybNu4gKje6vY5aJRFrtZWHKtAOxFssptlAjnPy
         tsj/5lH9nSndDdHtRVcf+Eznr2JSQCvmXpw9bhPJ8mxc287L956Y7PFhOknFEOgnIo1n
         wxXa9GDqsTDX2nhkvIc4NQhwSjYEogqB2uIIwvbN+x58FWjTSQ7xTiGs2b/p/hqnrJcR
         BIAjolYlo9CT88D9Np7bBjunXmut9HzRQPL7lj2fEyYs1HE+4JMHkJcll1eWVAYxQHiz
         YldXcGgsARI02+CwQdljjK+utq9k24pDEOQ6h565q6SzKaP2xtD0SX/fYjrWwSbGk3F4
         BJJw==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>
Cc: Xie He <xie.he.0141@gmail.com>

According to the X.25 documentation, there was a plan to implement
X.25-over-802.2-LLC. It never finished but left various code stubs in the
X.25 code. At this time it is unlikely that it would ever finish so it
may be better to remove those code stubs.

Also change the documentation to make it clear that this is not a ongoing
plan anymore. Change words like "will" to "could", "would", etc.

Cc: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 Documentation/networking/x25.rst | 12 +++++-------
 net/x25/af_x25.c                 |  6 +-----
 net/x25/x25_dev.c                | 13 -------------
 net/x25/x25_route.c              |  7 +------
 4 files changed, 7 insertions(+), 31 deletions(-)

diff --git a/Documentation/networking/x25.rst b/Documentation/networking/x25.rst
index 00e45d384ba0..e11d9ebdf9a3 100644
--- a/Documentation/networking/x25.rst
+++ b/Documentation/networking/x25.rst
@@ -19,13 +19,11 @@ implementation of LAPB. Therefore the LAPB modules would be called by
 unintelligent X.25 card drivers and not by intelligent ones, this would
 provide a uniform device driver interface, and simplify configuration.
 
-To confuse matters a little, an 802.2 LLC implementation for Linux is being
-written which will allow X.25 to be run over an Ethernet (or Token Ring) and
-conform with the JNT "Pink Book", this will have a different interface to
-the Packet Layer but there will be no confusion since the class of device
-being served by the LLC will be completely separate from LAPB. The LLC
-implementation is being done as part of another protocol project (SNA) and
-by a different author.
+To confuse matters a little, an 802.2 LLC implementation is also possible
+which could allow X.25 to be run over an Ethernet (or Token Ring) and
+conform with the JNT "Pink Book", this would have a different interface to
+the Packet Layer but there would be no confusion since the class of device
+being served by the LLC would be completely separate from LAPB.
 
 Just when you thought that it could not become more confusing, another
 option appeared, XOT. This allows X.25 Packet Layer frames to operate over
diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index d41fffb2507b..ff687b97b2d9 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -211,11 +211,7 @@ static int x25_device_event(struct notifier_block *this, unsigned long event,
 	if (!net_eq(dev_net(dev), &init_net))
 		return NOTIFY_DONE;
 
-	if (dev->type == ARPHRD_X25
-#if IS_ENABLED(CONFIG_LLC)
-	 || dev->type == ARPHRD_ETHER
-#endif
-	 ) {
+	if (dev->type == ARPHRD_X25) {
 		switch (event) {
 		case NETDEV_REGISTER:
 		case NETDEV_POST_TYPE_CHANGE:
diff --git a/net/x25/x25_dev.c b/net/x25/x25_dev.c
index 25bf72ee6cad..5259ef8f5242 100644
--- a/net/x25/x25_dev.c
+++ b/net/x25/x25_dev.c
@@ -160,10 +160,6 @@ void x25_establish_link(struct x25_neigh *nb)
 		*ptr = X25_IFACE_CONNECT;
 		break;
 
-#if IS_ENABLED(CONFIG_LLC)
-	case ARPHRD_ETHER:
-		return;
-#endif
 	default:
 		return;
 	}
@@ -179,10 +175,6 @@ void x25_terminate_link(struct x25_neigh *nb)
 	struct sk_buff *skb;
 	unsigned char *ptr;
 
-#if IS_ENABLED(CONFIG_LLC)
-	if (nb->dev->type == ARPHRD_ETHER)
-		return;
-#endif
 	if (nb->dev->type != ARPHRD_X25)
 		return;
 
@@ -212,11 +204,6 @@ void x25_send_frame(struct sk_buff *skb, struct x25_neigh *nb)
 		*dptr = X25_IFACE_DATA;
 		break;
 
-#if IS_ENABLED(CONFIG_LLC)
-	case ARPHRD_ETHER:
-		kfree_skb(skb);
-		return;
-#endif
 	default:
 		kfree_skb(skb);
 		return;
diff --git a/net/x25/x25_route.c b/net/x25/x25_route.c
index ec2a39e9b3e6..9fbe4bb38d94 100644
--- a/net/x25/x25_route.c
+++ b/net/x25/x25_route.c
@@ -124,12 +124,7 @@ struct net_device *x25_dev_get(char *devname)
 {
 	struct net_device *dev = dev_get_by_name(&init_net, devname);
 
-	if (dev &&
-	    (!(dev->flags & IFF_UP) || (dev->type != ARPHRD_X25
-#if IS_ENABLED(CONFIG_LLC)
-					&& dev->type != ARPHRD_ETHER
-#endif
-					))){
+	if (dev && (!(dev->flags & IFF_UP) || dev->type != ARPHRD_X25)) {
 		dev_put(dev);
 		dev = NULL;
 	}
-- 
2.27.0

