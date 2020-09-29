From: Martin Schiller <ms@dev.tdt.de>
Subject: Re: [PATCH] net/x25: Fix null-ptr-deref in x25_connect
Date: Tue, 29 Sep 2020 06:52:12 +0200
Message-ID: <162dd41ee6717ad46e0a37003d922ea1@dev.tdt.de>
References: <20200928092327.329-1-ms@dev.tdt.de>
 <20200928.184326.1754311969939569006.davem@davemloft.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20200928.184326.1754311969939569006.davem@davemloft.net>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: David Miller <davem@davemloft.net>
Cc: andrew.hendry@gmail.com, kuba@kernel.org, edumazet@google.com, xiyuyang19@fudan.edu.cn, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On 2020-09-29 03:43, David Miller wrote:
> From: Martin Schiller <ms@dev.tdt.de>
> Date: Mon, 28 Sep 2020 11:23:27 +0200
> 
>> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
>> index 0bbb283f23c9..0524a5530b91 100644
>> --- a/net/x25/af_x25.c
>> +++ b/net/x25/af_x25.c
>> @@ -820,7 +820,7 @@ static int x25_connect(struct socket *sock, struct 
>> sockaddr *uaddr,
>> 
>>  	rc = x25_wait_for_connection_establishment(sk);
>>  	if (rc)
>> -		goto out_put_neigh;
>> +		goto out;
> 
> If x25_wait_for_connection_establishment() returns because of an 
> interrupting
> signal, we are not going to call x25_disconnect().
> 
> The case you are fixing only applies _sometimes_ when
> x25_wait_for_connection_establishment() returns.  But not always.
> 
> That neighbour has to be released at this spot otherwise.

OK, thanks for the hint. So I think the simplest solution would be to 
check
that x25->neighbour is != NULL like this:

diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
index 0bbb283f23c9..046d3fee66a9 100644
--- a/net/x25/af_x25.c
+++ b/net/x25/af_x25.c
@@ -825,7 +825,7 @@ static int x25_connect(struct socket *sock, struct 
sockaddr *uaddr,
         sock->state = SS_CONNECTED;
         rc = 0;
  out_put_neigh:
-       if (rc) {
+       if (rc && x25->neighbour) {
                 read_lock_bh(&x25_list_lock);
                 x25_neigh_put(x25->neighbour);
                 x25->neighbour = NULL;
-- 

What do you think?
If that would be OK, I'll send a v2 of the Patch.

- Martin

