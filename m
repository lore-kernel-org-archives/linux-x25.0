From: "Ian Cass" <ian.cass@mblox.com>
Subject: Re: XOT
Date: Sat, 5 Oct 2002 18:41:04 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <000901c26c96$622c4d80$28fdc350@defender>
References: <004901c26be6$ed4e7fb0$28fdc350@defender> <001601c27525$dd7cd260$0100a8c0@HUGHES>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: John Hughes <john@Calva.COM>, linux-x25@vger.kernel.org

> I've not had time to look at the code; what's so hacky about it?

It's a userland driver using a ethertap like device. That sort of thing
should really be integrated into the kernel. However, it does work, although
not 100% reliably for me at the moment.

--
Ian Cass




