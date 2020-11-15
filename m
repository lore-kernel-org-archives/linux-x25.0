From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: x25: Correct locking for x25_kill_by_device and x25_kill_by_neigh
Date: Sat, 14 Nov 2020 19:11:13 -0800
Message-ID: <CAJht_EMN14idYb9uY6eSASVb+ZHM6jZ3c=Kr5mTSjVE+2aYyoA@mail.gmail.com>
References: <20201114103625.323919-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=ukfVupsoBY8wkZwTJBGd3ADBH/ygOk7x7LJMOM5IEEs=;
        b=MRiaFED49X65sqy4dYNQV9EFlBoCtJ6jSM8VjfGy4myZ6wJA1DPfztU0Nf6wyZ9KWR
         2pQinrVzpg6N+MqlYJvUHOdpDCit4uvnhLcbbllPLO2YqBhNRfKbsjYT5X1mKGeIV2ZT
         OeAUHv7gSb0H1SCPElq75gskVmOGpll/ZScs2QC3qom7uuU/q2d8FsdfkQx3KggP1jAr
         uf7sHrUoH3+4E0koW5VuyhZPSRZCknpxfupKLJ7OmYVQlQI/GFlFbI42NqXHVvDncdtx
         9dPsZU2vbvyNJYf/L18ux2G6xRH6sN6dSSqgH1nJCaTRgBt1+ztCzWASqTXRi3qWAtxC
         6qKA==
In-Reply-To: <20201114103625.323919-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Sat, Nov 14, 2020 at 2:36 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> This patch adds correct locking for x25_kill_by_device and
> x25_kill_by_neigh, and removes the incorrect locking in x25_connect and
> x25_disconnect.

I see if I do this change, I need to make sure the sock lock is not
held when calling x25_remove_socket, to prevent deadlock.

Sorry. I'll deal with this issue and resubmit.

I also see that in x25_find_listener and __x25_find_socket, when we
traverse x25_list, we should probably also hold the sock lock when we
read the element of the list, and continue to hold the lock when we
find the sock we want.
