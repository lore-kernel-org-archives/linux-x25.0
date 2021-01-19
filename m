From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net v2] net: lapb: Add locking to the lapb module
Date: Tue, 19 Jan 2021 05:54:26 -0800
Message-ID: <CAJht_EMYEvcsOn6QGxGFBeR288ep+vJNxJVan48R8mEoVaVpUg@mail.gmail.com>
References: <20210117224750.6572-1-xie.he.0141@gmail.com> <6fb2a40bf347997416cd38454d1b194a@dev.tdt.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dQsO/EmArEXp+xjehbwD5uyX9Cu3rc2d/LRGhvZR/k8=;
        b=vBLoNsMrixsho9dWLeOk5XJtNqAlJe56Fl9QpxEDu+8FbtZ+/0VskFPPFkJ8IMwRI8
         U9bIsWm84ywa51T/l6zC2/2IFgyL/Sqf9EXE6+sPLbWouPcDh0JQem7h82xcbvNa16TC
         OK0Ykmft7oJZYZdskwr5ZekjNi9O4/7qOrubT6elo++Ve1F/Ycoot+WPkMYKHp5+Rm3p
         JmyQNrG91ck7BiaERcYjAlNI9WYLksiA49NeAtUsI3+jGdXDBUQlHYpwx4yJC70zYN0w
         lB27sxCA9jybvzX11QMe+68u6u1ByxAsg+1zwJFXtn9cIes79J7w9D8aJ/3JVvUYd9y8
         Q11g==
In-Reply-To: <6fb2a40bf347997416cd38454d1b194a@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On Tue, Jan 19, 2021 at 3:34 AM Martin Schiller <ms@dev.tdt.de> wrote:
>
> > 4. In lapb_device_event, replace the "lapb_disconnect_request" call
> > with
> > the content of "lapb_disconnect_request", to avoid trying to hold the
> > lock twice. When I do this, I removed "lapb_start_t1timer" because I
> > don't think it's necessary to start the timer when "NETDEV_GOING_DOWN".
>
> I don't like the code redundancy this creates. Maybe you should move the
> actual functionality from lapb_disconnect_request() to a
> __lapb_disconnect_request(), and in lapb_disconnect_request() call this
> function including locking around it and also in lapb_device_event
> (without locking).
>
> Calling lapb_start_t1timer() on a "NETDEV_GOING_DOWN" event does not
> hurt and is correct from a protocol flow point of view after sending
> the DISC.

Thanks! I created a new __lapb_disconnect_request function and the
code indeed looked cleaner. I'll send a new version.
