From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH] net/x25: add new state X25_STATE_5
Date: Mon, 09 Dec 2019 06:28:53 +0100
Message-ID: <3841dcf6dab454445da7b225e0d45212@dev.tdt.de>
References: <20191206133418.14075-1-ms@dev.tdt.de>
 <20191207.115922.532322440743611081.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191207.115922.532322440743611081.davem@davemloft.net>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Miller <davem@davemloft.net>
Cc: andrew.hendry@gmail.com, edumazet@google.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2019-12-07 20:59, David Miller wrote:
> From: Martin Schiller <ms@dev.tdt.de>
> Date: Fri,  6 Dec 2019 14:34:18 +0100
> 
>> +	switch (frametype) {
>> +
>> +		case X25_CLEAR_REQUEST:
> 
> Please remove this unnecessary empty line.
> 
>> +			if (!pskb_may_pull(skb, X25_STD_MIN_LEN + 2))
>> +				goto out_clear;
> 
> A goto path for a single call site?  Just inline the operations here.

Well, I was guided by the code style of the other states.
I could add a patch to also clean up the other states.
What do you think?

