From: "Russell King (Oracle)" <linux@armlinux.org.uk>
Subject: Re: [PATCH 1/6] arm: crypto: rename 'mod_init' & 'mod_exit'
 functions to be module-specific
Date: Fri, 9 Jul 2021 10:59:02 +0100
Message-ID: <20210709095902.GY22278@shell.armlinux.org.uk>
References: <20210709021747.32737-1-rdunlap@infradead.org>
 <20210709021747.32737-2-rdunlap@infradead.org>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=GDAKEVAY6G2FkEMJUuqWlfJMGpOgImfNbDfdp8SNumE=; b=IMZi9QswDZgjH87rP0vZpPXoF
        hkkdXd5InlsEhhdJjWVgtPUSzH8uLG1mhs1nLgoJJGh1TJ/umARn53rRP2XFvZfTfrqhig93+SrEk
        pwSdP0aiFbhBENQhAM0rgOslCQM6GiVkJkdzxlHoZ6jeDm+YEKs6hQ2Ef45vT8MpHaoShG9hM6lEL
        2J4tVIIQoTMfyMszH1ymZ/IiUmcXyU8uMLVL3pza6vWQACxls3lgWLTjRQ5XiC6JP8UKk+/fQqkcJ
        mhiCWgutwI1MQY2qUSq115qrial/eLIyOqV2+P74Tsp8YNW7Dhz6reW2bby88gZoY5TMXrPrUv4ff
Content-Disposition: inline
In-Reply-To: <20210709021747.32737-2-rdunlap@infradead.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andres Salomon <dilinger@queued.net>, linux-geode@lists.infradead.org, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, Christian Gromm <christian.gromm@microchip.com>, Krzysztof Halasa <khc@pm.waw.pl>, netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Martin Schiller <ms@dev.tdt.de>, linux-x25@vger.kernel.org, wireguard@lists.zx2c4.com

On Thu, Jul 08, 2021 at 07:17:42PM -0700, Randy Dunlap wrote:
> Rename module_init & module_exit functions that are named
> "mod_init" and "mod_exit" so that they are unique in both the
> System.map file and in initcall_debug output instead of showing
> up as almost anonymous "mod_init".
> 
> This is helpful for debugging and in determining how long certain
> module_init calls take to execute.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: linux-arm-kernel@lists.infradead.org

Acked-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
