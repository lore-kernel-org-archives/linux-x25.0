From: Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] MAINTAINERS: Add Martin Schiller as a
 maintainer for the X.25 stack
Date: Mon, 16 Nov 2020 10:21:07 -0800
Message-ID: <20201116102107.338f0a81@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20201114111029.326972-1-xie.he.0141@gmail.com>
        <3a556cae7d869059fa3b30c921a91658@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605550868;
        bh=YbDlZ1AVwxN0te7sA32IG9U9jyzPODAXadHjBoIrExE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DhKMjcJ/PzKmehKHb2T1T3fxKu4VnNIIWzGCryDYJ1ZqOalvyK4wKS84O23uj01Q0
         BMl/OMqq0xrrjh8o69mNBVxgwxdbBS4c2hoXoXzs0vOXwcEMllNqUW+D8se28fLeEW
         9x1mBrduxQecypCEZazgOVEejuErSG8Qw4hSXyas=
In-Reply-To: <3a556cae7d869059fa3b30c921a91658@dev.tdt.de>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: Xie He <xie.he.0141@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Hendry <andrew.hendry@gmail.com>

On Mon, 16 Nov 2020 10:01:20 +0100 Martin Schiller wrote:
> On 2020-11-14 12:10, Xie He wrote:
> > Martin Schiller is an active developer and reviewer for the X.25 code.
> > His company is providing products based on the Linux X.25 stack.
> > So he is a good candidate for maintainers of the X.25 code.
> > 
> > The original maintainer of the X.25 network layer (Andrew Hendry) has
> > not sent any email to the netdev mail list since 2013. So he is 
> > probably
> > inactive now.
> > 
> > Cc: Martin Schiller <ms@dev.tdt.de>
> > Cc: Andrew Hendry <andrew.hendry@gmail.com>
> > Signed-off-by: Xie He <xie.he.0141@gmail.com>
> 
> Acked-by: Martin Schiller <ms@dev.tdt.de>

Applied to net, thanks everyone!
