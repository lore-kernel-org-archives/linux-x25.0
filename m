From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Allow LAPB users know which data were actually sent.
Date: Thu, 17 Mar 2011 23:55:32 +0000
Message-ID: <20110317235532.44c0e202@lxorguk.ukuu.org.uk>
References: <1300400422-8820-1-git-send-email-slapin@ossfans.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1300400422-8820-1-git-send-email-slapin@ossfans.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sergey Lapin <slapin@ossfans.org>
Cc: linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu, 17 Mar 2011 18:20:22 -0400
Sergey Lapin <slapin@ossfans.org> wrote:

> Normally, when LAPB is transport layer for X.25 protocol,
> internal mechanics of X.25 knows wheather data were actually
> received by peer. But for non-X.25 protocols which use LAPB
> as data reliability layer, it is important to have some way
> to know what was actually sent, so we add transmit indication.

Looks sensible but your patch doesn't add a user for it so what is it
needed for ?
