From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 075/130] net/lapb: fix t1 timer handling for LAPB_STATE_0
Date: Tue, 22 Dec 2020 21:17:18 -0500
Message-ID: <20201223021813.2791612-75-sashal@kernel.org>
References: <20201223021813.2791612-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608689990;
        bh=jLzGRxX7wGnjD1ePymmJU26q2mDCYyl+VD6tfsHXQjc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPnh9927eb9as6I0bsMe5BtEUdl2qfUJTqlJbzvmOcp59bSpgOz/5dZuZvmGnTUMS
         20SXakHuVGiN3s2tg7247ZxUKCLDcAW3SZJ0b8SPA/uOYkN1NDxrORK2j0oOp0aMZu
         892j7G0lkpz70g0ahtq0miNt9dFxzR5Rjt0x/kEdt6QR/wy9HejRFV7t40utQbSy0c
         b1utCs3USQn/itCAO0yilEWyGFpYCGuNLMqTAMDRbO+V2XfWUfBcKU6jD3fYlsaKsI
         2ljqgKk8mfWnSsfUKKGnoCLMsausLQg7ZWgDsP6A4qo4Q6A2YAB9f85vN5yg03FI00
         od+4WQyeclp/A==
In-Reply-To: <20201223021813.2791612-1-sashal@kernel.org>
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
index 8f5b17001a076..baa247fe4ed05 100644
--- a/net/lapb/lapb_timer.c
+++ b/net/lapb/lapb_timer.c
@@ -85,11 +85,18 @@ static void lapb_t1timer_expiry(struct timer_list *t)
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

