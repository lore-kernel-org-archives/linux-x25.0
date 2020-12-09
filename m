From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v7 4/5] net/x25: fix restart request/confirm handling
Date: Wed, 9 Dec 2020 01:47:16 -0800
Message-ID: <CAJht_ENOhnS7A6997CAP5qhn10NMYSVD3xOxcbPGQFLGb8z_Sg@mail.gmail.com>
References: <20201126063557.1283-1-ms@dev.tdt.de> <20201126063557.1283-5-ms@dev.tdt.de>
 <CAJht_EMZqcPdE5n3Vp+jJa1sVk9+vbwd-Gbi8Xqy19bEdbNNuA@mail.gmail.com>
 <CAJht_ENukJrnh6m8FLrHBwnKKyZpzk6uGWhS4_eUCyDzrCG3eA@mail.gmail.com> <3e314d2786857cbd5aaee8b83a0e6daa@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b4A649US2RSjSG56Wpb3xGYDuFzhFS6kVon+ebN8Xnw=;
        b=dr6evVSuCSSujnXd69aFKGCFoZKyB8grToLAabFTKI8pxrk9OaRujwctoy0rv8fcAF
         c8WuOKZYh7EqArO07lXp49Aj3qPrs+biAo8YEwxD3sA8Gb5q1/b4jCkvv7zcRkAb2vyW
         xZtLOmst5oUXbx3cPMBTAFH9My6uH8LSjaZWmLT2LvrG35Zz7gPKtCnx3WT+ZsblI/ly
         v8SIetipSMLRStjoOGjT3uZJjj0QErxtzrhWWQ16ZJ1ulqeQpUvXvtquxenSzjjKWUPw
         I8+K0rwOPHvPE6h2eYdNaWlEUdo2rC7L7qMUWW0NwOsosrQeBofKPaM30rHEvZZc/qjm
         HVzQ==
In-Reply-To: <3e314d2786857cbd5aaee8b83a0e6daa@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Wed, Dec 9, 2020 at 1:41 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> Right.
> By the way: A "Restart Collision" is in practice a very common event to
> establish the Layer 3.

Oh, I see. Thanks!
