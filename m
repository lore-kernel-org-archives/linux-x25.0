From: "John Hughes" <john@Calva.COM>
Subject: RE : XOTD on Linux 2.4
Date: Fri, 21 Feb 2003 11:47:13 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <002901c2d996$988d3cf0$8000a8c0@britannic>
References: <Pine.LNX.4.33.0302211036340.13873-100000@www.ecommit.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_002A_01C2D99E.FA51A4F0"
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0302211036340.13873-100000@www.ecommit.de>
List-Id: <linux-x25.vger.kernel.org>
To: 'Matthias Shen' <shen@www.ecommit.de>
Cc: linux-x25@vger.kernel.org

C'est un message de format MIME en plusieurs parties.

------=_NextPart_000_002A_01C2D99E.FA51A4F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

> facing the task to use xot on a linux box I found your xotd
> deamon.

Not mine, if you're talking about the one on
http://www.atlantech.com/~john it's a hacked version of the xotd
written by Stephane Fillod.

> It seems to work perfectly on 2.2.x Kernel Versions (connecting
> to a Cisco 800). Now my question: Do you have any experience
> using xotd on 2.4 based Kernels?

I've only ever used it on 2.4 kernels (2.4.19 to be precise), the
changes to the 2.2 patch are minor.  I attach my version of the
patch to this message will put a copy up on my webpage.


------=_NextPart_000_002A_01C2D99E.FA51A4F0
Content-Type: text/plain;
	name="x25tap-2.4.19.diff.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="x25tap-2.4.19.diff.txt"

--- linux-2.4.19/drivers/net/Config.in.orig	Sat Aug  3 02:39:44 2002
+++ linux-2.4.19/drivers/net/Config.in	Fri Aug 30 11:47:42 2002
@@ -11,6 +11,9 @@
 if [ "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
    tristate 'Ethertap network tap (OBSOLETE)' CONFIG_ETHERTAP
 fi
+if [ "$CONFIG_EXPERIMENTAL" =3D "y" ]; then
+   tristate 'X.25tap network tap' CONFIG_X25TAP
+fi
=20
 if [ "$CONFIG_ISAPNP" =3D "y" -o "$CONFIG_ISAPNP" =3D "m" ]; then
    dep_tristate 'General Instruments Surfboard 1000' CONFIG_NET_SB1000 =
$CONFIG_ISAPNP
--- linux-2.4.19/drivers/net/Makefile.orig	Sat Aug  3 02:39:44 2002
+++ linux-2.4.19/drivers/net/Makefile	Fri Aug 30 12:33:33 2002
@@ -108,6 +108,7 @@
 obj-$(CONFIG_NET) +=3D Space.o setup.o net_init.o loopback.o
 obj-$(CONFIG_SEEQ8005) +=3D seeq8005.o
 obj-$(CONFIG_ETHERTAP) +=3D ethertap.o
+obj-$(CONFIG_X25TAP) +=3D x25tap.o
 obj-$(CONFIG_NET_SB1000) +=3D sb1000.o
 obj-$(CONFIG_MAC8390) +=3D daynaport.o 8390.o
 obj-$(CONFIG_APNE) +=3D apne.o 8390.o
--- linux-2.4.19/drivers/net/Space.c.orig	Sat Aug  3 02:39:44 2002
+++ linux-2.4.19/drivers/net/Space.c	Fri Aug 30 11:52:58 2002
@@ -92,6 +92,7 @@
 extern int pamsnet_probe(struct net_device *);
 extern int cs89x0_probe(struct net_device *dev);
 extern int ethertap_probe(struct net_device *dev);
+extern int x25tap_probe(struct device *dev);
 extern int hplance_probe(struct net_device *dev);
 extern int bagetlance_probe(struct net_device *);
 extern int mvme147lance_probe(struct net_device *dev);
@@ -475,6 +476,12 @@
 #   define NEXT_DEV	(&tap0_dev)
 #endif
=20
+#ifdef CONFIG_X25TAP
+    static struct device x25tap0_dev =3D { "x25tap0", 0, 0, 0, 0, =
NETLINK_TAPBASE, 0, 0, 0, 0, NEXT_DEV, x25tap_probe, };
+#   undef NEXT_DEV
+#   define NEXT_DEV	(&x25tap0_dev)
+#endif
+
 #ifdef CONFIG_SDLA
     extern int sdla_init(struct net_device *);
     static struct net_device sdla0_dev =3D { "sdla0", 0, 0, 0, 0, 0, 0, =
0, 0, 0, NEXT_DEV, sdla_init, };
--- linux-2.4.19/drivers/net/x25tap.c.orig	Thu Jan  1 01:00:00 1970
+++ linux-2.4.19/drivers/net/x25tap.c	Mon Sep  2 12:17:18 2002
@@ -0,0 +1,353 @@
+/*
+ *	X25tap: A network device for bouncing packets via user space
+ *
+ *	X25tap is cloned from ethertap
+ *
+ *	This is a very simple X.25 driver. It bounces X.25 level2 frames
+ *	to user space on /dev/tap0->/dev/tap15 and expects X.25 frames
+ *	to be written back to it.=20
+ *
+ *	Connection state handling is left to the user pluged into the tap
+ *	as explained in Documentation/networking/x25-iface.txt
+ *
+ *	As this is an X.25 level 2 device you cau use it for user level =
drivers
+ *	even for building bridging tunnels (XOT).
+ *
+ *		August 1998, sfillod@charybde.gyptis.frmug.org
+ */
+=20
+#include <linux/config.h>
+#include <linux/module.h>
+
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+
+#include <linux/netdevice.h>
+#include <linux/inetdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/init.h>
+
+#include <net/sock.h>
+#include <linux/netlink.h>
+#include <linux/x25.h>
+#include <linux/if_arp.h>
+
+
+/*
+ *	Index to functions.
+ */
+
+int	    x25tap_probe(struct net_device *dev);
+static int  x25tap_open(struct net_device *dev);
+static int  x25tap_start_xmit(struct sk_buff *skb, struct net_device =
*dev);
+static int  x25tap_close(struct net_device *dev);
+static struct net_device_stats *x25tap_get_stats(struct net_device =
*dev);
+static void x25tap_rx(struct sock *sk, int len);
+
+/*
+ * x25tap_debug:
+ *	2: connexion state
+ *	3: function calls
+ *	4: tx/rx function calls
+ *	7: Dump
+ */
+static int x25tap_debug =3D 3;
+
+static struct net_device *tap_map[32];	/* Returns the tap device for a =
given netlink */
+
+/*
+ *	Board-specific info in dev->priv.
+ */
+
+struct net_local
+{
+	struct sock	*nl;
+	struct net_device_stats stats;
+};
+
+/*
+ *	To call this a probe is a bit misleading, however for real
+ *	hardware it would have to check what was present.
+ */
+=20
+int __init x25tap_probe(struct net_device *dev)
+{
+	SET_MODULE_OWNER (dev);
+
+	if (dev->mem_start & 0xf)
+		x25tap_debug =3D dev->mem_start & 0x7;
+
+	if (x25tap_debug > 2)
+		printk(KERN_DEBUG "%s: Doing x25tap_probe()...\n", dev->name);
+
+	/*
+	 *	Initialize the device structure.
+	 */
+
+	dev->priv =3D kmalloc(sizeof(struct net_local), GFP_KERNEL);
+	if (dev->priv =3D=3D NULL)
+		return -ENOMEM;
+	memset(dev->priv, 0, sizeof(struct net_local));
+
+	/*
+	 *	The tap specific entries in the device structure.
+	 */
+
+	dev->open =3D x25tap_open;
+	dev->hard_start_xmit =3D x25tap_start_xmit;
+	dev->stop =3D x25tap_close;
+	dev->get_stats =3D x25tap_get_stats;
+
+	/*
+	 *	Setup the generic properties
+	 */
+
+
+	dev->flags=3DIFF_NOARP;
+	tap_map[dev->base_addr]=3Ddev;
+
+	dev->mtu		=3D 1024;
+        dev->hard_header_len    =3D 1;
+        dev->addr_len           =3D 0;
+        dev->type               =3D ARPHRD_X25;
+        dev->tx_queue_len       =3D 10;
+
+        dev_init_buffers(dev);
+
+	return 0;
+}
+
+/*
+ *	Open/initialize the board.
+ */
+
+static int x25tap_open(struct net_device *dev)
+{
+	struct net_local *lp =3D (struct net_local*)dev->priv;
+
+	if (x25tap_debug > 2)
+		printk(KERN_DEBUG "%s: Doing x25tap_open()...\n", dev->name);
+
+	MOD_INC_USE_COUNT;
+
+	lp->nl =3D netlink_kernel_create(dev->base_addr, x25tap_rx);
+	if (lp->nl =3D=3D NULL) {
+		MOD_DEC_USE_COUNT;
+		return -ENOBUFS;
+	}
+
+	return 0;
+}
+
+
+/*
+ *	We transmit by throwing the packet at netlink. We have to clone
+ *	it for 2.0 so that we dev_kfree_skb() the locked original.
+ */
+=20
+static int x25tap_start_xmit(struct sk_buff *skb, struct net_device =
*dev)
+{
+	struct net_local *lp =3D (struct net_local *)dev->priv;
+	int len =3D skb->len;
+
+	if (x25tap_debug > 6)
+		printk(KERN_DEBUG "%s: x25tap_start_xmit() %#x, %d data bytes\n", =
dev->name, *skb->data, len-1);
+
+	/* Make the same thing, which loopback does. */
+	if (skb_shared(skb)) {
+	  	struct sk_buff *skb2 =3D skb;
+	  	skb =3D skb_clone(skb, GFP_ATOMIC);	/* Clone the buffer */
+	  	if (skb=3D=3DNULL) {
+			dev_kfree_skb(skb2);
+			lp->stats.tx_dropped++;
+			return 0;
+		}
+	  	dev_kfree_skb(skb2);
+	}
+	/* ... but do not orphan it here, netlink does it in any case. */
+
+        switch(skb->data[0])
+        {
+                case 0x00:                      /* data request */
+
+			lp->stats.tx_bytes+=3Dlen - 1;
+			lp->stats.tx_packets++;
+
+			break;
+
+                case 0x01: /* Connection request .. do nothing */
+			if (x25tap_debug > 1)
+	                        printk(KERN_DEBUG "x25tap_start_xmit: "
+					"Connection request\n");
+                        break;
+
+                case 0x02: /* Disconnect request */
+			if (x25tap_debug > 1)
+                        	printk(KERN_DEBUG "x25tap_start_xmit: "
+					"Disconnect request\n");
+                        break;
+
+                case 0x03: /* changing lapb parameters requested */
+                        printk(KERN_DEBUG "x25tap_start_xmit: setting =
of "
+                                "options not yet supported\n");
+                        break;
+
+                default:
+                        printk(KERN_DEBUG "x25tap_start_xmit: "
+				"unknown firstbyte\n");
+			return -1;
+                        break;
+        }
+
+	netlink_broadcast(lp->nl, skb, 0, ~0, GFP_ATOMIC);
+	return 0;
+}
+
+static __inline__ int x25tap_rx_skb(struct sk_buff *skb, struct =
net_device *dev)
+{
+	struct net_local *lp =3D (struct net_local *)dev->priv;
+	int len =3D skb->len;
+
+
+	if (len < 1) {
+		printk(KERN_DEBUG "%s : rx len =3D %d\n", dev->name, len);
+		kfree_skb(skb);
+		lp->stats.rx_errors++;
+		return -EINVAL;
+	}
+
+	if (NETLINK_CREDS(skb)->uid) {
+		printk(KERN_INFO "%s : user %d\n", dev->name, =
NETLINK_CREDS(skb)->uid);
+		kfree_skb(skb);
+		return -EPERM;
+	}
+
+
+	if (skb_shared(skb)) {
+	  	struct sk_buff *skb2 =3D skb;
+	  	skb =3D skb_clone(skb, GFP_KERNEL);	/* Clone the buffer */
+	  	if (skb=3D=3DNULL) {
+			kfree_skb(skb2);
+			lp->stats.rx_dropped++;
+			return -ENOBUFS;
+		}
+	  	kfree_skb(skb2);
+	} else
+		skb_orphan(skb);
+
+
+	if (x25tap_debug > 6)
+		printk(KERN_DEBUG "%s: x25tap_rx_skb() %#x, %d data bytes\n", =
dev->name, *skb->data, len-1);
+
+	skb->dev =3D dev;
+	skb->protocol=3Dhtons(ETH_P_X25);
+        skb->mac.raw  =3D skb->data;
+        skb->pkt_type =3D PACKET_HOST;
+	memset(skb->cb, 0, sizeof(skb->cb));
+
+	if (skb->data[0] =3D=3D 0) {
+		lp->stats.rx_packets++;
+		lp->stats.rx_bytes+=3Dlen - 1;
+	}
+
+	netif_rx(skb);
+
+	return len;
+}
+
+/*
+ *	The typical workload of the driver:
+ *	Handle the ether interface interrupts.
+ *
+ *	(In this case handle the packets posted from user space..)
+ */
+
+static void x25tap_rx(struct sock *sk, int len)
+{
+	struct net_device *dev =3D tap_map[sk->protocol];
+	struct sk_buff *skb;
+
+	if (dev=3D=3DNULL) {
+		printk(KERN_CRIT "x25tap: bad unit!\n");
+		skb_queue_purge(&sk->receive_queue);
+		return;
+	}
+
+	if (x25tap_debug > 3)
+		printk(KERN_DEBUG "%s: x25tap_rx()\n", dev->name);
+
+	while ((skb =3D skb_dequeue(&sk->receive_queue)) !=3D NULL)
+		x25tap_rx_skb(skb, dev);
+}
+
+static int x25tap_close(struct net_device *dev)
+{
+	struct net_local *lp =3D (struct net_local *)dev->priv;
+	struct sock *sk =3D lp->nl;
+
+	if (x25tap_debug > 2)
+		printk(KERN_DEBUG "%s: Shutting down.\n", dev->name);
+
+	if (sk) {
+		lp->nl =3D NULL;
+		sock_release(sk->socket);
+	}
+
+	MOD_DEC_USE_COUNT;
+	return 0;
+}
+
+static struct net_device_stats *x25tap_get_stats(struct net_device =
*dev)
+{
+	struct net_local *lp =3D (struct net_local *)dev->priv;
+	return &lp->stats;
+}
+
+#ifdef MODULE
+
+static int unit;
+MODULE_PARM(unit,"i");
+MODULE_AUTHOR("Stephane Fillod <sfillod@charybde.gyptis.frmug.org>");
+MODULE_DESCRIPTION("X.25 Tap driver");
+
+
+static struct net_device dev_x25tap =3D
+{
+	" ",
+	0, 0, 0, 0,
+	1, 5,
+	0, 0, 0, NULL, x25tap_probe
+};
+
+int init_module(void)
+{
+	dev_x25tap.base_addr=3Dunit+NETLINK_TAPBASE;
+	sprintf(dev_x25tap.name,"x25tap%d",unit);
+	if (dev_get(dev_x25tap.name))
+	{
+		printk(KERN_INFO "%s already loaded.\n", dev_x25tap.name);
+		return -EBUSY;
+	}
+	if (register_netdev(&dev_x25tap) !=3D 0)
+		return -EIO;
+	return 0;
+}
+
+void cleanup_module(void)
+{
+	tap_map[dev_x25tap.base_addr]=3DNULL;
+	unregister_netdev(&dev_x25tap);
+
+	/*
+	 *	Free up the private structure.
+	 */
+
+	kfree(dev_x25tap.priv);
+	dev_x25tap.priv =3D NULL;	/* gets re-allocated by x25tap_probe */
+}
+
+#endif /* MODULE */
=1A
------=_NextPart_000_002A_01C2D99E.FA51A4F0--

