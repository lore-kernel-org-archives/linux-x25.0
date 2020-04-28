From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: [PATCH] net/x25: Fix null-ptr-deref in x25_disconnect
Date: Tue, 28 Apr 2020 19:52:44 +0200
Message-ID: <2638b7a4-4c19-ca4d-3931-7442378b3b30@web.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588096373;
        bh=tnjQv2P9gGiR9Mb9PDJN0nYvFGdtYNLKJDSs4Sk2/Wg=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=YWWcul4nCyZy4q/m9sIPWVgxeHXOqy4GKNkUhCkxeEi0o3cg4DhWAabyuyngxrBKW
         +bxwPzloZkbJwV200G4wkj4Hm8EC1e4LdwRfNs6cSwQwZNlcwYpX9wWouyLlZIHOLC
         a7OVYOvcIDa/NG8Gx8X0eRwZpZE1j25wgS/cL+o8=
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
To: YueHaibing <yuehaibing@huawei.com>, linux-x25@vger.kernel.org, netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Allison Randal <allison@lohutok.net>, Andrew Hendry <andrew.hendry@gmail.com>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Xin Tan <tanxin.ctf@gmail.com>, Xiyu Yang <xiyuyang19@fudan.edu.cn>

> We should check null before do x25_neigh_put in x25_disconnect,
> otherwise may cause null-ptr-deref like this:

Will it be clearer to use the term =E2=80=9Cnull pointer dereference=E2=80=
=9D
in the final commit subject?

Regards,
Markus
