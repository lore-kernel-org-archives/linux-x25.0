From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: XOT
Date: Sat, 5 Oct 2002 19:32:52 -0300
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <20021005223252.GD8530@conectiva.com.br>
References: <004901c26be6$ed4e7fb0$28fdc350@defender> <001601c27525$dd7cd260$0100a8c0@HUGHES> <000901c26c96$622c4d80$28fdc350@defender>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000901c26c96$622c4d80$28fdc350@defender>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ian Cass <ian.cass@mblox.com>
Cc: John Hughes <john@Calva.COM>, linux-x25@vger.kernel.org

Em Sat, Oct 05, 2002 at 06:41:04PM +0100, Ian Cass escreveu:
> > I've not had time to look at the code; what's so hacky about it?
> 
> It's a userland driver using a ethertap like device. That sort of thing
> should really be integrated into the kernel. However, it does work, although
> not 100% reliably for me at the moment.

I've been thinking about working on this for a long time, as I have written
a driver for a serial sync card that has a X.25 stack in firmware and by
means of the wanrouter subsystem allows tcp to be carried over X.25, having
infra-structure to make one protocol work on top of other on a easy way is
something interesting to have, but I haven't looked at xotd, if I had perhaps
I'd be of the opinion that the current infrastructure could be easily used
to have a X.25 over TCP in the kernel.

- Arnaldo
