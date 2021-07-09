From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/6] arm: crypto: rename 'mod_init' & 'mod_exit' functions to be module-specific
Date: Thu,  8 Jul 2021 19:17:42 -0700
Message-ID: <20210709021747.32737-2-rdunlap@infradead.org>
References: <20210709021747.32737-1-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=x7QZanWZcKkawjfPahmWtQD2CPePP3+4rcUNQHuRxpg=; b=aCy+v5kuB4XnuQBR5G1+fQlOpY
        5ZJUKHxtINpvFjnZ/rERZlQBy+HtbZIMDIM7J22BrwGuHhFuroar3uavBcj4znO85UxP1QepswOFp
        jj6xIvAeAD9IsF2KyjptvuS12OwjWvZK3AWPeo59u6tnsX52TQ9iSWGSOuy6wiGufWQ3Q0f7pVBA7
        6ofB3ZNozRi1GKHi1LqkAa4DsnZOW9MIBj5pGbjPZvxyaLwYZUelaYncZODhqi1bhN2VRALpNlFBo
        WkvXgNOw6a0HHq1+ZN5YAas5oGsmURC4x/lTu8KeoydKMQ+qrVN+wUaBAgbnLPwb4VM7itjCsLTjP
        9NNNS07g==;
In-Reply-To: <20210709021747.32737-1-rdunlap@infradead.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andres Salomon <dilinger@queued.net>, linux-geode@lists.infradead.org, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, Christian Gromm <christian.gromm@microchip.com>, Krzysztof Halasa <khc@pm.waw.pl>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org, wireguard@lists.zx2c4.com, patches@armlinux.org.uk

Rename module_init & module_exit functions that are named
"mod_init" and "mod_exit" so that they are unique in both the
System.map file and in initcall_debug output instead of showing
up as almost anonymous "mod_init".

This is helpful for debugging and in determining how long certain
module_init calls take to execute.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
Cc: patches@armlinux.org.uk
---
 arch/arm/crypto/curve25519-glue.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- linux-next-20210708.orig/arch/arm/crypto/curve25519-glue.c
+++ linux-next-20210708/arch/arm/crypto/curve25519-glue.c
@@ -112,7 +112,7 @@ static struct kpp_alg curve25519_alg = {
 	.max_size		= curve25519_max_size,
 };
 
-static int __init mod_init(void)
+static int __init arm_curve25519_init(void)
 {
 	if (elf_hwcap & HWCAP_NEON) {
 		static_branch_enable(&have_neon);
@@ -122,14 +122,14 @@ static int __init mod_init(void)
 	return 0;
 }
 
-static void __exit mod_exit(void)
+static void __exit arm_curve25519_exit(void)
 {
 	if (IS_REACHABLE(CONFIG_CRYPTO_KPP) && elf_hwcap & HWCAP_NEON)
 		crypto_unregister_kpp(&curve25519_alg);
 }
 
-module_init(mod_init);
-module_exit(mod_exit);
+module_init(arm_curve25519_init);
+module_exit(arm_curve25519_exit);
 
 MODULE_ALIAS_CRYPTO("curve25519");
 MODULE_ALIAS_CRYPTO("curve25519-neon");
