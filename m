From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH net-next v5 3/5] net/lapb: fix t1 timer handling for
 LAPB_STATE_0
Date: Tue, 24 Nov 2020 13:29:05 +0100
Message-ID: <3d3f3733c08168bc8417021206cd93b9@dev.tdt.de>
References: <20201124093538.21177-1-ms@dev.tdt.de>
 <20201124093538.21177-4-ms@dev.tdt.de>
 <2d40b42aee314611b9ba1627e5eab30b@AcuMS.aculab.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2d40b42aee314611b9ba1627e5eab30b@AcuMS.aculab.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Laight <David.Laight@aculab.com>
Cc: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, xie.he.0141@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-11-24 12:43, David Laight wrote:
> From: Martin Schiller
>> Sent: 24 November 2020 09:36
>> 
>> 1. DTE interface changes immediately to LAPB_STATE_1 and start sending
>>    SABM(E).
>> 
>> 2. DCE interface sends N2-times DM and changes to LAPB_STATE_1
>>    afterwards if there is no response in the meantime.
> 
> Seems reasonable.
> It is 35 years since I wrote LAPB and I can't exactly remember
> what we did.
> If I stole a copy of the code it's on a QIC-150 tape cartridge!
> 
> I really don't remember having a DTE/DCE option.
> It is likely that LAPB came up sending DM (response without F)
> until level3 requested the link come up when it would send
> N2 SABM+P hoping to get a UA+F.
> It would then send DM-F until a retry request was made.
> 
> We certainly had several different types of crossover connectors
> for DTE-DTE working.
> 
> 	David
> 

The support for DTE/DCE was already in the LAPB code and I made it
configurable from userspace (at least for hdlc interfaces) with this
commit:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=f362e5fe0f1f

For Layer3 (X.25) I will add it with an addional patch (you already
commented on that) on a next step.

The described behaviour above is my interpretation of point 2.4.4.1 of
the "ITU-T Recommendation X.25 (10/96) aka "Blue Book" [1].

[1] https://www.itu.int/rec/T-REC-X.25-199610-I/

>> 
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> ---
>>  net/lapb/lapb_timer.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/net/lapb/lapb_timer.c b/net/lapb/lapb_timer.c
>> index 8f5b17001a07..baa247fe4ed0 100644
>> --- a/net/lapb/lapb_timer.c
>> +++ b/net/lapb/lapb_timer.c
>> @@ -85,11 +85,18 @@ static void lapb_t1timer_expiry(struct timer_list 
>> *t)
>>  	switch (lapb->state) {
>> 
>>  		/*
>> -		 *	If we are a DCE, keep going DM .. DM .. DM
>> +		 *	If we are a DCE, send DM up to N2 times, then switch to
>> +		 *	STATE_1 and send SABM(E).
>>  		 */
>>  		case LAPB_STATE_0:
>> -			if (lapb->mode & LAPB_DCE)
>> +			if (lapb->mode & LAPB_DCE &&
>> +			    lapb->n2count != lapb->n2) {
>> +				lapb->n2count++;
>>  				lapb_send_control(lapb, LAPB_DM, LAPB_POLLOFF, LAPB_RESPONSE);
>> +			} else {
>> +				lapb->state = LAPB_STATE_1;
>> +				lapb_establish_data_link(lapb);
>> +			}
>>  			break;
>> 
>>  		/*
>> --
>> 2.20.1
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes,
> MK1 1PT, UK
> Registration No: 1397386 (Wales)
