From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH 16/20] net/x25/: use LIST_HEAD instead of LIST_HEAD_INIT
Date: Fri, 07 Dec 2007 00:50:50 -0800 (PST)
Message-ID: <20071207.005050.237662850.davem@davemloft.net>
References: <1196957239-5728-1-git-send-email-crquan@gmail.com>
	<1196957239-5728-2-git-send-email-crquan@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <1196957239-5728-2-git-send-email-crquan@gmail.com>
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: Text/Plain; charset="us-ascii"
To: crquan@gmail.com
Cc: linux-x25@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org

From: Denis Cheng <crquan@gmail.com>
Date: Fri,  7 Dec 2007 00:07:19 +0800

> single list_head variable initialized with LIST_HEAD_INIT could almost
> always can be replaced with LIST_HEAD declaration, this shrinks the code
> and looks better.
> 
> Signed-off-by: Denis Cheng <crquan@gmail.com>

Applied.
