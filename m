From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
Date: Sat, 15 Aug 2020 19:28:14 -0700
Message-ID: <CAJht_EOsQ-QLFBeJCytTRSRuor6jnCEE+zMBV+ngtwr25OSCSQ@mail.gmail.com>
References: <20200808175251.582781-1-xie.he.0141@gmail.com>
 <CA+FuTSfxWhq0pxEGPtOMjFUB7-4Vax6XMGsLL++28LwSOU5b3g@mail.gmail.com>
 <CAJht_EM9q9u34LMAeYsYe5voZ54s3Z7OzxtvSomcF9a9wRvuCQ@mail.gmail.com>
 <CA+FuTSdBNn218kuswND5OE4vZ4mxz3_hTDkcRmZn2Z9-gaYQZg@mail.gmail.com> <CAJht_EPGD1RmnU6-ZJYocXCY-qcPxXeEuurQ6GJod=WGO69-jg@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hdWuVMBr25WAMERNCsCJ/+D2iaw+OKauMCpYgioq/Tw=;
        b=K8mGhCEWw2CjwKCIlw5S56kNnFLiEPTdk3Mrb8NdZYVgqduliLdJ6vmzmb3vbD1PG2
         JGe1A84KHTwqTQKW3d1oJfFSue6+qIi+4uCzDLp+IqqYo+NCPB28VM2KQZtIzzcDlWIT
         WfVvUIP/BX89mh1uyMlUClSBXnLvFjcbcXySHn/W14gvEDRtPQhfMqXvFjEQErUHQxi7
         K/7CzTiSSU4Bn+foCa3gcMvnSfSNjorEu34wn/Trz1ollGXg2zqBFV6qIAWc6Lf/DMQc
         +oVYWjCCHVexMnoTo3W5SawAseIpYwo/xECcz1Se/byp273PCzfAyV34Rc74GV8CgfWL
         jxrA==
In-Reply-To: <CAJht_EPGD1RmnU6-ZJYocXCY-qcPxXeEuurQ6GJod=WGO69-jg@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

I took some time to look at the history of needed_tailroom. I found it
was added in this commit:
f5184d267c1a (net: Allow netdevices to specify needed head/tailroom)

The author tried to make use of needed_tailroom at various places in
the kernel by replacing the macro LL_RESERVED_SPACE with his new macro
LL_ALLOCATED_SPACE.

However, the macro LL_ALLOCATED_SPACE was later found to have
problems. So it was removed 3 years later and was replaced by explicit
handling of needed_tailroom. See:
https://lkml.org/lkml/2011/11/18/198

So maybe only those places considered by these two authors have taken
needed_tailroom into account.

Other places might not have taken needed_tailroom into account because
of the rarity of the usage of needed_tailroom.

The second author also said in the commit message of his Patch 5/6
(which changes af_packet.c), that:
    While auditing LL_ALLOCATED_SPACE I noticed that packet_sendmsg_spkt
    did not include needed_tailroom when allocating an skb.  This isn't
    a fatal error as we should always tolerate inadequate tail room but
    it isn't optimal.

This shows not taking needed_tailroom into account is not a bug but
it'd be better to take it into account.
