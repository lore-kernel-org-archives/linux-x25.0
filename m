From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v6 0/5] net/x25: netdev event handling
Date: Tue, 24 Nov 2020 10:39:33 +0100
Message-ID: <20201124093938.22012-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-x25-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

---

Changes to v5:
o fix numbering in commit message of patch 2/5.

Changes to v4:
o also establish layer2 (LAPB) on NETDEV_UP events, if the carrier is
  already UP.

Changes to v3:
o another complete rework of the patch-set to split event handling
  for layer2 (LAPB) and layer3 (X.25)

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

Martin Schiller (5):
  net/x25: handle additional netdev events
  net/lapb: support netdev events
  net/lapb: fix t1 timer handling for LAPB_STATE_0
  net/x25: fix restart request/confirm handling
  net/x25: remove x25_kill_by_device()

 net/lapb/lapb_iface.c | 94 +++++++++++++++++++++++++++++++++++++++++++
 net/lapb/lapb_timer.c | 11 ++++-
 net/x25/af_x25.c      | 38 ++++++++---------
 net/x25/x25_link.c    | 47 +++++++++++++++++-----
 net/x25/x25_route.c   |  3 --
 5 files changed, 155 insertions(+), 38 deletions(-)

--=20
2.20.1

