From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: PVCs on X.25?
Date: Wed, 18 Dec 2002 17:51:30 -0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <20021218195130.GD12334@conectiva.com.br>
References: <008a01c29f7e$4d02ccc0$f70127d5@britannic> <3E00C88D.3040906@inf.ufrgs.br>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3E00C88D.3040906@inf.ufrgs.br>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ricardo Dias Cassali <cassali@inf.ufrgs.br>
Cc: linux-x25@vger.kernel.org

Em Wed, Dec 18, 2002 at 05:12:13PM -0200, Ricardo Dias Cassali escreveu:
> Hi,
> I'm using the Generic HDLC layer, with X.25 protocol support enabled, 
> and my intention is to run IP over X.25.
> Is there a way to configure PVCs in this case?

Not that I'm aware, only setup I know that allows IP over X.25 on Linux is
using Cyclades Cyclom 2X board with the driver I wrote several years ago
and is present in the kernel.

- Arnaldo
