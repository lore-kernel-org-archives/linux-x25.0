From: Hyunwoo Kim <v4bel@theori.io>
Subject: Re: [PATCH v2] net/x25: Fix to not accept on connected socket
Date: Wed, 25 Jan 2023 03:08:37 -0800
Message-ID: <20230125110837.GA134263@ubuntu>
References: <20230123194323.GA116515@ubuntu>
 <167464081679.8627.16186557969987796753.git-patchwork-notify@kernel.org>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p1TZ9HgFaUKxGS7c+lLSxsI3P/cyPJN6ga8wsZCYuGY=;
        b=RqurFXTSNH1gTEosFbblzxWowqr1IVNJgjVZWBR+k+2ptzeUtGV8DfzWd4Z/wd2Zjl
         4dbmqWQciRUyE5DdwECInD4DtG52J1ip6ycrE4nKizPm3Z0jmjzOt6z984niv8kWskFb
         qJxy7WDLQ43ZkAjzYpgWmFkEGaDSx/GShBcMk=
Content-Disposition: inline
In-Reply-To: <167464081679.8627.16186557969987796753.git-patchwork-notify@kernel.org>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: patchwork-bot+netdevbpf@kernel.org
Cc: ms@dev.tdt.de, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, v4bel@theori.io, imv4bel@gmail.com, linux-x25@vger.kernel.org, netdev@vger.kernel.org

Dear,

This patch's description is incorrect and should not be applied.

Newly submitted corrected v3 patch:
https://lore.kernel.org/all/20230125110514.GA134174@ubuntu/


Regards,
Hyunwoo Kim
