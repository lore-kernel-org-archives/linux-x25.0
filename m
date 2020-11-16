From: Martin Schiller <ms@dev.tdt.de>
Subject: [PATCH net-next v2 0/6] netdev event handling + neighbour config
Date: Mon, 16 Nov 2020 14:55:16 +0100
Message-ID: <20201116135522.21791-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <netdev-owner@vger.kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com
Cc: linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>

Martin Schiller (6):
  net/x25: handle additional netdev events
  net/x25: make neighbour params configurable
  net/x25: replace x25_kill_by_device with x25_kill_by_neigh
  net/x25: support NETDEV_CHANGE notifier
  net/lapb: support netdev events
  net/lapb: fix t1 timer handling

 include/net/x25.h        |  10 +-
 include/uapi/linux/x25.h |  56 ++++++-----
 net/lapb/lapb_iface.c    |  83 ++++++++++++++++
 net/lapb/lapb_timer.c    |  11 ++-
 net/x25/af_x25.c         | 206 +++++++++++++++++++++++++++++++--------
 net/x25/x25_facilities.c |   6 +-
 net/x25/x25_link.c       | 142 +++++++++++++++++++++++----
 net/x25/x25_subr.c       |  22 ++++-
 8 files changed, 445 insertions(+), 91 deletions(-)

--=20
2.20.1

