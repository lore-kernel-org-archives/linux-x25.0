From: Stephen Hemminger <shemminger@osdl.org>
Subject: Fw: Bad return code handling in net/x25/af_x25.c
Date: Fri, 13 Aug 2004 11:56:32 -0700
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <20040813115632.1aa7b450@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org

Mika found this before he left.

  CC [M]  net/x25/af_x25.o
net/x25/af_x25.c: In function `x25_sendmsg':
net/x25/af_x25.c:1056: warning: comparison of unsigned expression < 0 is
always false

x25_output() might actually return a negative error code, so this is a bug
that needs to be fixed.

--MiKu
