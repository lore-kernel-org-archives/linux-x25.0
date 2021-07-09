From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 4/6] MOST: cdev: rename 'mod_init' & 'mod_exit' functions to be module-specific
Date: Thu,  8 Jul 2021 19:17:45 -0700
Message-ID: <20210709021747.32737-5-rdunlap@infradead.org>
References: <20210709021747.32737-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=XLs0dU/umlmVJr2tRgK8KYmEUhW7ohG91bXIJa9Tj1M=; b=kjL+VIkF20my9OSTzm5HRHwwcY
        YfRI+owG6ttcXbSNtKLtAHGrPLJFPfAzQeyGZIbpgawdCuU9TFZeKVr4TtM8ucR4cMhg0zVBCw99y
        xp9wtWkH2hCzex5P5ASltXJpw4epf3W1EVUQh9fxhqsnGTsyGBHzb48OAmOljFAvlYj9XQgGgM3mr
        8mbrE+UYnVFnJVJfDpnCVOHUFz9Kgj+pyYwa2uVFpQw3iWifcv6ALqAczHj3eA7easVG0oVFMDmBK
        iej0Z0JaZl3VZmSYcoqREAcNjwU+ROjv8MDWzaBEW4piPwJst/JxlYoo1egSU29vAyvTK8W6OWJ2P
        QDj+GDkw==;
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
Cc: Christian Gromm <christian.gromm@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/most/most_cdev.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20210708.orig/drivers/most/most_cdev.c
+++ linux-next-20210708/drivers/most/most_cdev.c
@@ -486,7 +486,7 @@ static struct cdev_component comp = {
 	},
 };
 
-static int __init mod_init(void)
+static int __init most_cdev_init(void)
 {
 	int err;
 
@@ -518,7 +518,7 @@ dest_ida:
 	return err;
 }
 
-static void __exit mod_exit(void)
+static void __exit most_cdev_exit(void)
 {
 	struct comp_channel *c, *tmp;
 
@@ -534,8 +534,8 @@ static void __exit mod_exit(void)
 	class_destroy(comp.class);
 }
 
-module_init(mod_init);
-module_exit(mod_exit);
+module_init(most_cdev_init);
+module_exit(most_cdev_exit);
 MODULE_AUTHOR("Christian Gromm <christian.gromm@microchip.com>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("character device component for mostcore");
