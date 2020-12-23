From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 45/66] net/lapb: fix t1 timer handling for LAPB_STATE_0
Date: Tue, 22 Dec 2020 21:22:31 -0500
Message-ID: <20201223022253.2793452-45-sashal@kernel.org>
References: <20201223022253.2793452-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690229;
        bh=/c4YffwbuflVEpdaKVkVhdpanUfzt8myrSXK6LvF4OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YSVihZkZzyQWWNx6DK8R7U4lRJfAxXgtBk5ylUb/ANQBtaJRgFBfQvx5TCOVmgro1
         uqgIaxWLfHTg9vdkdBANPex/6sqRfyMFesWNATDyIazC1gqNDlmeKl00fTCOet2Ma0
         9DEO7xTgQtCGw7GEV9jkOow5lJkjCirJksZQT6bXLrX/WN4R86Mf356/1MYfby7BUO
         YePW4zK2HR6u+HTd0vNkR/V1uRoJGwF5hC4rAVSlcqjWUdp8a3Z8m0p4kX39pDEIQa
         Jl77AKddfKaUwhjYW7Qw6j3MaS0oI+jyGtULaAwa4B4plj4WFHYaXd7ouJYhLmBbxk
         qbi1UBQDsOYAw==
In-Reply-To: <20201223022253.2793452-1-sashal@kernel.org>
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
index 1a5535bc3b8d8..57882eb654c07 100644
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

