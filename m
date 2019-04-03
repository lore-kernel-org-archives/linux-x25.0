From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH 4/4] isdn/i4l: Call notifiers before and after changing device type
Date: Wed,  3 Apr 2019 07:01:18 +0200
Message-ID: <20190403050118.12785-4-ms@dev.tdt.de>
References: <20190403050118.12785-1-ms@dev.tdt.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190403050118.12785-1-ms@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrew.hendry@gmail.com, davem@davemloft.net, khc@pm.waw.pl, isdn@linux-pingi.de
Cc: edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 drivers/isdn/i4l/isdn_net.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/isdn/i4l/isdn_net.c b/drivers/isdn/i4l/isdn_net.c
index c138f66f2659..3016cbcc719a 100644
--- a/drivers/isdn/i4l/isdn_net.c
+++ b/drivers/isdn/i4l/isdn_net.c
@@ -2692,8 +2692,12 @@ isdn_net_setcfg(isdn_net_ioctl_cfg *cfg)
 			       p->dev->name);
 			return -EINVAL;
 #else
+			rtnl_lock();
+			call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE, p->dev);
 			p->dev->type = ARPHRD_PPP;	/* change ARP type */
+			call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE, p->dev);
 			p->dev->addr_len = 0;
+			rtnl_unlock();
 #endif
 			break;
 		case ISDN_NET_ENCAP_X25IFACE:
@@ -2702,16 +2706,27 @@ isdn_net_setcfg(isdn_net_ioctl_cfg *cfg)
 			       p->dev->name);
 			return -EINVAL;
 #else
+			rtnl_lock();
+			call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE, p->dev);
 			p->dev->type = ARPHRD_X25;	/* change ARP type */
+			call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE, p->dev);
 			p->dev->addr_len = 0;
+			rtnl_unlock();
 #endif
 			break;
 		case ISDN_NET_ENCAP_CISCOHDLCK:
 			break;
 		default:
 			if (cfg->p_encap >= 0 &&
-			    cfg->p_encap <= ISDN_NET_ENCAP_MAX_ENCAP)
+			    cfg->p_encap <= ISDN_NET_ENCAP_MAX_ENCAP) {
+				rtnl_lock();
+				call_netdevice_notifiers(NETDEV_PRE_TYPE_CHANGE, p->dev);
+				p->dev->type = ARPHRD_ETHER;	/* change ARP type */
+				call_netdevice_notifiers(NETDEV_POST_TYPE_CHANGE, p->dev);
+				p->dev->addr_len = ETH_ALEN;
+				rtnl_unlock();
 				break;
+			}
 			printk(KERN_WARNING
 			       "%s: encapsulation protocol %d not supported\n",
 			       p->dev->name, cfg->p_encap);
-- 
2.11.0

