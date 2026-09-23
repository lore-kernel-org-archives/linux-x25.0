Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A634F7CC2;
	Wed, 23 Sep 2026 18:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188616; cv=none; b=MyIx5vy7lUjcCXZe4h4P/lJqpsqBFRbNDnlQZsQRxeQvaRIznf76svwsSOh8DmwPdBmlD2LesO5+lZc5yMgqhrATDzoMlk9uhr/zuhkz2n+GpolBSgtz8qFOCNurP/Hka6YJbBiI92nPTOxgXHtqVcSAIK0jom/+g74Yqm6PfCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188616; c=relaxed/simple;
	bh=JL7qiNIJk2xEDzTSFsm5Bihaoqd6OdIA8wy+NS10xw8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XcmaBNsw1KKgYJqvbFGt37DYsyHNF81EeRIFpJsJLSajTMaYmK9kn1+i4qjX4C2zs83ly5RTXkdvnRtKwmdZdXSI5j5nX3lhuXqimAdIeQNK5iGjVPGZd7aRaBvXXT1jGgcItqNBg/AHFNwWokNkmmmsAw9AK0AJhFZPXj0GgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojHDVES1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojHDVES1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 183EF1F00898;
	Wed, 23 Sep 2026 18:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188613;
	bh=25MY+Zd89NtguhAVE2EGnUFSrRTrA9eFeBAajKLx1UI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ojHDVES1BhpjL7wPofREswsNcNsHrG1eI/n0MGLsx0xKXQZJjU/Gm6zJZ4fHhzrKj
	 zmInyfdSh5idQ7v6wV1xPEG2+GGZ1RV7yek4kphdCjLzynyLhK1X6dokW/dN4LeTFE
	 o4m+5m2q00EMhb3QMxDv0rXNzzhcdOkv1eGy6RFUzXDEBfwM6weTGxo8Eu8SZp7s6K
	 Hc+1HHmAuhNlr8zcOr1U+orKF6vXnQLxHNGBp7nmFGR6U7IZkeyYOtrgygi/GwnbTP
	 m3daNqyZKs/MG6hkewmxvnVbglGd+TLEFNRn/U7gpNrzVpDj3SBD4KjQSOHLJt1wWX
	 h8soHNbb9rZiA==
Subject:
 Re: [PATCH] net: lapb: fix uninitialized stack frame fields in lapb_decode()
From: netdev-bot+sashiko@kernel.org
To: benquike@gmail.com
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 18:36:52 +0000
Message-ID: <179018861262.2160803.7893822871484169869@kernel.org>
In-Reply-To: <20260919213639.3314894-1-benquike@gmail.com>
References: <20260919213639.3314894-1-benquike@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The second justification in the commit message is factually
  wrong.
- [Medium] The patch bundles an orthogonal receive-path acceptance-policy
  change into what is presented as an uninitialized-memory fix.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but there is a
  producer/consumer mismatch in net/lapb around LAPB_ILLEGAL.

--

net: lapb: fix uninitialized stack frame fields in lapb_decode()

lapb_decode() fills in a caller-allocated struct lapb_frame that lives on
the stack of lapb_data_input().  The patch adds a memset() of that struct at
the top of lapb_decode() and converts the address-byte comparisons into an
if/else-if chain that returns -1 when the address byte matches none of the
expected values.

No Link: tags in the commit header.

A few questions about the commit message and the behavioural change below.

>     1. When `skb->data[0]` is not a valid LAPB address byte (`LAPB_ADDR_A`,
>        `LAPB_ADDR_B`, `LAPB_ADDR_C`, or `LAPB_ADDR_D`), `frame->cr` is left
>        uninitialized on the stack while `lapb_decode()` continues parsing
>        and copies `frame->cr` into `lapb->frmr_data.cr` via
>        `lapb_transmit_frmr()`, leaking 1 bit of kernel stack memory over the
>        network.
>     2. When decoding an unnumbered (`LAPB_U`) or illegal frame in
>        `LAPB_EXTENDED` mode, `frame->control[1]` is left uninitialized on
>        the stack and copied into the outgoing `FRMR` frame by
>        `lapb_transmit_frmr()`.

[Severity: Medium]
Is justification 2 accurate?  In the LAPB_EXTENDED branch of lapb_decode()
the U-frame arm already assigns control[1] explicitly, and that line is not
touched by this patch:

	} else if ((skb->data[0] & LAPB_U) == 3) {
		/*
		 * U frame - take out PF
		 */
		frame->type       = skb->data[0] & ~LAPB_SPF;
		frame->pf         = skb->data[0] & LAPB_SPF;
		frame->control[0] = skb->data[0];
		frame->control[1] = 0x00;

The I and S arms in the same branch both assign control[1] = skb->data[1].

For the "illegal frame in LAPB_EXTENDED mode" half of the claim: with
LAPB_S == 0x01 and LAPB_U == 0x03, the three tests

	if (!(skb->data[0] & LAPB_S))
	else if ((skb->data[0] & LAPB_U) == 1)
	else if ((skb->data[0] & LAPB_U) == 3)

cover all 256 control-byte values, since bit 0 clear selects the I arm and
bit 0 set forces skb->data[0] & 3 to be 1 or 3.  Is there any extended-mode
path that returns 0 without writing control[1]?

The only branch that leaves control[1] unwritten is the standard
(non-extended) branch, which the commit message does not mention, and
lapb_transmit_frmr() emits control[1] only in its LAPB_EXTENDED arm:

	if (lapb->mode & LAPB_EXTENDED) {
		...
		*dptr++ = lapb->frmr_data.control[1];
	} else {
		dptr    = skb_put(skb, 4);
		*dptr++ = LAPB_FRMR;
		*dptr++ = lapb->frmr_data.control[0];

Since lapb->mode does not change between decode and FRMR transmission, can
the standard-mode control[1] byte reach the wire either?

Justification 1 does look real: frame->cr was left uninitialized when the
address byte matched neither expected value, and it is encoded into the
transmitted FRMR by

	if (lapb->frmr_data.cr == LAPB_RESPONSE)
		*dptr |= 0x01;

Could the message be narrowed to that one leak?  The Fixes: 1da177e4c3f4
tag means this goes to every stable tree, and the current text makes the
issue look broader than it is.

> diff --git a/net/lapb/lapb_subr.c b/net/lapb/lapb_subr.c
> index 592a22d86a97..8150f3583f15 100644
> --- a/net/lapb/lapb_subr.c
> +++ b/net/lapb/lapb_subr.c
> @@ -106,6 +106,7 @@ int lapb_validate_nr(struct lapb_cb *lapb, unsigned short nr)
>  int lapb_decode(struct lapb_cb *lapb, struct sk_buff *skb,
>  		struct lapb_frame *frame)
>  {
> +	memset(frame, 0, sizeof(*frame));
>  	frame->type = LAPB_ILLEGAL;

[Severity: Medium]
This isn't a bug introduced by this patch, but the memset() sits right on
top of a producer/consumer mismatch worth noting.  lapb_decode() advertises
an illegal-frame result via frame->type = LAPB_ILLEGAL, yet no successful
return can leave that value in place: LAPB_ILLEGAL is 0x100, while the
classification arms assign LAPB_I (0), skb->data[0] & 0x0F (0-15) or
skb->data[0] & ~LAPB_SPF (0-255), and as noted above the arms are exhaustive
over the control byte.

The consumer side in lapb_state3_machine() therefore never runs:

	case LAPB_ILLEGAL:
		lapb_dbg(1, "(%p) S3 RX ILLEGAL(%d)\n", lapb->dev, frame->pf);
		lapb->frmr_data = *frame;
		lapb->frmr_type = LAPB_FRMR_W;
		lapb_transmit_frmr(lapb);

There is no default: arm in that switch, so an extended-mode S frame with
skb->data[0] & 0x0F == 0x0D matches no case and is simply dropped at
if (!queued) kfree_skb(skb), rather than producing the FRMR(W) response.

One note specific to the new line: LAPB_I is 0x00, so the memset() must
always be followed by the explicit frame->type = LAPB_ILLEGAL assignment.
If that assignment were ever dropped or reordered, an undecodable frame
would reach the state machines looking like a valid I frame.  Would a
comment there help?

> @@ -120,25 +121,33 @@ int lapb_decode(struct lapb_cb *lapb, struct sk_buff *skb,
>  		if (lapb->mode & LAPB_DCE) {
>  			if (skb->data[0] == LAPB_ADDR_D)
>  				frame->cr = LAPB_COMMAND;
> -			if (skb->data[0] == LAPB_ADDR_C)
> +			else if (skb->data[0] == LAPB_ADDR_C)
>  				frame->cr = LAPB_RESPONSE;
> +			else
> +				return -1;

[Severity: Medium]
Should the new early returns be a separate patch?  They change what the
receive path accepts, which is independent of the uninitialized-memory fix.

Before this patch an unexpected address byte only failed to set frame->cr;
decoding continued through skb_pull(skb, 1) into the control-field parser
and the frame still reached the state machine, so a SABM/UA/DISC carrying a
non-conforming address could still drive connection setup and teardown.

After this patch the sole caller drops the frame outright:

net/lapb/lapb_in.c:lapb_data_input() {
	if (lapb_decode(lapb, skb, &frame) < 0) {
		kfree_skb(skb);
		return;
	}

No state machine is entered, no UA/DM/FRMR reply is generated, nothing is
logged, and the trailing lapb_kick(lapb) is skipped.  On a link whose peer
address byte does not match the local MLP/SLP plus DCE/DTE configuration,
the link can no longer leave LAPB_STATE_0, and there is no counter or
message to diagnose it.

Is the early return needed for the leak itself?  With the memset() in place
frame->cr is 0, which is neither LAPB_COMMAND (1) nor LAPB_RESPONSE (2), and
those are the only values ever tested, in lapb_transmit_frmr():

	if (lapb->frmr_data.cr == LAPB_RESPONSE)
		*dptr |= 0x10;

and in lapb_check_need_response():

	if (type == LAPB_COMMAND && pf)
		lapb_enquiry_response(lapb);

Dropping invalid-address frames does match ISO 7776, so the change looks
desirable on its own, but the commit message describes only the mechanical
change ("return -1 when skb->data[0] is not a valid LAPB address byte") and
not the protocol consequence.  Could this be split into zero-initializing
the frame and rejecting invalid address bytes, or at least have the
behavioural effect spelled out for backporters?

>  		} else {
>  			if (skb->data[0] == LAPB_ADDR_C)
>  				frame->cr = LAPB_COMMAND;
> -			if (skb->data[0] == LAPB_ADDR_D)
> +			else if (skb->data[0] == LAPB_ADDR_D)
>  				frame->cr = LAPB_RESPONSE;
> +			else
> +				return -1;
>  		}

[ ... remaining address-byte arms are the same change ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919213639.3314894-1-benquike%40gmail.com
