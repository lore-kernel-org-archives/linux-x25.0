From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 2/6] hw_random: rename 'mod_init' & 'mod_exit' functions to be module-specific
Date: Thu,  8 Jul 2021 19:17:43 -0700
Message-ID: <20210709021747.32737-3-rdunlap@infradead.org>
References: <20210709021747.32737-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-crypto-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=40ZPV4uKs4Eh17WHLdtGpeAt8oAMYvOs2ThKnI+bv2Y=; b=eFmyyVsKV19broZkVFVWQsgXTn
        a7o5gBfDmeRI4Srxe5A1OwGHo7VNPublIHMP+bkqPvPphNeTy5pnAnsy1Px9OhhUurHj34YTovufp
        wXvUjnd0tWrDp1yaIvPKX2HglBDd80V5VOYE97I5jiGM0VgSw/riezug7CZkb1/3EKmzhhWQhOnDL
        8c9ZpW8XC/cvYGmKtYpNNB5i7AvqYfHOy8h83rGXGEhY6NNWJcVd37VFgi5f1RckWuzLx7vsSTw8c
        b9luHEGboYiUem+Uc3wrKQT4KU+dXZh/IB1ZiiBwFKu7XjXEnceUsbJUJRR4t10+ha9yE5H887rFO
        W7a96aYw==;
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
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andres Salomon <dilinger@queued.net>
Cc: linux-geode@lists.infradead.org
Cc: Matt Mackall <mpm@selenic.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/hw_random/amd-rng.c   |    8 ++++----
 drivers/char/hw_random/geode-rng.c |    8 ++++----
 drivers/char/hw_random/intel-rng.c |    8 ++++----
 drivers/char/hw_random/via-rng.c   |    8 ++++----
 4 files changed, 16 insertions(+), 16 deletions(-)

--- linux-next-20210708.orig/drivers/char/hw_random/amd-rng.c
+++ linux-next-20210708/drivers/char/hw_random/amd-rng.c
@@ -124,7 +124,7 @@ static struct hwrng amd_rng = {
 	.read		= amd_rng_read,
 };
 
-static int __init mod_init(void)
+static int __init amd_rng_mod_init(void)
 {
 	int err;
 	struct pci_dev *pdev = NULL;
@@ -188,7 +188,7 @@ out:
 	return err;
 }
 
-static void __exit mod_exit(void)
+static void __exit amd_rng_mod_exit(void)
 {
 	struct amd768_priv *priv;
 
@@ -203,8 +203,8 @@ static void __exit mod_exit(void)
 	kfree(priv);
 }
 
-module_init(mod_init);
-module_exit(mod_exit);
+module_init(amd_rng_mod_init);
+module_exit(amd_rng_mod_exit);
 
 MODULE_AUTHOR("The Linux Kernel team");
 MODULE_DESCRIPTION("H/W RNG driver for AMD chipsets");
--- linux-next-20210708.orig/drivers/char/hw_random/geode-rng.c
+++ linux-next-20210708/drivers/char/hw_random/geode-rng.c
@@ -83,7 +83,7 @@ static struct hwrng geode_rng = {
 };
 
 
-static int __init mod_init(void)
+static int __init geode_rng_init(void)
 {
 	int err = -ENODEV;
 	struct pci_dev *pdev = NULL;
@@ -124,7 +124,7 @@ err_unmap:
 	goto out;
 }
 
-static void __exit mod_exit(void)
+static void __exit geode_rng_exit(void)
 {
 	void __iomem *mem = (void __iomem *)geode_rng.priv;
 
@@ -132,8 +132,8 @@ static void __exit mod_exit(void)
 	iounmap(mem);
 }
 
-module_init(mod_init);
-module_exit(mod_exit);
+module_init(geode_rng_init);
+module_exit(geode_rng_exit);
 
 MODULE_DESCRIPTION("H/W RNG driver for AMD Geode LX CPUs");
 MODULE_LICENSE("GPL");
--- linux-next-20210708.orig/drivers/char/hw_random/intel-rng.c
+++ linux-next-20210708/drivers/char/hw_random/intel-rng.c
@@ -325,7 +325,7 @@ PFX "RNG, try using the 'no_fwh_detect'
 }
 
 
-static int __init mod_init(void)
+static int __init intel_rng_mod_init(void)
 {
 	int err = -ENODEV;
 	int i;
@@ -403,7 +403,7 @@ out:
 
 }
 
-static void __exit mod_exit(void)
+static void __exit intel_rng_mod_exit(void)
 {
 	void __iomem *mem = (void __iomem *)intel_rng.priv;
 
@@ -411,8 +411,8 @@ static void __exit mod_exit(void)
 	iounmap(mem);
 }
 
-module_init(mod_init);
-module_exit(mod_exit);
+module_init(intel_rng_mod_init);
+module_exit(intel_rng_mod_exit);
 
 MODULE_DESCRIPTION("H/W RNG driver for Intel chipsets");
 MODULE_LICENSE("GPL");
--- linux-next-20210708.orig/drivers/char/hw_random/via-rng.c
+++ linux-next-20210708/drivers/char/hw_random/via-rng.c
@@ -192,7 +192,7 @@ static struct hwrng via_rng = {
 };
 
 
-static int __init mod_init(void)
+static int __init via_rng_mod_init(void)
 {
 	int err;
 
@@ -209,13 +209,13 @@ static int __init mod_init(void)
 out:
 	return err;
 }
-module_init(mod_init);
+module_init(via_rng_mod_init);
 
-static void __exit mod_exit(void)
+static void __exit via_rng_mod_exit(void)
 {
 	hwrng_unregister(&via_rng);
 }
-module_exit(mod_exit);
+module_exit(via_rng_mod_exit);
 
 static struct x86_cpu_id __maybe_unused via_rng_cpu_id[] = {
 	X86_MATCH_FEATURE(X86_FEATURE_XSTORE, NULL),
