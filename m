From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 079/199] Documentation/networking/x25-iface.txt: Checkpatch cleanup
Date: Sun, 23 May 2010 21:56:33 +0200
Message-ID: <1274644605-25181-37-git-send-email-andrea.gelmini@gelma.net>
References: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=gjWtmouSBoiT5i/h3SLGjFmvwEuDlGFlsf1uPV2gTtI=;
        b=BcLy0Oi3sLBcSVQBg3H1SH7ZMO28vHUOB244R4+JUq1Q6RhbB4ZnPcBAG9LADmMKcd
         GRwWDEkSij2Wu5wAGvlSRp9YfxBIujhkcA+h1ntK9H5O5q39Qw9T4MKp90WWoURmxP3+
         +cLwyopV7Q7LKPMKi9xKsrqShxZyuZFoiZmy4=
In-Reply-To: <1274644605-25181-1-git-send-email-andrea.gelmini@gelma.net>
Sender: linux-doc-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andrea.gelmini@gelma.net
Cc: Andrew Hendry <andrew.hendry@gmail.com>, Randy Dunlap <rdunlap@xenotime.net>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, linux-doc@vger.kernel.org

Documentation/networking/x25-iface.txt:102: ERROR: trailing whitespace

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 Documentation/networking/x25-iface.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Documentation/networking/x25-iface.txt b/Documentation/networking/x25-iface.txt
index 975cc87..c1c5fe1 100644
--- a/Documentation/networking/x25-iface.txt
+++ b/Documentation/networking/x25-iface.txt
@@ -99,7 +99,7 @@ reduced by the following measures or a combination thereof:
 (1) Drivers for kernel versions 2.4.x and above should always check the
     return value of netif_rx(). If it returns NET_RX_DROP, the
     driver's LAPB protocol must not confirm reception of the frame
-    to the peer. 
+    to the peer.
     This will reliably suppress packet loss. The LAPB protocol will
     automatically cause the peer to re-transmit the dropped packet
     later.
-- 
1.7.1.251.gf80a2

