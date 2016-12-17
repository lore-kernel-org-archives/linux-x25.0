From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] net/x25: use designated initializers
Date: Sat, 17 Dec 2016 11:58:12 -0500 (EST)
Message-ID: <20161217.115812.1170388230079582920.davem@davemloft.net>
References: <20161217010339.GA140529@beast>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20161217010339.GA140529@beast>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: keescook@chromium.org
Cc: linux-kernel@vger.kernel.org, andrew.hendry@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Fri, 16 Dec 2016 17:03:39 -0800

> Prepare to mark sensitive kernel structures for randomization by making
> sure they're using designated initializers. These were identified during
> allyesconfig builds of x86, arm, and arm64, with most initializer fixes
> extracted from grsecurity.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.
