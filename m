From: Sergey Lapin <slapin@ossfans.org>
Subject: Re: [PATCH] Allow LAPB users know which data were actually sent.
Date: Thu, 17 Mar 2011 20:52:20 -0400
Message-ID: <20110318005220.GA9674@build.ihdev.net>
References: <1300400422-8820-1-git-send-email-slapin@ossfans.org>
 <20110317235532.44c0e202@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110317235532.44c0e202@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, Mar 17, 2011 at 11:55:32PM +0000, Alan Cox wrote:
> On Thu, 17 Mar 2011 18:20:22 -0400
> Sergey Lapin <slapin@ossfans.org> wrote:
> 
> > Normally, when LAPB is transport layer for X.25 protocol,
> > internal mechanics of X.25 knows wheather data were actually
> > received by peer. But for non-X.25 protocols which use LAPB
> > as data reliability layer, it is important to have some way
> > to know what was actually sent, so we add transmit indication.
> 
> Looks sensible but your patch doesn't add a user for it so what is it
> needed for ?

I implement accessor for special equipment (acessing fiscal information)
which uses custom protocol over LAPB. As it is being implemented,
I actually wanted to know if this approach for using LAPB is good enough
for mainline submission, as I want to have kernel part to be in mainline.
I think I will have the rest of patches ready within two weeks.

All the best,
S.
