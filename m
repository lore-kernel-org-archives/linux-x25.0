From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next v7 2/5] net/lapb: support netdev events
Date: Thu, 26 Nov 2020 11:03:03 -0800
Message-ID: <CAJht_EN-H0ZbKa4rcOg4riVnecTtfSqPakW-g+UCgun9cWbf_w@mail.gmail.com>
References: <20201126063557.1283-1-ms@dev.tdt.de> <20201126063557.1283-3-ms@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=P2L/YYCOnFeIb3+K5lIGoZyvHecSdK+D5x1TJ+KPjfw=;
        b=X19cg+dGU5l8JWl+QsiEVPoZ12oJ+W8FO8y7+XZlEIK/Bgwt8q8dCM6rmu30mqOr3M
         qvnmaC/aSVAYb29oJvW1CPmG1nbIvzig4t7ikJ4TeosfcaGJZCZBFDWWoCQ0H4jHmCmE
         0SSjQwYjkfpt2OGkUhxRFHGyaoBRXIFBsw9aH8ea45PIMsiOhgqX54p5rTOttTHV0Y/O
         XBQ8ulkyqxf1PwPImzVG4UgDbMfWCn504AXCSpaf6bkzR8zH+RKGySE5DGtlyvDauo6P
         1L34FN9sYSvAYvDGLYDpsn7RBZasplj1Qq1d5xyDWQ1c6x5qIq1IDop53xFihROZ3WJi
         aVrQ==
In-Reply-To: <20201126063557.1283-3-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Acked-by: Xie He <xie.he.0141@gmail.com>
