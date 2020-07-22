From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/x25_asy: Fix to make it work
Date: Tue, 21 Jul 2020 20:10:05 -0700
Message-ID: <CAJht_EN8NNrCbN9B+_Axn=cPk7hXtE8nL8_h=UnRvqjJWNf0Bw@mail.gmail.com>
References: <20200716234433.6490-1-xie.he.0141@gmail.com> <20200721.183022.1464053417235565089.davem@davemloft.net>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2gBvT+YIZWph6R5sz1Mzm8EtE/EDwKEAunOqRTotXyo=;
        b=q9RN/uqnI7m54W20WphAIPLxv7ob4CoSESjI6zwgl1jN1JoSJoH6jay7n6BGHS/UVs
         lyQibjJ0DoG1nI57ZndSvSpC3HQ190VTua9p7vZKR2uwzzq60lhrGegRyWv8Stpri2e/
         xLJesIQYH/A1bok2VBt0m2U7rn0/eDsDV36bg/arKrAEBXj7cc3xAtpXmSGtZnyOTZ3H
         Rt+XSKPXmUv30IU9KqagydgRTz8IRM4fLWvGVtUYFePc30GuvvrbKYSvQjLJOe7shlP4
         qIWcF9QHSo+w4jDOS3rIATUbqEigYlM/0XgQ4C2rljFpPb1Qv/J/yy7W/h0pqhgI9meS
         4vpQ==
In-Reply-To: <20200721.183022.1464053417235565089.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, Martin Schiller <ms@dev.tdt.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Linux X25 <linux-x25@vger.kernel.org>

On Tue, Jul 21, 2020 at 6:30 PM -0700
David Miller <davem@davemloft.net> wrote:
>
> Applied, thank you.

Thank you so much, David!
