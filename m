From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2/2] lapb-nl: Added driver
Date: Fri, 1 Jun 2012 14:52:01 +0100
Message-ID: <20120601145201.07a35cc3@pyramind.ukuu.org.uk>
References: <1338478278-24732-1-git-send-email-slapin@ossfans.org>
	<1338478278-24732-2-git-send-email-slapin@ossfans.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1338478278-24732-2-git-send-email-slapin@ossfans.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Sergey Lapin <slapin@ossfans.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

> +	  This driver allows UDP or NETLINK application to transfer data over
> +	  serial port using LAPB for delivery guarantee. This allows use LAPB
> +	  features without deploying full X.25 stack and use equipment, which
> +	  implements LAPB, but not X.25 framing, using custom protocol on top
> +	  of LAPB.

The netlink thing is a bit eccentric. I think I'd much rather see either
it using raw sockets or an AF_LAPB or similar (AF_X25, SOCK_RAW ?)

> +	dev_info(&sl->netdev->dev, "rx\n");

Debug wants to go before submission or be turned down !


> +int lapb_nl_ldisc_transmit(struct net_device *dev, u8 *data, size_t len)
> +{
> +	struct lapb_nl_ldisc *sl;
> +	int actual, count;
> +	BUG_ON(!dev);

How can that occur ?

> +	sl = get_lapb_data(dev);
> +	BUG_ON(!sl);
> +	spin_lock(&sl->lock);
> +	if (sl->tty == NULL) {
> +		spin_unlock(&sl->lock);
> +		dev_err(&dev->dev, "lapb: tbusy drop\n");

What stops this changing during the transmit call ? You probably want to
grab a kref and drop it when the ldisc is closed. That would also negate
this meaningless check


> +		return -ENOTTY;
> +	}
> +	count = lapb_esc(data, sl->xbuff, len);
> +
> +	/* Order of next two lines is *very* important.^S */
> +	set_bit(TTY_DO_WRITE_WAKEUP, &sl->tty->flags);
> +	actual = sl->tty->ops->write(sl->tty, sl->xbuff, count);
> +	dev_info(&sl->netdev->dev, "tx\n");

Again all the debug wants a tidy
> +
> +	print_hex_dump(KERN_INFO, "ldisc out:",
> +			DUMP_PREFIX_OFFSET, 16, 2, sl->xbuff,
> +			count, 0);
> +	sl->xleft = count - actual;
> +	sl->xhead = sl->xbuff + actual;
> +	/* VSV */
> +	clear_bit(SLF_OUTWAIT, &sl->flags);	/* reset outfill flag */

You seem to have copied this flag but not use it ?


> +int lapb_nl_ldisc_start(struct net_device *dev)
> +{
> +	struct lapb_nl_ldisc *sl;
> +	unsigned long len;
> +	BUG_ON(!dev);
> +	sl = get_lapb_data(dev);
> +	BUG_ON(!sl);
> +	if (sl->tty == NULL)
> +		return -ENODEV;

Again the sl->tty locking needs sorting (I think this may well be true of
slip and the others too)


> +static int lapb_ldisc_open(struct tty_struct *tty)
> +{
> +	struct net_device *netdev;
> +	struct lapb_nl_ldisc *sl;
> +	int ret;
> +	BUG_ON(!tty);

Can't happen

> +	sl = kzalloc(sizeof(struct lapb_nl_ldisc), GFP_KERNEL);

What if the allocation fails

> +	sl->tty = tty;

kref

> +	sl->netdev = netdev;
> +	sl->magic = LAPB_LDISC_MAGIC;
> +	tty->disc_data = sl;
> +	tty->receive_room = 65536;
> +	tty_driver_flush_buffer(tty);
> +	tty_ldisc_flush(tty);

Why flush ?


> +static int lapb_ldisc_ioctl(struct tty_struct *tty, struct file *file,
> +			    unsigned int cmd, unsigned long arg)
> +{
> +	struct lapb_nl_ldisc *sl = tty->disc_data;
> +	BUG_ON(!sl);
> +	dev_dbg(&sl->netdev->dev, "LAPB ldisc ioctl %04x\n", cmd);
> +
> +	/* First make sure we're connected. */
> +	if (!sl || sl->magic != LAPB_LDISC_MAGIC)
> +		return -EINVAL;

What locks this check ?

[Its safe because the tty mid layer has an ldisc ref of its own as far as
I can see but the check is still bogus and does nothing)

> +	if (!sl->netdev)
> +		return -EBUSY;
> +
> +	switch (cmd) {
> +	case SIOCGIFNAME:
> +		if (copy_to_user((void __user *)arg,
> +			(void *)(sl->netdev->name),
> +			strlen(sl->netdev->name) + 1))
> +				return -EFAULT;
> +		return 0;
> +
> +	default:
> +		return tty_mode_ioctl(tty, file, cmd, arg);
> +	}
> +}
> +
> +#ifdef CONFIG_COMPAT
> +static long lapb_ldisc_compat_ioctl(struct tty_struct *tty, struct file *file,
> +				    unsigned int cmd, unsigned long arg)
> +{
> +	switch (cmd) {
> +	case SIOCGX25PARMS:
> +	case SIOCSX25PARMS:
> +		return lapb_ldisc_ioctl(tty, file, cmd,
> +				       (unsigned long)compat_ptr(arg));

Which will in turn call the default so this seems surplus ?



The big question to me is the API for it all, which looks marginally
insane. Is there a URL to the userspace for this lot that might help
folks work out where your API is actually sensible or if not what it
ought to look like.

Alan
