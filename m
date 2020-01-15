From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v2 1/2] wan/hdlc_x25: make lapb params configurable
Date: Wed, 15 Jan 2020 13:43:39 -0800 (PST)
Message-ID: <20200115.134339.199447041886048873.davem@davemloft.net>
References: <20200114140223.22446-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200114140223.22446-1-ms@dev.tdt.de>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: ms@dev.tdt.de
Cc: kubakici@wp.pl, khc@pm.waw.pl, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

From: Martin Schiller <ms@dev.tdt.de>
Date: Tue, 14 Jan 2020 15:02:22 +0100

> This enables you to configure mode (DTE/DCE), Modulo, Window, T1, T2, N2 via
> sethdlc (which needs to be patched as well).
> 
> Signed-off-by: Martin Schiller <ms@dev.tdt.de>

I don't know how wise it is to add new ioctls to this old driver.

Also, none of these ioctls even have COMPAT handling so they will
never work from a 32-bit binary running on a 64-bit kernel for
example.

Also:

> +static struct x25_state* state(hdlc_device *hdlc)

It is always "type *func" never "type* func"

>  static int x25_open(struct net_device *dev)
>  {
>  	int result;
> +	hdlc_device *hdlc = dev_to_hdlc(dev);
> +	struct lapb_parms_struct params;
>  	static const struct lapb_register_struct cb = {

Please make this reverse christmas tree ordered.

> @@ -186,6 +217,9 @@ static struct hdlc_proto proto = {
>  
>  static int x25_ioctl(struct net_device *dev, struct ifreq *ifr)
>  {
> +	x25_hdlc_proto __user *x25_s = ifr->ifr_settings.ifs_ifsu.x25;
> +	const size_t size = sizeof(x25_hdlc_proto);
> +	x25_hdlc_proto new_settings;
>  	hdlc_device *hdlc = dev_to_hdlc(dev);
>  	int result;

Likewise.
