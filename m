From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/lapbether: Added needed_headroom and a
 skb->len check
Date: Thu, 6 Aug 2020 04:21:53 -0700
Message-ID: <CAJht_ENbEh1JFhk57YD+MteOafv6+PgE25hRUjyiPk9B48dEVA@mail.gmail.com>
References: <20200806015040.98379-1-xie.he.0141@gmail.com> <CA+FuTSeOhYOqKjHk5ZBFiY=_+pXgUKe4BKx1S+gu9T9X2c1+bQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jnzzxc34cQW56LxwSyg5mi8Zc5YMYFPRJUcDt/n6b0U=;
        b=LvvBqyfgpeZFSNNkZU5lsH3pLnN3iLgCPYQiwOUywcijpSNbWn1VcotxvttMfFZZ/0
         UEooSgKnM/46tX0dlW6rODlpbd70OlBc1b6QxBwLff+/AixsDfDV/LcDJTsVHqVmWVib
         7JoeJiPKNeBlYli59nkZnoGA7CvxTwbmtgA43tH15RABrCfUbQTGKm9COuxDF2cVBXzo
         gUuxTBkMB1GUdaNl5WvzpQqYnVbhDA/LCSST/w/pdAN2Qgi/B41xGydKPVk27/AbcbSc
         HBOYygAnhNBzT5VBMtPYX0jdHiY0FqIKhNJcyJKpKVYBKZLo/LXuBD6uhx7k8DFGI9CP
         dBRw==
In-Reply-To: <CA+FuTSeOhYOqKjHk5ZBFiY=_+pXgUKe4BKx1S+gu9T9X2c1+bQ@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>, Brian Norris <briannorris@chromium.org>

On Thu, Aug 6, 2020 at 12:47 AM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
> Acked-by: Willem de Bruijn <willemb@google.com>
>
> The in-band signal byte is required, but stripped by lapbeth_xmit.
> Subsequent code will prefix additional headers, including an Ethernet
> link layer. The extra space needs to be reserved, but not pulled in
> packet_snd with skb_reserve, so has to use needed_headroom instead of
> hard_header_len.

Thank you, Willem!
