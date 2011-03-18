From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Allow LAPB users know which data were actually sent.
Date: Fri, 18 Mar 2011 11:34:33 +0000
Message-ID: <20110318113433.39794ca5@lxorguk.ukuu.org.uk>
References: <1300400422-8820-1-git-send-email-slapin@ossfans.org>
	<20110317235532.44c0e202@lxorguk.ukuu.org.uk>
	<20110318005220.GA9674@build.ihdev.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110318005220.GA9674@build.ihdev.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sergey Lapin <slapin@ossfans.org>
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org

> > Looks sensible but your patch doesn't add a user for it so what is it
> > needed for ?
> 
> I implement accessor for special equipment (acessing fiscal information)
> which uses custom protocol over LAPB. As it is being implemented,
> I actually wanted to know if this approach for using LAPB is good enough
> for mainline submission, as I want to have kernel part to be in mainline.
> I think I will have the rest of patches ready within two weeks.

It seems sensible as an implementation to me so I would carry on using
that model and then submit it with all the other bits when you are ready.
