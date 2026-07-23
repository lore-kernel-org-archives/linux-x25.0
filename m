Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D44042DA4D
	for <linux-x25@vger.kernel.org>; Thu, 23 Jul 2026 09:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784800694; cv=none; b=q/y6JxkF7ToFCGud8mYRiUQcPg4I4BkA5z2TXkCgL72UMbPpK8lUf18wVwVaZ2ueoP+Ycw3Fp9pkbci0FA3rTajLMAkOQVrFRtMB0kPjXrh59ronrDK0oocLUZZhJvXXDkKdic55kLmzYdA8RLwB3lizB0bRHB3iKFO8k1h444Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784800694; c=relaxed/simple;
	bh=JyQ0i5MWICcwd6Ew8dcNJE1TVRfcbZFrQF41FwWqY7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P9/xeS8ykW5ytgMjtOW0txbYxwUcV6mKpJ59Z5T6KGBRLjhay6RAEq4BZ1uwTGmKqafZSNwAk6mQ7vH3i2MqQ4bDmIvLC3Dcv7b5bUjrOCelSqSJv5SGts+e/stAPf31rD3vw4ROkqO8DhudqWQVEf6bcAjdkWGr3wJW6yi4avQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RTX21+ZJ; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GfTlpSHE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RTX21+ZJ";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GfTlpSHE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784800690;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
	b=RTX21+ZJgzX4T+zquTAYoJ6tq3vimeVxmmv+/Gq03cSe/HoIEdsswkYQxGn26HnhcTNGpb
	rENMWTzt9LNWlNrXQ4A3R3QqnyHB5oIfxKVkDgtroVcyElwMZz2v2mAT/K1C9Rwci2igIm
	ot5AoTGRzVGRmbQqNfXkvPfrK1/iAk4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-bBUcDGXnMvaABzcyKc8N5A-1; Thu, 23 Jul 2026 05:58:09 -0400
X-MC-Unique: bBUcDGXnMvaABzcyKc8N5A-1
X-Mimecast-MFC-AGG-ID: bBUcDGXnMvaABzcyKc8N5A_1784800688
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49571407d1dso3858475e9.0
        for <linux-x25@vger.kernel.org>; Thu, 23 Jul 2026 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784800687; x=1785405487; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
        b=GfTlpSHENntQp6LKAz8fzM9NlqtDBsF6EvaxnHiRCmcF8Pa783UmcxbBegixhhdu5b
         0wLH80INZQGFBnpXn2HzA89pcvjwOpu/qO4uQlGPA6/hn8svZ75FWpmYg5PR+/gmOG/u
         6TJt3lkGQICZv1iNXF5BO39tewcVlT+6551PxFSsFLghVeq1ofJ5ZpmZ7Ul+SxODgojB
         6mtAg3tRzJTJ0I21lvIg/iXemZbAqNiN1d3xcA57FE5VOL2JGohH/Skz7Mrbtky11wxa
         gOjG7c/SzkNQCc6QKtxF+QN4NqWigqAFIklEjBT5DoQsRZR7thEL7ibzIJFjLaWClyy/
         vGKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784800687; x=1785405487;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzmqMYz+xqlvZxZzHgPFLcjsI6LqkVkgU9V+iNhdTHw=;
        b=JS9l1sOsu3/45NQHpAGpvIrGGICTx+pziCL5gsI3RfBi/LGFKNwfuKxGSvF1cEGJRj
         YyZWF5Ps8ZVbYflR0VUe6tUcZ4VSaGmM3yJXvpWkwyYBOzXMpkIVhE/dfWsIY/rNWcrA
         xg8NhNfLs68ABSDHQDO0rgBi+OiWZOlj4nHZriADEJSXMuDiwSuOoraiadHt5shjiOa9
         pO6LqVAeHZeTz9hZHDlzeuVu6RazPxSaQnM+hoZ7nSixxlycSnX0WbZo+jAsLEFHzjso
         D4QLWGEXMNBRMjY+VEWcDBOMf4uJ6iJ/yVQM+j2aC95JbkfvGGWRHRE+yv6AvDuXj25F
         oy0Q==
X-Forwarded-Encrypted: i=1; AHgh+RodQL7h1H1SanRM/f47tiLzE5MVuMOBeZxW4HTh4z80NlPp/Nx/ay4+Fi5SSDX1JmGW0NFrr8sS7eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQd+vKAikDu1Pj1mK8Rz2u3/wwLepJ5VgEXAEUkgNsdkCWPh6P
	mMiEJ1+7liIGSRpnFLcWUED8rYl8zaC8cmZ903r7xHu9oYQa05GOMAsYcs/6yMRGLoadMnUszAW
	XAp5kdFdaUejbfajDKGdXQqLAZpaxN5bao1btwTHMZu3kzv8KUl/VWvLKD4LdgRTRdeJ3Ww==
X-Gm-Gg: AR+sD13GfiHosVvN8KauosRGlvp2HpyHVvTRkypDSEHqp45ONn2yaHpo1hf6lpbX6H/
	IKEP7/KibSWttgCBtoE7MKbdG0tUEwmlVXraE24EH02bc9bsV+ObERiXZKnk+jXnosiL7F9yqKO
	78Tg8fSgVpJVnO2wYvza2e4wbgUaVOoJSUsakvlDD/dBqGGcKVIF7XgdyXsXwqTXnszQWveL8ta
	bPlKzIzQWH7j3f4WEjK90yicvPlV6WE/EknLFGWff+ds6FzUyhBE9MY9IBwtCyQ4oX6WVDrDHy7
	yEN4CJUF1kHMSQ57pgu9A19qWgARCc5X99K5R6VE0+qvhLgkJKc0X3SNDMm6QzHAumjqiPel0eR
	3h8CNHjD5dXBQLWVIosvj8A3txalTO+Jbc5nuPPMVlMJH1GhITu9CxYTKkLJR19qVAFCEfQZRSb
	HApA==
X-Received: by 2002:a7b:ce0b:0:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49573cc1a71mr16360025e9.4.1784800687603;
        Thu, 23 Jul 2026 02:58:07 -0700 (PDT)
X-Received: by 2002:a7b:ce0b:0:b0:495:6396:8b67 with SMTP id 5b1f17b1804b1-49573cc1a71mr16359805e9.4.1784800687105;
        Thu, 23 Jul 2026 02:58:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653c8760sm194729325e9.14.2026.07.23.02.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 02:58:06 -0700 (PDT)
Message-ID: <265fc46b-1e33-4283-b94b-7c591a9cf3ba@redhat.com>
Date: Thu, 23 Jul 2026 11:58:04 +0200
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/x25: fix use-after-free in x25_kill_by_neigh()
To: David Lee <david.lee@trailofbits.com>, Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>,
 Dominik 'Disconnect3d' Czarnota <dominik.czarnota@trailofbits.com>,
 linux-x25@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260713104752.241175-1-david.lee@trailofbits.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260713104752.241175-1-david.lee@trailofbits.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/13/26 12:47 PM, David Lee wrote:
> diff --git a/net/x25/af_x25.c b/net/x25/af_x25.c
> index c31d2af5dd22..8aae9273b7c1 100644
> --- a/net/x25/af_x25.c
> +++ b/net/x25/af_x25.c
> @@ -1768,15 +1768,19 @@ void x25_kill_by_neigh(struct x25_neigh *nb)
>  {
>  	struct sock *s;
>  
> +again:
>  	write_lock_bh(&x25_list_lock);
>  
>  	sk_for_each(s, &x25_list) {
>  		if (x25_sk(s)->neighbour == nb) {
> +			sock_hold(s);
>  			write_unlock_bh(&x25_list_lock);
>  			lock_sock(s);
> -			x25_disconnect(s, ENETUNREACH, 0, 0);
> +			if (x25_sk(s)->neighbour == nb)
> +				x25_disconnect(s, ENETUNREACH, 0, 0);
>  			release_sock(s);
> -			write_lock_bh(&x25_list_lock);
> +			sock_put(s);
> +			goto again;
>  		}
>  	}
>  	write_unlock_bh(&x25_list_lock);

Note that sk will stay on list (with NULL neigh) even after disconnect
and the above introduces a quadratic behavior, but I can't find an easy
way to avoid it.

/P

