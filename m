From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] x25: remove redundant pointer dev
Date: Mon, 9 May 2022 15:44:27 +0300
Message-ID: <20220509124427.GG4009@kadam>
References: <20220508214500.60446-1-colin.i.king@gmail.com>
 <CAADfD8wApw_v+uDTijY1K89WRJ_f7tkHmz=6LR086yMjEU4mWQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <kernel-janitors-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=oc4oCQXzY/2Mv6UbQ2zKcAG5jEiOjf0uCDHAf8bARis=;
 b=QDpZkN6k7Rg5D9wUHCgMslOvGI9ETDnTyjoFrjwefVAqIu82pZL5FMtaDOPvoICJ0q/x
 bg5bqvBW74mxkvIJKAi2Z2MnPuSdhzmNzhvSS29fDkHmTrAdXAjoa9GwpPrI75c6Ekiu
 dLf87RfspNECLT3Rb4hsoJLVsUrY/LKcl7pgGnieS6tSxdHtggYPho8QuZYpI7thuVqp
 gbCEIWIOnfxLpNw80xSnw4QAQxwfhsMr7g3eIQE2xcbukg+tl5jxChYKVWUzXXWLvS+d
 FRuwnWZ0BxIhlNFRAXAlunEXbiT7ASzmkvHBpOYaMBoDaeI9OicGH31+5ApQ7yFXjJWF SA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oc4oCQXzY/2Mv6UbQ2zKcAG5jEiOjf0uCDHAf8bARis=;
 b=rSJvLdGXXpTx5/OldoYS2z4QCZXTtrcM5+pOHdAKXpdmIf649sBSiHRj2Kwp1xkVoeUOXRwCrxwGoR/1h023IyqC4fyCbBxZeYEXEuFtmLV+jSi43NpiE0YC+YH6FOUutFQQC0+cQK/rjCgiGR+bZlz5d0/86a9Q4udwGEbyZQA=
Content-Disposition: inline
In-Reply-To: <CAADfD8wApw_v+uDTijY1K89WRJ_f7tkHmz=6LR086yMjEU4mWQ@mail.gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ozgur <ozgurk@ieee.org>
Cc: Colin Ian King <colin.i.king@gmail.com>, Martin Schiller <ms@dev.tdt.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Mon, May 09, 2022 at 04:57:40AM +0400, Ozgur wrote:
> On Mon, May 9, 2022 at 1:45 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> >
> > Pointer dev is being assigned a value that is never used, the assignment
> > and the variable are redundant and can be removed. Also replace null check
> > with the preferred !ptr idiom.
> >
> 
> Hello,
> 
> *dev pointer is device assign global linked list and shouldnt be
> touched by the driver so *dev wont get any value right?

Why are you talking about "*dev" instead of "dev"?

> Also seems to use this while network interface is initializing because
> some activation information and stats information is also kept here,
> for example, open *dev will call when ifconfig is called from.
> 
> route, link, forward these inital activate and move all values with
> net_device *dev?

It's not clear what you are saying...

When I review these kinds of patches I ask:
1) Does Colin's patch change run time behavior?  Obviosly not.
2) Is the current code buggy?  Sometimes when there is a static checker
   warning it indicates a typo in the code.  I do not see a bug in the
   original code before Colin's patch.
3) What was the author's original intent?  This code predates git but
   I think the "dev" was just a going to be a shorter name to type than
   "x25->neighbour->dev".

I honestly have no idea what you are saying.  At first I thought you
might be saying that this is stub code.  But that seems wrong.  Also we
do not allow stub code in the kernel.

regards,
dan carpenter

