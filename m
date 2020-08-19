From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
Date: Wed, 19 Aug 2020 15:11:58 -0700
Message-ID: <CAJht_EMQSfU17tpJzyKmi7QcpVYgDuxf-1V+csfsVmVzgDmGcg@mail.gmail.com>
References: <20200808175251.582781-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=jR3JT70rmRNM6vsO8qmX1MbKYQ90OTWT9h+SWIytADw=;
        b=q5UB2sjLxDm0IylzVL6BvBt0cPKA/8nfCCV2ROgK1nfLwssmLIwPIdUU/IHtvC5sIt
         zKPCx7epGg8Sm1KloWuj4fxITyh7/zjuSM31N6gTJYEzc5hD7S88dWJ62hed82iIIuTU
         0uQwe3q4HLFinJAhFp0nkRZFYNiz2kFwq58t6BUQEt93H+6XphYzzPeCRdZEm6IGRRnN
         p46fYmUahLYW0mE72mqoDHLYuThQUiQS9pJcmwONZWwQ9+oPW07CHWIKPA9U8WN3bCua
         c2xDMZrSfcCA2G8qGtxJn8FRkH82LEKJxn3Bwa8fHon55G65iQCAW2pP4FgyvKDJowzX
         LGig==
In-Reply-To: <20200808175251.582781-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

Hi Martin Schiller,

Can you help review this patch? Thanks! It is a very simple patch that
adds the "needed_tailroom" setting for this driver.

Thank you!
Xie He
