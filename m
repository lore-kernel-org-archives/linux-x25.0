From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next v7 0/5] net/x25: netdev event handling
Date: Fri, 27 Nov 2020 17:24:39 -0800
Message-ID: <20201127172439.1c5c73a3@kicinski-fedora-pc1c0hjn.DHCP.thefacebook.com>
References: <20201126063557.1283-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606526681;
        bh=JgqrGL8/UorpI7LvAq8W+1sAojiyvVrREeEuZFT14fw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZAqX/sBqi1R0zcXrG/cGib/dKN2yi31ki+lZdBIk+5iVZHmwtz4UQpgUVhPzcWnUM
         eaJBvoACG8oPphkDg6B2utmIQm6SwaOV/BT3dRun+3c+T8V2IKcXv5A6Civ+t941J5
         uqp3vc2zikhbDU59TUnrO662X4KeCaBAs/D56/tQ=
In-Reply-To: <20201126063557.1283-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: andrew.hendry@gmail.com, davem@davemloft.net, xie.he.0141@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 26 Nov 2020 07:35:52 +0100 Martin Schiller wrote:
> Changes to v6:
> o integrated some code styling suggestions by Jakub.
> 
> Changes to v5:
> o fix numbering in commit message of patch 2/5.
> 
> Changes to v4:
> o also establish layer2 (LAPB) on NETDEV_UP events, if the carrier is
>   already UP.
> 
> Changes to v3:
> o another complete rework of the patch-set to split event handling
>   for layer2 (LAPB) and layer3 (X.25)
> 
> Changes to v2:
> o restructure complete patch-set
> o keep netdev event handling in layer3 (X.25)
> o add patch to fix lapb_connect_request() for DCE
> o add patch to handle carrier loss correctly in lapb
> o drop patch for x25_neighbour param handling
>   this may need fixes/cleanup and will be resubmitted later.
> 
> Changes to v1:
> o fix 'subject_prefix' and 'checkpatch' warnings

Applied, thank you!
