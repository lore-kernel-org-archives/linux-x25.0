From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH 2/2] wan/hdlc_x25: fix skb handling
Date: Tue, 14 Jan 2020 09:10:33 +0100
Message-ID: <f013ad8007d948436e85100184f82b67@dev.tdt.de>
References: <20200113124551.2570-1-ms@dev.tdt.de>
 <20200113124551.2570-2-ms@dev.tdt.de> <20200113054421.55cd5ddc@cakuba>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200113054421.55cd5ddc@cakuba>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Jakub Kicinski <kubakici@wp.pl>
Cc: khc@pm.waw.pl, davem@davemloft.net, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-01-13 14:44, Jakub Kicinski wrote:
> On Mon, 13 Jan 2020 13:45:51 +0100, Martin Schiller wrote:
>>  o call skb_reset_network_header() before hdlc->xmit()
>>  o change skb proto to HDLC (0x0019) before hdlc->xmit()
>>  o call dev_queue_xmit_nit() before hdlc->xmit()
>> 
>> This changes make it possible to trace (tcpdump) outgoing layer2
>> (ETH_P_HDLC) packets
>> 
>>  o use a copy of the skb for lapb_data_request() in x25_xmit()
> 
> It's not clear to me why

Well, this patch is ported form an older environment which is based on
linux-3.4. I can't reproduce the misbehavior with actual version, so I
will drop this part of the patch.

> 
>> This fixes the problem, that tracing layer3 (ETH_P_X25) packets
>> results in a malformed first byte of the packets.
>> 
>> Signed-off-by: Martin Schiller <ms@dev.tdt.de>
>> ---
>>  drivers/net/wan/hdlc_x25.c | 15 +++++++++++----
>>  1 file changed, 11 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/net/wan/hdlc_x25.c b/drivers/net/wan/hdlc_x25.c
>> index b28051eba736..434e5263eddf 100644
>> --- a/drivers/net/wan/hdlc_x25.c
>> +++ b/drivers/net/wan/hdlc_x25.c
>> @@ -72,6 +72,7 @@ static int x25_data_indication(struct net_device 
>> *dev, struct sk_buff *skb)
>>  	unsigned char *ptr;
>> 
>>  	skb_push(skb, 1);
>> +	skb_reset_network_header(skb);
>> 
>>  	if (skb_cow(skb, 1))
> 
> This skb_cow() here is for the next handler down to have a 1 byte of
> headroom guaranteed? It'd seem more natural to have skb_cow before the
> push.. not that it's related to your patch.

Thanks for the hint. I will move the skb_cow() before the skb_push().

> 
>>  		return NET_RX_DROP;
>> @@ -88,6 +89,9 @@ static int x25_data_indication(struct net_device 
>> *dev, struct sk_buff *skb)
>>  static void x25_data_transmit(struct net_device *dev, struct sk_buff 
>> *skb)
>>  {
>>  	hdlc_device *hdlc = dev_to_hdlc(dev);
> 
> Please insert a new line after the variable declaration since you're
> touching this one.

OK, will do.

> 
>> +	skb_reset_network_header(skb);
>> +	skb->protocol = hdlc_type_trans(skb, dev);


I will also insert an "if (dev_nit_active(dev))" here.

>> +	dev_queue_xmit_nit(skb, dev);
>>  	hdlc->xmit(skb, dev); /* Ignore return value :-( */
>>  }
>> 

