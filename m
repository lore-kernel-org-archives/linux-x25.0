From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v5 2/5] net/lapb: support netdev events
Date: Tue, 24 Nov 2020 10:35:35 +0100
Message-ID: <20201124093538.21177-3-ms@dev.tdt.de>
References: <20201124093538.21177-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20201124093538.21177-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

This patch allows layer2 (LAPB) to react to netdev events itself and
avoids the detour via layer3 (X.25).

1. Establish layer2 on NETDEV_UP events, if the carrier is already up.

2. Call lapb_disconnect_request() on NETDEV_GOING_DOWN events to signal
   the peer that the connection will go down.
   (Only when the carrier is up.)

2. When a NETDEV_DOWN event occur, clear all queues, enter state
   LAPB_STATE_0 and stop all timers.

3. The NETDEV_CHANGE event makes it possible to handle carrier loss and
   detection.

   In case of Carrier Loss, clear all queues, enter state LAPB_STATE_0
   and stop all timers.

   In case of Carrier Detection, we start timer t1 on a DCE interface,
   and on a DTE interface we change to state LAPB_STATE_1 and start
   sending SABM(E).

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
---
 net/lapb/lapb_iface.c | 94 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index 3c03f6512c5f..f226d354aaf0 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -418,14 +418,108 @@ int lapb_data_transmit(struct lapb_cb *lapb, struc=
t sk_buff *skb)
 	return used;
 }
=20
+/* Handle device status changes. */
+static int lapb_device_event(struct notifier_block *this, unsigned long =
event,
+			     void *ptr)
+{
+	struct net_device *dev =3D netdev_notifier_info_to_dev(ptr);
+	struct lapb_cb *lapb;
+
+	if (!net_eq(dev_net(dev), &init_net))
+		return NOTIFY_DONE;
+
+	if (dev->type =3D=3D ARPHRD_X25) {
+		switch (event) {
+		case NETDEV_UP:
+			lapb_dbg(0, "(%p) Interface up: %s\n", dev,
+				 dev->name);
+
+			if (netif_carrier_ok(dev)) {
+				lapb =3D lapb_devtostruct(dev);
+				if (!lapb)
+					break;
+
+				lapb_dbg(0, "(%p): Carrier is already up: %s\n",
+					 dev, dev->name);
+				if (lapb->mode & LAPB_DCE) {
+					lapb_start_t1timer(lapb);
+				} else {
+					if (lapb->state =3D=3D LAPB_STATE_0) {
+						lapb->state =3D LAPB_STATE_1;
+						lapb_establish_data_link(lapb);
+					}
+				}
+			}
+			break;
+		case NETDEV_GOING_DOWN:
+			if (netif_carrier_ok(dev))
+				lapb_disconnect_request(dev);
+			break;
+		case NETDEV_DOWN:
+			lapb =3D lapb_devtostruct(dev);
+			if (!lapb)
+				break;
+
+			lapb_dbg(0, "(%p) Interface down: %s\n", dev,
+				 dev->name);
+			lapb_dbg(0, "(%p) S%d -> S0\n", dev,
+				 lapb->state);
+			lapb_clear_queues(lapb);
+			lapb->state =3D LAPB_STATE_0;
+			lapb->n2count   =3D 0;
+			lapb_stop_t1timer(lapb);
+			lapb_stop_t2timer(lapb);
+			break;
+		case NETDEV_CHANGE:
+			lapb =3D lapb_devtostruct(dev);
+			if (!lapb)
+				break;
+
+			if (netif_carrier_ok(dev)) {
+				lapb_dbg(0, "(%p): Carrier detected: %s\n",
+					 dev, dev->name);
+				if (lapb->mode & LAPB_DCE) {
+					lapb_start_t1timer(lapb);
+				} else {
+					if (lapb->state =3D=3D LAPB_STATE_0) {
+						lapb->state =3D LAPB_STATE_1;
+						lapb_establish_data_link(lapb);
+					}
+				}
+			} else {
+				lapb_dbg(0, "(%p) Carrier lost: %s\n", dev,
+					 dev->name);
+				lapb_dbg(0, "(%p) S%d -> S0\n", dev,
+					 lapb->state);
+				lapb_clear_queues(lapb);
+				lapb->state =3D LAPB_STATE_0;
+				lapb->n2count   =3D 0;
+				lapb_stop_t1timer(lapb);
+				lapb_stop_t2timer(lapb);
+			}
+			break;
+		}
+	}
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block lapb_dev_notifier =3D {
+	.notifier_call =3D lapb_device_event,
+};
+
 static int __init lapb_init(void)
 {
+	register_netdevice_notifier(&lapb_dev_notifier);
+
 	return 0;
 }
=20
 static void __exit lapb_exit(void)
 {
 	WARN_ON(!list_empty(&lapb_list));
+
+	unregister_netdevice_notifier(&lapb_dev_notifier);
 }
=20
 MODULE_AUTHOR("Jonathan Naylor <g4klx@g4klx.demon.co.uk>");
--=20
2.20.1

