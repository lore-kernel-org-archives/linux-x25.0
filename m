From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH v2] drivers/net/wan/lapbether: Use needed_headroom instead
 of hard_header_len
Date: Thu, 30 Jul 2020 18:57:42 -0700
Message-ID: <CAJht_EM0SdezzQUJsdCxPjLk9Wz0SWnFkqxiFWUEEpQ-WO9JdA@mail.gmail.com>
References: <20200730073702.16887-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=zBXnYdUEX8Q8zEVSbgNanWh7jg7JO//MtEogCqZsZmY=;
        b=MjahxHhbMzQjsWTnZdkXtSEoDZrYhLo5Nc61KX9bAO5krHkNG45tCqZ6JTcFnb9ONc
         4iFXKEQX+yRki/80NiECemtSeBdgNp6nRhPaXi7yLjo0iy5S7Fx1MWalGZ7DRVBUZjRH
         VX0SI5Sck/gFD0fvn2IPZd6u43kprzkNX8P82eByuIdiGhT9gMBxzHBYu9KNWbf4SsoK
         1hGPIzDCSV2YUa73IJm6ENTlhmB4FxvoXV9Qf0VdtYy+tFp7ih+Wvev3kzX4fIddPPDB
         hwrcd6o/K6fUp8AdykaOguYbnVlGUCgAPksI90kP33UfGwGJZRzRFwks3VuUJ3lngo42
         ywMw==
In-Reply-To: <20200730073702.16887-1-xie.he.0141@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Willem de Bruijn <willemb@google.com>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>

Brian Norris has approved this patch with "Reviewed-by" in the v1
email thread. I really appreciate his review. It's very hard for me to
find reviewers for X.25 code so I'm grateful for anyone who could
help. Thanks to everyone.

Reviewed-by: Brian Norris <briannorris@chromium.org>
