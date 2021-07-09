From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 6/6] net: wireguard: rename 'mod_init' & 'mod_exit' functions to be module-specific
Date: Thu,  8 Jul 2021 19:17:47 -0700
Message-ID: <20210709021747.32737-7-rdunlap@infradead.org>
References: <20210709021747.32737-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Ep9SfC7/Ynwl3BgyBMLme/h0/tBd0UyBTX7M2kcAoJE=; b=Sx7g5Hj1ylzSFnfbdHGFcWdsY5
        kkmBqvIvhGUCBg+k+HGby30LlED/ptI7tKMQi8WgkwAz2CZnxCRxOilTaM8WIOVTiXswWg5oc7MUu
        DMVjnptiCY+FU23LQit80+jAf5UIY73/1XvaC1wwQodLoDHPGTGldi40lZ9Su0DjUrjp9sYHcGGT2
        cV5ffQJbTcR+ioERVCiV93HeoHLHzVG0nbcZWH0tlIMn6yeZYFGDlsbS4HGb18agPO/IfZb0fI9wo
        cnNKIgn0PAfOHPX+4T9FGeCoh5HGtassgxW7VSLUTMfBtqGB1YV+bqKgA3JcKWScwvdmWDGhkR5Jq
        tpTUonVQ==;
In-Reply-To: <20210709021747.32737-1-rdunlap@infradead.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andres Salomon <dilinger@queued.net>, linux-geode@lists.infradead.org, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, Christian Gromm <christian.gromm@microchip.com>, Krzysztof Halasa <khc@pm.waw.pl>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org, wireguard@lists.zx2c4.com

Rename module_init & module_exit functions that are named
"mod_init" and "mod_exit" so that they are unique in both the
System.map file and in initcall_debug output instead of showing
up as almost anonymous "mod_init".

This is helpful for debugging and in determining how long certain
module_init calls take to execute.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: wireguard@lists.zx2c4.com
Cc: netdev@vger.kernel.org
---
 drivers/net/wireguard/main.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20210708.orig/drivers/net/wireguard/main.c
+++ linux-next-20210708/drivers/net/wireguard/main.c
@@ -17,7 +17,7 @@
 #include <linux/genetlink.h>
 #include <net/rtnetlink.h>
 
-static int __init mod_init(void)
+static int __init wireguard_init(void)
 {
 	int ret;
 
@@ -60,7 +60,7 @@ err_allowedips:
 	return ret;
 }
 
-static void __exit mod_exit(void)
+static void __exit wireguard_exit(void)
 {
 	wg_genetlink_uninit();
 	wg_device_uninit();
@@ -68,8 +68,8 @@ static void __exit mod_exit(void)
 	wg_allowedips_slab_uninit();
 }
 
-module_init(mod_init);
-module_exit(mod_exit);
+module_init(wireguard_init);
+module_exit(wireguard_exit);
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("WireGuard secure network tunnel");
 MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
