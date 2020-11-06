From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH net-next] net: x25_asy: Delete the x25_asy driver
Date: Fri, 6 Nov 2020 03:25:02 -0800
Message-ID: <CAJht_ENiEi1u-fNuE+3NSBY=3BOWL4cC8ndJAH04f-jBR-CW1w@mail.gmail.com>
References: <20201105073434.429307-1-xie.he.0141@gmail.com>
 <CAK8P3a2bk9ZpoEvmhDpSv8ByyO-LevmF-W4Or_6RPRtV6gTQ1w@mail.gmail.com>
 <CAJht_EPP_otbU226Ub5mC_OZPXO4h0O2-URkpsrMBFovcdDHWQ@mail.gmail.com>
 <CAK8P3a2jd3w=k9HC-kFWZYuzAf2D4npkWdrUn6UBj6JzrrVkpQ@mail.gmail.com>
 <CAJht_EPAqy_+Cfh1TXoNeC_j7JDgPWrG-=mMMmQ3ot2gNZuB8A@mail.gmail.com> <f4b59cfa4f6b4cc89bf2f111974bb86e@AcuMS.aculab.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mB5fwGqdf8GYUjQarYKzei/oazwXbZmsmBYQhWu5IT8=;
        b=rZuJo4P5dTRkmDpxPz8PnDj+07wXqJyAJpSC07VDYGNf/HKgv27KGcyG5lKnbXIIj7
         jBqQwzzWDPpA5sBlbmXNMZEK94/QLfQ/cikgDeE9LyF847qF2/LvklsCoag+qh0igSo8
         wY5Shyc7YdY914v+UJmUDQWN45jJagcmhCNTDRX2KsRuF8ursWoPV35QeqZmWPKt2Q39
         ZxFON3X6xbk135sb1OZFgOSBHXuDsMcZ6Chi6PryJuA62OQzmNOMYJqs5yEIcPpnlWtF
         xOZqQ1+Cp7YvaBEZ6Tg2vLw2GlwoAaZH9kEM0b7zGMPXxeKDE1WJ0gYE8g8f5Q5Dh7co
         lGWg==
In-Reply-To: <f4b59cfa4f6b4cc89bf2f111974bb86e@AcuMS.aculab.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Laight <David.Laight@aculab.com>
Cc: Arnd Bergmann <arnd@kernel.org>, Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, Networking <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Martin Schiller <ms@dev.tdt.de>, Andrew Hendry <andrew.hendry@gmail.com>, Linux X25 <linux-x25@vger.kernel.org>

On Fri, Nov 6, 2020 at 1:03 AM David Laight <David.Laight@aculab.com> wrote:
>
> Hmmm.... LAPB would expect to have an X.25 level 3 and maybe ISO
> transport (class 0, 2 or 3) sat on top of it.

I actually used AF_PACKET sockets to transport data directly over LAPB
and it worked.

LAPB doesn't need anything from layer 3. It just sees the layer 3
packets as a sequence of packets, numbers them and reliably transports
them in order. It doesn't read the internal contents of the packets.
