From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH net] net/x25: prevent a couple of overflows
Date: Mon, 30 Nov 2020 13:04:25 +0300
Message-ID: <20201130100425.GB2789@kadam>
References: <61d3e7e75f704996bf312ef5d271bcea@tencent.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=89d0xM4SUH4a0fX74f4jEtNnPihawrq2u89AGEQ/K1I=;
 b=v3Cb2GUa5tO1ck9uZJVgTSfz+Rqgf8BbP8CWZySuiRS1/MNhwFWwNMtwQlb6BS0HJNpX
 ZojXTgzG2Fvtwb7uvXkg9ITVM0TglIFIXygOBQ1NyY1YoVigALg05yrXDCMyvbfG0wAG
 jOqphwIZGcajIQ39bHzyLoIvcq8boyKIl3UUA/ouDVTu0y7192w5r74TANPHlVZnQ3AL
 ET1ROYKM8FjYAvM9Kg2RmmZlLLYXmibim+fYLMlBx33AVDAJ91GP4Q0XdXRqqn0pyWzA
 Cx5stsAD6qWNtAKI/54XICGwfGBrlFS817x6+GJnGSdhnNyJoM2SyqMh+rWv2pvCu3Q5 VA== 
Content-Disposition: inline
In-Reply-To: <61d3e7e75f704996bf312ef5d271bcea@tencent.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Andrew Hendry <andrew.hendry@gmail.com>, =?utf-8?B?a2l5aW4o5bC55LquKQ==?= <kiyin@tencent.com>, Martin Schiller <ms@dev.tdt.de>
Cc: "security@kernel.org" <security@kernel.org>, "linux-distros@vs.openwall.org" <linux-distros@vs.openwall.org>, =?utf-8?B?aHVudGNoZW4o6ZmI6ZizKQ==?= <huntchen@tencent.com>, =?utf-8?B?ZGFubnl3YW5nKOeOi+Wuhyk=?= <dannywang@tencent.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org

From: "kiyin(尹亮)" <kiyin@tencent.com>

The .x25_addr[] address comes from the user and is not necessarily
NUL terminated.  This leads to a couple problems.  The first problem is
that the strlen() in x25_bind() can read beyond the end of the buffer.

The second problem is more subtle and could result in memory corruption.
The call tree is:
  x25_connect()
  --> x25_write_internal()
      --> x25_addr_aton()

The .x25_addr[] buffers are copied to the "addresses" buffer from
x25_write_internal() so it will lead to stack corruption.

The x25 protocol only allows 15 character addresses so putting a NUL
terminator as the 16th character is safe and obviously preferable to
reading out of bounds.

Signed-off-by: "kiyin(尹亮)" <kiyin@tencent.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---

 net/x25/af_x25.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 0bbb283f23c9..3180f15942fe 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -686,6 +686,8 @@ static int x25_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 		goto out;
 	}
 
+	addr->sx25_addr.x25_addr[X25_ADDR_LEN - 1] = '\0';
+
 	/* check for the null_x25_address */
 	if (strcmp(addr->sx25_addr.x25_addr, null_x25_address.x25_addr)) {
 
@@ -779,6 +781,7 @@ static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 
 	rc = -ENETUNREACH;
+	addr->sx25_addr.x25_addr[X25_ADDR_LEN - 1] = '\0';
 	rt = x25_get_route(&addr->sx25_addr);
 	if (!rt)
 		goto out;
-- 
2.28.0
