From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [RESEND PATCH v2] net/x25: Fix null-ptr-deref in x25_connect
Date: Wed, 11 Nov 2020 03:59:47 -0800
Message-ID: <20201111115947.3498-1-xie.he.0141@gmail.com>
References: <20201109065449.9014-1-ms@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YG3k/Ch1Sdw+uavjdcAB/2hmEdU18S9da0aZgB1LC9w=;
        b=OJHd8YW0FpftupIEkMr5q2hWOjHUIUkUVjPdqzOsoK+gEcfwxjqDaR4opGRZUjlRBt
         mUB/rxV30Y1YPDGMceexC0nOjVEAil/uvZXc1UWLzAlOzQAep0gs/uFwryrBwGpPBkSW
         7pAyK6f3iIOTzngwDN/MVdFRVG6+nWzxwvxv3JpmYH6gvPiiYJJXSMaisCrqo7zY0eW8
         2iyUSQ1zWIsBlwhG3vATC1pfJchMidRYWHn441RGMOgWqDUcP1sT/zIxM4VPz+r7UoOE
         NghtPulrqN7RZW+knhUE6NtJpb5105TsH6Z43/ri6z5hUC4FcHU4qnQS0idP6xPh8W7q
         asnw==
In-Reply-To: <20201109065449.9014-1-ms@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: andrew.hendry@gmail.com, davem@davemloft.net, kuba@kernel.org, edumazet@google.com, xiyuyang19@fudan.edu.cn, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Xie He <xie.he.0141@gmail.com>

> @@ -825,7 +825,7 @@  static int x25_connect(struct socket *sock, struct sockaddr *uaddr,
>  	sock->state = SS_CONNECTED;
>  	rc = 0;
>  out_put_neigh:
> -	if (rc) {
> +	if (rc && x25->neighbour) {
>  		read_lock_bh(&x25_list_lock);
>  		x25_neigh_put(x25->neighbour);
>  		x25->neighbour = NULL;

Thanks! It's amazing to see we are trying to fix the same issue.

Reviewed-by: Xie He <xie.he.0141@gmail.com>

