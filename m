From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: X.25 network layer
Date: Tue, 07 Jul 2020 15:45:01 -0700 (PDT)
Message-ID: <20200707.154501.526542996364970721.davem@davemloft.net>
References: <20200706205030.21459-1-grandmaster@al2klimov.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200706205030.21459-1-grandmaster@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: grandmaster@al2klimov.de
Cc: andrew.hendry@gmail.com, kuba@kernel.org, mchehab+huawei@kernel.org, masahiroy@kernel.org, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Mon,  6 Jul 2020 22:50:30 +0200

> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
> 
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
> 
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>

Applied.
