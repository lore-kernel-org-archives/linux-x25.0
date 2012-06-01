From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 1/2] LAPB: added 'delivered' interface
Date: Fri, 1 Jun 2012 13:28:37 +0100
Message-ID: <20120601132837.196f1ff6@pyramind.ukuu.org.uk>
References: <1338478278-24732-1-git-send-email-slapin@ossfans.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338478278-24732-1-git-send-email-slapin@ossfans.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sergey Lapin <slapin@ossfans.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

On Thu, 31 May 2012 11:31:17 -0400
Sergey Lapin <slapin@ossfans.org> wrote:

> When using LAPB API for non-X.25 work, it is often necessary
> to know if/when data is delivered to third party using LAPB
> interface (e.g over serial or other media).

Seems reasonable to me
