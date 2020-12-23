From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 29/38] net/lapb: fix t1 timer handling for LAPB_STATE_0
Date: Tue, 22 Dec 2020 21:25:07 -0500
Message-ID: <20201223022516.2794471-29-sashal@kernel.org>
References: <20201223022516.2794471-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690353;
        bh=qTIW01HslnQB8/7Do60W1UDScsQm6zVFr5VugLYSJ4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tZl8Hnlb+8zXAtmfCFvoZUFtT7FLfLdpJ9eP9mavIYDSSF3mPwUzLqw8DEV7EgKqH
         kmt3pogvZIj6jCN5uU0xAGtlYT1mfRBFdvBTpAs9q4UfkZXoqZUeqtdPmFpW996wdU
         U6/krs2HzDCKWfgM2tH67Yr1+zX8x3D1VeMiBi9Rn+51y3bHwWrfpXciOcKWpjp7R+
         d9KBHS4/XKnK8rl2OC0Vd7gd/0pGi7dd4x67GjlNwn9zcyrNqtZFX2g2rc1O5NIhs9
         FJHRqdmlJZb2yGI7gZdNT1LV3TxOZgmZ/XjTuWhOFFAld853edkwsq7c2Vb+2S/Jnb
         Jd4BYgv7Uuz2g==
In-Reply-To: <20201223022516.2794471-1-sashal@kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Martin Schiller <ms@dev.tdt.de>, Jakub Kicinski <kuba@kernel.org>, Sasha Levin <sashal@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>

[ Upstream commit 62480b992ba3fb1d7260b11293aed9d6557831c7 ]

1. DTE interface changes immediately to LAPB_STATE_1 and start sending
   SABM(E).

2. DCE interface sends N2-times DM and changes to LAPB_STATE_1
   afterwards if there is no response in the meantime.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/lapb/lapb_timer.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/lapb/lapb_timer.c b/net/lapb/lapb_timer.c
index 355cc3b6fa4d3..3d99205f003da 100644
--- a/net/lapb/lapb_timer.c
+++ b/net/lapb/lapb_timer.c
@@ -92,11 +92,18 @@ static void lapb_t1timer_expiry(unsigned long param)
 	switch (lapb->state) {
 
 		/*
-		 *	If we are a DCE, keep going DM .. DM .. DM
+		 *	If we are a DCE, send DM up to N2 times, then switch to
+		 *	STATE_1 and send SABM(E).
 		 */
 		case LAPB_STATE_0:
-			if (lapb->mode & LAPB_DCE)
+			if (lapb->mode & LAPB_DCE &&
+			    lapb->n2count != lapb->n2) {
+				lapb->n2count++;
 				lapb_send_control(lapb, LAPB_DM, LAPB_POLLOFF, LAPB_RESPONSE);
+			} else {
+				lapb->state = LAPB_STATE_1;
+				lapb_establish_data_link(lapb);
+			}
 			break;
 
 		/*
-- 
2.27.0

