From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH AUTOSEL 5.4 075/130] net/lapb: fix t1 timer handling for LAPB_STATE_0
Date: Wed, 23 Dec 2020 09:01:24 -0800
Message-ID: <20201223170124.5963-1-xie.he.0141@gmail.com>
References: <20201223021813.2791612-75-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7z156e/uKkv/pjjwPftIVvO966IjR1f5aiNFEZCH6Gw=;
        b=HY/yRb15PFKPXR0Iat2RACxzNCOVAMTaTi9CrstMyv/ItxD4KWO1sMmz+C8l0KWTIk
         rgEMxpRYvPXSBgWKMoZ4GdWafzxIN8J7Kgn7cqqCqDo7r/1lq9uNesBZRNRTp8Aqezne
         CpW7q2YMmRLoeUPLzZBryTx1h0OlLdI/wPz084BUykVMIy78KFmzbGZePNmY8jws1C2n
         mu+n7cVsYJgLqMtHATXCz94dhNoE+26pFabzfykwUDuNDYG/Qe6avhOirxQXMko02V1F
         6bgxBokSKG8uf7XsDQPsZ9LI8xDiBv3uzm6liiZy7fLZHbMND/ubMp6MTp4SMfCX+WTy
         CzbQ==
In-Reply-To: <20201223021813.2791612-75-sashal@kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, Martin Schiller <ms@dev.tdt.de>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org

> From: Martin Schiller <ms@dev.tdt.de>
>
> [ Upstream commit 62480b992ba3fb1d7260b11293aed9d6557831c7 ]
>
> 1. DTE interface changes immediately to LAPB_STATE_1 and start sending
>    SABM(E).
>
> 2. DCE interface sends N2-times DM and changes to LAPB_STATE_1
>    afterwards if there is no response in the meantime.

I don't think this patch is suitable for stable branches. This patch is
part of a patch series that changes the lapb module from "establishing the
L2 connection only when needed by L3", to "establishing the L2 connection
automatically whenever we are able to". This is a behavioral change. It
should be seen as a new feature. It is not a bug fix.

