From: Ozgur <ozgurk@ieee.org>
Subject: Re: [PATCH] x25: remove redundant pointer dev
Date: Mon, 9 May 2022 04:57:40 +0400
Message-ID: <CAADfD8wApw_v+uDTijY1K89WRJ_f7tkHmz=6LR086yMjEU4mWQ@mail.gmail.com>
References: <20220508214500.60446-1-colin.i.king@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uk2GCo4tzO2z68A4aXi5qgjOdRQLhbqgNbxwMMvi8jk=;
        b=Nql1Yjsic1g62x+3t7bP9sHcXY0u/gU5tmXaF5KQZzfGTru2e4lVe0MtlZA0k3imjr
         YJxXKkTCdME5QT1vex+PZQooBQh5O0iISkVhcWdtmTb504b90IqPn944ijh9S2yR++u1
         IQ1fIJlmWrCDlpWRNr+iMvB8UtpS7SN/swZmg=
In-Reply-To: <20220508214500.60446-1-colin.i.king@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Martin Schiller <ms@dev.tdt.de>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>

On Mon, May 9, 2022 at 1:45 AM Colin Ian King <colin.i.king@gmail.com> wrote:
>
> Pointer dev is being assigned a value that is never used, the assignment
> and the variable are redundant and can be removed. Also replace null check
> with the preferred !ptr idiom.
>

Hello,

*dev pointer is device assign global linked list and shouldnt be
touched by the driver so *dev wont get any value right?
Also seems to use this while network interface is initializing because
some activation information and stats information is also kept here,
for example, open *dev will call when ifconfig is called from.

route, link, forward these inital activate and move all values with
net_device *dev?

Regards

> Cleans up clang scan warning:
> net/x25/x25_proc.c:94:26: warning: Although the value stored to 'dev' is
> used in the enclosing expression, the value is never actually read
> from 'dev' [deadcode.DeadStores]
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  net/x25/x25_proc.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/net/x25/x25_proc.c b/net/x25/x25_proc.c
> index 3bddcbdf2e40..91a2aade3960 100644
> --- a/net/x25/x25_proc.c
> +++ b/net/x25/x25_proc.c
> @@ -79,7 +79,6 @@ static int x25_seq_socket_show(struct seq_file *seq, void *v)
>  {
>         struct sock *s;
>         struct x25_sock *x25;
> -       struct net_device *dev;
>         const char *devname;
>
>         if (v == SEQ_START_TOKEN) {
> @@ -91,7 +90,7 @@ static int x25_seq_socket_show(struct seq_file *seq, void *v)
>         s = sk_entry(v);
>         x25 = x25_sk(s);
>
> -       if (!x25->neighbour || (dev = x25->neighbour->dev) == NULL)
> +       if (!x25->neighbour || !x25->neighbour->dev)
>                 devname = "???";
>         else
>                 devname = x25->neighbour->dev->name;
> --
> 2.35.1
>
