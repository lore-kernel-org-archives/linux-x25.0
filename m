From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/lapbether: Added needed_tailroom
Date: Tue, 18 Aug 2020 17:17:32 -0700
Message-ID: <CAJht_EN9eVKXJWL4JVCFt1nJeU3V-PnmRdqKwKA5oSkMyiHmdg@mail.gmail.com>
References: <20200808175251.582781-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cwJJvwl+wwGOOqkLkrNY75DCUDoJdmUKN4BfYZbZXCo=;
        b=l9ubu3/lNk58Z2y8lE/Gy6GFsPgFIHSX5PVQN8JC90P/iRG4IwP2ubtrIHujRK1O7p
         0LOxqNttzpTyo9A2/FVWUcFJtjENGhi6HUDlOudqbK8jydFulPKcJmndY7bkD4+W8TJC
         DPdoBHmu19ao4TTEKl4g8aqCImqVxdVk0X2KfKqc2AGQQcODce6kSstrTbtR//CD8qnc
         VqKKTXyrCL3cMrk0I6zfq0fl+ftFQkO/s89wG4huMX2x6mte0qUOT6ZNkFogAKlEdgoS
         uL4XFptWHWEjs4TFFFPbWVvAghOps45JbOWshZYAP18d3ZigXxdRIszJZOfqD+SZaJ6a
         a6SA==
In-Reply-To: <20200808175251.582781-1-xie.he.0141@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gnault@redhat.com, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Martin Schiller <ms@dev.tdt.de>

Hi Guillaume Nault,

I'm currently trying to fix a driver's "needed_tailroom" setting. This
driver is a virtual driver stacked on top of Ethernet devices (similar
to pppoe). I believe its needed_tailroom setting should take into
account the underlying Ethernet device's needed_tailroom. So I
submitted this patch. I see you previously also did a change related
to needed_tailroom to pppoe. Can you help review this patch? Thank you
so much!

The patch is at:
http://patchwork.ozlabs.org/project/netdev/patch/20200808175251.582781-1-xie.he.0141@gmail.com/

Thanks!
Xie He
