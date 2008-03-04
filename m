From: =?iso-8859-1?Q?Jean-Ren=E9?= =?iso-8859-1?Q?_Peulv=E9?= 
	<jr.peulve@aatr.fr>
Subject: X25 RESET_REQUEST problem
Date: Tue, 04 Mar 2008 17:06:04 +0100
Message-ID: <20080304104725.095FB1C00096@mwinf2711.orange.fr>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-x25@vger.kernel.org

Hi All,

I have problem using the x25 linux stack (kernel version 2.6.17).
I believe that this is the case for all kernel versions.

Before sending RESET_REQUEST, the linux stack is calling x25_clear_queu=
es().
This clear all queues including the fragments already received.

When processing RESET_REQUEST in X25_STATE_3 the receiver is calling
x25_requeue_frames() which cause the unacknowledge packets to be retran=
smit.

The result is that different missbehaviors could occur:

1) packet being lost silently
2) user block fragmented in several packets can be presented at the oth=
er end
    whithout the beginning of the user block (1 or several packets lost=
 at the
    beginning)
3) virtual circuit in hung state because last packet without M bit is l=
ost
=2E..

Any help would be appreciated.
Jean-Rene Peulve
Les Tilleuls
Chemin de Vermill=E8re
84.160 Cadenet
=46rance
Tel:  33 (0)4.90.68.36.86
Email: jr.peulve@aatr.fr



