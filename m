From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net v5] net: lapb: Add locking to the lapb module
Date: Mon, 25 Jan 2021 07:44:52 +0100
Message-ID: <4eed4c14ad7065c902c4de8f6d86b58e@dev.tdt.de>
References: <20210121002129.93754-1-xie.he.0141@gmail.com>
 <b42575d44fb7f5c1253635a19c3e21e2@dev.tdt.de>
 <20210123204507.35c895db@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20210123204507.35c895db@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xie He <xie.he.0141@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2021-01-24 05:45, Jakub Kicinski wrote:
> On Fri, 22 Jan 2021 10:07:05 +0100 Martin Schiller wrote:
>> On 2021-01-21 01:21, Xie He wrote:
>> > In the lapb module, the timers may run concurrently with other code in
>> > this module, and there is currently no locking to prevent the code from
>> > racing on "struct lapb_cb". This patch adds locking to prevent racing.
>> >
>> > 1. Add "spinlock_t lock" to "struct lapb_cb"; Add "spin_lock_bh" and
>> > "spin_unlock_bh" to APIs, timer functions and notifier functions.
>> >
>> > 2. Add "bool t1timer_stop, t2timer_stop" to "struct lapb_cb" to make us
>> > able to ask running timers to abort; Modify "lapb_stop_t1timer" and
>> > "lapb_stop_t2timer" to make them able to abort running timers;
>> > Modify "lapb_t2timer_expiry" and "lapb_t1timer_expiry" to make them
>> > abort after they are stopped by "lapb_stop_t1timer",
>> > "lapb_stop_t2timer",
>> > and "lapb_start_t1timer", "lapb_start_t2timer".
>> >
>> > 3. Let lapb_unregister wait for other API functions and running timers
>> > to stop.
>> >
>> > 4. The lapb_device_event function calls lapb_disconnect_request. In
>> > order to avoid trying to hold the lock twice, add a new function named
>> > "__lapb_disconnect_request" which assumes the lock is held, and make
>> > it called by lapb_disconnect_request and lapb_device_event.
>> >
>> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> > Cc: Martin Schiller <ms@dev.tdt.de>
>> > Signed-off-by: Xie He <xie.he.0141@gmail.com>
>> 
>> I don't have the opportunity to test this at the moment, but code 
>> looks
>> reasonable so far. Have you tested this at runtime?
> 
> Are you okay with this being merged or would you like to review
> further/test?
> 
> Nothing jumps out to me either (other than a few nit picks).

Adding a small delay in the while loop is a good idea.
Otherwise: Yes, I agree with merging this.

> 
>> > Change from v4:
>> > Make lapb_unregister wait for other refs to "lapb" to drop, to ensure
>> > that other LAPB API calls have all finished.
>> >
>> > Change from v3:
>> > In lapb_unregister make sure the self-restarting t1timer has really
>> > been
>> > stopped.
>> >
>> > Change from v2:
>> > Create a new __lapb_disconnect_request function to reduce redundant
>> > code.
>> >
>> > Change from v1:
>> > Broke long lines to keep the line lengths within 80 characters.
> 
>> > @@ -178,11 +182,23 @@ int lapb_unregister(struct net_device *dev)
>> >  		goto out;
>> >  	lapb_put(lapb);
>> >
>> > +	/* Wait for other refs to "lapb" to drop */
>> > +	while (refcount_read(&lapb->refcnt) > 2)
>> > +		;
> 
> Tight loop like this is a little scary, perhaps add a small
> usleep_range() here?
> 
>> > +
>> > +	spin_lock_bh(&lapb->lock);
>> > +
>> >  	lapb_stop_t1timer(lapb);
>> >  	lapb_stop_t2timer(lapb);
>> >
>> >  	lapb_clear_queues(lapb);
>> >
>> > +	spin_unlock_bh(&lapb->lock);
>> > +
>> > +	/* Wait for running timers to stop */
>> > +	del_timer_sync(&lapb->t1timer);
>> > +	del_timer_sync(&lapb->t2timer);
>> > +
>> >  	__lapb_remove_cb(lapb);
>> >
>> >  	lapb_put(lapb);
> 
>> > -int lapb_disconnect_request(struct net_device *dev)
>> > +static int __lapb_disconnect_request(struct lapb_cb *lapb)
>> >  {
>> > -	struct lapb_cb *lapb = lapb_devtostruct(dev);
>> > -	int rc = LAPB_BADTOKEN;
>> > -
>> > -	if (!lapb)
>> > -		goto out;
>> > -
>> >  	switch (lapb->state) {
>> >  	case LAPB_STATE_0:
>> > -		rc = LAPB_NOTCONNECTED;
>> > -		goto out_put;
>> > +		return LAPB_NOTCONNECTED;
>> >
>> >  	case LAPB_STATE_1:
>> >  		lapb_dbg(1, "(%p) S1 TX DISC(1)\n", lapb->dev);
>> > @@ -310,12 +328,10 @@ int lapb_disconnect_request(struct net_device
>> > *dev)
>> >  		lapb_send_control(lapb, LAPB_DISC, LAPB_POLLON, LAPB_COMMAND);
>> >  		lapb->state = LAPB_STATE_0;
>> >  		lapb_start_t1timer(lapb);
>> > -		rc = LAPB_NOTCONNECTED;
>> > -		goto out_put;
>> > +		return LAPB_NOTCONNECTED;
>> >
>> >  	case LAPB_STATE_2:
>> > -		rc = LAPB_OK;
>> > -		goto out_put;
>> > +		return LAPB_OK;
>> >  	}
>> >
>> >  	lapb_clear_queues(lapb);
>> > @@ -328,8 +344,22 @@ int lapb_disconnect_request(struct net_device
>> > *dev)
>> >  	lapb_dbg(1, "(%p) S3 DISC(1)\n", lapb->dev);
>> >  	lapb_dbg(0, "(%p) S3 -> S2\n", lapb->dev);
>> >
>> > -	rc = LAPB_OK;
>> > -out_put:
>> > +	return LAPB_OK;
>> > +}
> 
> Since this is a fix for net, I'd advise against converting the goto
> into direct returns (as much as I generally like such conversion).
