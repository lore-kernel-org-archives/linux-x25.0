From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v3 0/6] net/x25: netdev event handling
Date: Wed, 18 Nov 2020 14:59:13 +0100
Message-ID: <20201118135919.1447-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-x25-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

---
Changes to v2:
o restructure complete patch-set
o keep netdev event handling in layer3 (X.25)
o add patch to fix lapb_connect_request() for DCE
o add patch to handle carrier loss correctly in lapb
o drop patch for x25_neighbour param handling
  this may need fixes/cleanup and will be resubmitted later.

Changes to v1:
o fix 'subject_prefix' and 'checkpatch' warnings

---

Martin Schiller (6):
  net/x25: handle additional netdev events
  net/lapb: fix lapb_connect_request() for DCE
  net/lapb: handle carrier loss correctly
  net/lapb: fix t1 timer handling for DCE
  net/x25: fix restart request/confirm handling
  net/x25: remove x25_kill_by_device()

 include/net/x25.h     |  2 +
 net/lapb/lapb_iface.c | 22 +++++++++--
 net/lapb/lapb_timer.c | 11 +++++-
 net/x25/af_x25.c      | 66 +++++++++++++++++++++++--------
 net/x25/x25_link.c    | 90 ++++++++++++++++++++++++++++++++++++-------
 net/x25/x25_route.c   |  3 --
 6 files changed, 155 insertions(+), 39 deletions(-)

--=20
2.20.1

