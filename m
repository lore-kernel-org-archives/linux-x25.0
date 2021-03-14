From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] net: lapbether: Prevent racing when checking whether
 the netif is running
Date: Sat, 13 Mar 2021 17:59:54 -0800
Message-ID: <CAJht_ENT6E4pekdTJ8YKntKdH94e-1H6Tf6iBr-=Vbxj5rCs+A@mail.gmail.com>
References: <20210311072311.2969-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qs2UgpNHrs9qIOZOqKSGGqFmmr2tm9Rf+HF/JQPX6rg=;
        b=JCANjpJP+PSwE6nrZCgLfG3qg7hPxPu7DbwxIQaDZt6QwRdc5nCYjCsoWGwtP1nHjN
         DwHK78zzo0uKy2y71O2YeKHGMHtHivAvry5Ci45KJKMF+Y5sbLmnvzNZo2gAvVPEMUwl
         U9brCTm0M5h7qzmQEK0cz+iELqKbOii8x0xr9BDHLSC+ptdXxLhLuRSILTUrJJ5QIoPy
         5jR6kL2f5hNVgVYFUDmqGEVOP6iTNkSntTlN0dqaLo/6Xzo5qQBnSWsKstt4mDfaPQ8M
         xjM7c6598kE4VR89Dg9jWgWXpK9eVqCjnNYcK4xyVeZgDWREdzuO7nPs/2qBjLfqDong
         0lNA==
In-Reply-To: <20210311072311.2969-1-xie.he.0141@gmail.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Martin Schiller <ms@dev.tdt.de>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

Hi Martin,

Could you ack? Thanks!
