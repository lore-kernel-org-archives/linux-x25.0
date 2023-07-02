From: Askar Safin <safinaskar@gmail.com>
Subject: Re: [PATCH net-next v3 17/18] sock: Remove ->sendpage*() in favour of sendmsg(MSG_SPLICE_PAGES)
Date: Sun, 2 Jul 2023 20:54:47 +0300
Message-ID: <CAPnZJGB6gk47Hw-OE2_9eSKJ0DwOzEiL+tncMJyiOD6arw6xag@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-doc-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688320524; x=1690912524;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B/346nUIZErMaap4Xzifysw7agxmNBKblpAJllVen+8=;
        b=HS1Xpu8RutGjzNf2cNefIvO40PuyEyyWN1lXpuUm3Zm6tYXGDXwbDrBzDuJeX7KOHr
         q1UGGgd94SVTRefQw+1rgl1gQ50uEoBHL2OdSUILUjvF+1ATH9gvheGUN++hFOwLNLid
         1XMjRZLU+9Ge2en4fJbD50bjnQdqOwyoXZfvhIPbUVY/sq6Vm6BAvUYZPRqmTRzyIG2n
         JWXOYS2flIDtpE0mu19bw1MyMQp5M6uow+iO1HWzOXqc6Z90+aO2nBs6Bf+FGR5IBS25
         laBmv/H9uClBFT1isqMjJFlPY+WcanwzxZg1N8ZxZIN6sqfmOEIBN1yT1YF0buNY5Ya/
         4xig==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>, bpf@vger.kernel.org, dccp@vger.kernel.org, linux-afs@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org

> -/* In some cases, both sendpage() and sendmsg() could have added
> - * an skb to the write queue, but failed adding payload on it.
> - * We need to remove it to consume less memory, but more
> - * importantly be able to generate EPOLLOUT for Edge Trigger epoll()
> - * users.
> +/* In some cases, both sendmsg() could have added an skb to the write queue,
> + * but failed adding payload on it.  We need to remove it to consume less
> + * memory, but more importantly be able to generate EPOLLOUT for Edge Trigger
> + * epoll() users.
>   */

There is a typo here. "Both" is redundant now

-- 
Askar Safin
