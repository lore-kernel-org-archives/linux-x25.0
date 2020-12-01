From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH net v2] net/x25: prevent a couple of overflows
Date: Tue, 1 Dec 2020 18:15:12 +0300
Message-ID: <X8ZeAKm8FnFpN//B@mwanda>
References: <ecf3321f20cc4f6dcf02b5b73105da58@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=FrOA1XUFmPKn8mKk+UnDtvZGiAQ6NVgplGG9s+uq6wU=;
 b=RV4iVKxim1xX5+cg5G9TC04TjU2egA+AW/3svD3xDSakxXrHwW9NWePfJjou7ivxwMZQ
 zC2A7FdPXWe5gKWkL8llp0LukPL3tEyAadOcJG/nDdnZxt6FWvZ8LbHOuYMa0ehQBEb9
 iD5cBqfDKVP0wGCVQU41n+YlaJCNy0VtAn5FbnLOMXKrKZ88VosqRPbB03k8UhM3Cs2R
 DfWjs54RatvoeAaQEvbxKcNZEiCPsauPNHRhCO6cPdr7WFv9v3s7b9jVSIT2uhT+rfOi
 kdvT6vgOtVW7z3AoQftch5HBDrGRvbhxqW6n9iaxfflcTmR2VG8J06iTgUDZqv3S/6mm jg== 
Content-Disposition: inline
In-Reply-To: <ecf3321f20cc4f6dcf02b5b73105da58@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, Andrew Hendry <andrew.hendry@gmail.com>, =?utf-8?B?a2l5aW4o5bC55LquKQ==?= <kiyin@tencent.com>, security@kernel.org, linux-distros@vs.openwall.org, =?utf-8?B?aHVudGNoZW4o6ZmI6ZizKQ==?= <huntchen@tencent.com>, =?utf-8?B?ZGFubnl3YW5nKOeOi+Wuhyk=?= <dannywang@tencent.com>, kernel-janitors@vger.kernel.org

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

Verify that the strings are NUL terminated and return -EINVAL if they
are not.

Reported-by: "kiyin(尹亮)" <kiyin@tencent.com>
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
The first patch put a NUL terminator on the end of the string and this
patch returns an error instead.  I don't have a strong preference, which
patch to go with.

 net/x25/af_x25.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 9232cdb42ad9..d41fffb2507b 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -675,7 +675,8 @@ static int x25_bind(struct socket *sock, struct sockaddr *uaddr, int addr_len)
 	int len, i, rc = 0;
 
 	if (addr_len != sizeof(struct sockaddr_x25) ||
-	    addr->sx25_family != AF_X25) {
+	    addr->sx25_family != AF_X25 ||
+	    strnlen(addr->sx25_addr.x25_addr, X25_ADDR_LEN) == X25_ADDR_LEN) {
 		rc = -EINVAL;
 		goto out;
 	}
@@ -769,7 +770,8 @@ static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
 
 	rc = -EINVAL;
 	if (addr_len != sizeof(struct sockaddr_x25) ||
-	    addr->sx25_family != AF_X25)
+	    addr->sx25_family != AF_X25 ||
+	    strnlen(addr->sx25_addr.x25_addr, X25_ADDR_LEN) == X25_ADDR_LEN)
 		goto out;
 
 	rc = -ENETUNREACH;
-- 
2.29.2
