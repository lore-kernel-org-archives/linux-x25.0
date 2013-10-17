From: Andrew Hendry <andrew.hendry@gmail.com>
Subject: Re: [PATCH] X.25: Fix address field length calculation
Date: Thu, 17 Oct 2013 22:02:13 +1100
Message-ID: <CADo0ohh7jZhc_WJFkrYYxoYza8ZeSEadzwgwabJWwQ1TucdCcg@mail.gmail.com>
References: <525D5131.9070007@datus.com>
	<1381858190.22110.25.camel@joe-AO722>
	<AE90C24D6B3A694183C094C60CF0A2F6026B738F@saturn3.aculab.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=3Zie9fmkKnXgcO/xZ2tv+g/GTS+cmxrWahzj4skN9BM=;
        b=UWMm5mqjmjyWETjgXz6OcwDHl92oxCRBnGMfTdVao2gmbCURKIMsaMSRrk5XfEY8yD
         WxITrktYs+c8uaKdpYbMGoKm+CixT1LbvDD0BCXl7AOX3ZS/fVI8mTSLKc5lFobC/61I
         a4o1XNVxTg6zLZeyJk9ih7OTBaFf4zaTlQAI3+Sf2MFuyFWSbhJfYCiGTxZ6MtcrnM57
         ZcimcfjFns5SH7NMojgDh0CQMlzuJtk9YazR0/azPLzUhL95kgBOy0YJL4iunZpTQtxK
         TaolSNcRwyECQ4+UhqXT+0ZeMdyvoJYtdVvezXK6eT8R+qtXstD35I5E613Ug1MaIUSw
         C57Q==
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B738F@saturn3.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: David Laight <David.Laight@aculab.com>
Cc: Joe Perches <joe@perches.com>, =?ISO-8859-1?Q?Kelleter=2C_G=FCnther?= <GKelleter@datus.com>, David Miller <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Sorry for the previous html mail.
This appears to be correct, what length addresses are you getting back
in the call accept when this happens?

On Wed, Oct 16, 2013 at 7:56 PM, David Laight <David.Laight@aculab.com>=
 wrote:
>> On Tue, 2013-10-15 at 14:29 +0000, Kelleter, G=FCnther wrote:
>> > Addresses are BCD encoded, not ASCII. x25_addr_ntoa got it right.
>> []
>> > Wrong length calculation leads to rejection of CALL ACCEPT packets=
=2E
>> []
>> > diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
>> []
>> > @@ -98,7 +98,7 @@ int x25_parse_address_block(struct sk_buff *skb,
>> >     }
>> >     len =3D *skb->data;
>> > -   needed =3D 1 + (len >> 4) + (len & 0x0f);
>> > +   needed =3D 1 + ((len >> 4) + (len & 0x0f) + 1) / 2;
>>
>> This calculation looks odd.
>
> Looks correct to me...
> In X.25 the lengths (in digits) of the called and calling addresses
> are encoded in the high and low nibbles of one byte and then
> followed by both addresses with a digit in each nibble.
> If the length of the first address is odd, the second one
> isn't byte aligned.
>
>         David
>
>
>
