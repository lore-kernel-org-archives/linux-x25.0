From: Michael Flower <michael@windsurfwa.com>
Subject: [PATCH 2.6.11.7] x25: Call accept with call request CUD
Date: Sun, 10 Apr 2005 16:52:29 +1000
Message-ID: <1113115949.3438.9.camel@mcf>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: eis@baty.hanse.de, linux-x25@vger.kernel.org

I believe that I have found a bug in the X25 code in the kernel and have
attached a simple patch.

An incoming x25 connecton request with call user data (CUD) generates  a
call accept with a copy of the user data in the packet.

I do not believe that the X25 spec allows such a call accept
packet.

The problem arose using XOT from a linux box, through a cisco router
(doing the de-encapsulation) and forwarding to a telecom switch via X25.

When switch tried to connect to the Linux box the router encapsulated
the connection request into an XOT packet and sent it to the linux box.

The connection request had CUD.

The linux box (running xotd), de-encapsulated the packet, and routed it
to X25.

The X25 system sent a call accept packet back to the router
(XOT encapsulated) which had the original CUD inside the packet.

The router immediately barfed, and sent a clear request back
to the linux box and the switch.  The Cisco router complained
that the X25 call acknowledgement packet was too long in its debug log.

It seems reasonable that it did barf. I am not sure that sending the CUD
back with the connect accept packet makes sense, and the
only reference I can find on the X25 protocol doesn't allow for
CUD in call accept packets.

The fix is to remove the offending four lines of code in X25_utilities.c
that append the CUD to the call acknowledgement packet. It certainly
fixes the problems described above with cisco routers.

The XOT stuff, lately ported to 2.6 by Andrew Hendry
(ahendry@tusc.com.au) appears to be very useful in a telecoms arena.
There are some issues with x25 module useage counting, that I will 
fix ASAP. I hope that all this can then be integrated into future
kernels.

The patch

--- linux-2.6.11.7/net/x25/x25_subr.c	2005-04-08 04:57:26.000000000
+1000
+++ linux-2.6.11.7_new/net/x25/x25_subr.c	2005-04-08 17:46:32.591950835
+1000
@@ -203,10 +203,6 @@
 							x25->vc_facil_mask);
 			dptr    = skb_put(skb, len);
 			memcpy(dptr, facilities, len);
-			dptr = skb_put(skb,x25->calluserdata.cudlength);
-			memcpy(dptr, x25->calluserdata.cuddata,
-			       x25->calluserdata.cudlength);
-			x25->calluserdata.cudlength = 0;
 			break;
 
 		case X25_CLEAR_REQUEST:

Michael Flower

mcf-tech@windsurfwa.com


