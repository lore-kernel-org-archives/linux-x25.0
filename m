From: Ozgur <ozgurk@ieee.org>
Subject: Re: [PATCH] x25: remove redundant pointer dev
Date: Mon, 9 May 2022 20:48:39 +0400
Message-ID: <CAADfD8zwoGUw4aJ8ebz9sLYyZSGp8Au6y5QvpFPvV9Rc4HY_Aw@mail.gmail.com>
References: <20220508214500.60446-1-colin.i.king@gmail.com>
 <CAADfD8wApw_v+uDTijY1K89WRJ_f7tkHmz=6LR086yMjEU4mWQ@mail.gmail.com> <20220509124427.GG4009@kadam>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5g8PMEr0fUha/SOThrUTETc1ItXC2lJPUN9/NQxWRVg=;
        b=MTLQyColdjkZgneoiO2JCqBMXtCiy+AfIci1x5bN8m/pMI1K+N6mWUuJqIXJO485zB
         ckPvI6zubY6h6FFL90K0wOdEgJ+OYvs71xh7lZMNbvmpa+88N3wAmAbTRa7164xC4Wpn
         kPadB+F+/aVDf+cfcn3fiXl+O/FKqeSw7T34E=
In-Reply-To: <20220509124427.GG4009@kadam>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Colin Ian King <colin.i.king@gmail.com>, Martin Schiller <ms@dev.tdt.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Mon, May 9, 2022 at 4:44 PM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Mon, May 09, 2022 at 04:57:40AM +0400, Ozgur wrote:
> > On Mon, May 9, 2022 at 1:45 AM Colin Ian King <colin.i.king@gmail.com> wrote:
> > >
> > > Pointer dev is being assigned a value that is never used, the assignment
> > > and the variable are redundant and can be removed. Also replace null check
> > > with the preferred !ptr idiom.
> > >
> >
> > Hello,
> >
> > *dev pointer is device assign global linked list and shouldnt be
> > touched by the driver so *dev wont get any value right?
>
> Why are you talking about "*dev" instead of "dev"?
>

Hi Dan,
I just realized this, i thought dev was necessary for launch functions
device and to activate.
if carries this with x25, dev is useless I understand.

> > Also seems to use this while network interface is initializing because
> > some activation information and stats information is also kept here,
> > for example, open *dev will call when ifconfig is called from.
> >
> > route, link, forward these inital activate and move all values with
> > net_device *dev?
>
> It's not clear what you are saying...
>
> When I review these kinds of patches I ask:
> 1) Does Colin's patch change run time behavior?  Obviosly not.
> 2) Is the current code buggy?  Sometimes when there is a static checker
>    warning it indicates a typo in the code.  I do not see a bug in the
>    original code before Colin's patch.
> 3) What was the author's original intent?  This code predates git but
>    I think the "dev" was just a going to be a shorter name to type than
>    "x25->neighbour->dev".

Actually i thought similarly because when this patch remove dev from i
thought would depend on
other source code whose x25 interface will be implemented are not ready.

I thought any x25 interface or x25route was using it.

> I honestly have no idea what you are saying.  At first I thought you
> might be saying that this is stub code.  But that seems wrong.  Also we
> do not allow stub code in the kernel.

thanks for enlightening,

Regards

> regards,
> dan carpenter
>


-- 
Ozgur Kara
Linux Kernel Developer

ozgurk@ieee.org
