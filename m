From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a
 skb->len check
Date: Mon, 10 Aug 2020 09:20:56 +0200
Message-ID: <CA+FuTSc7c+XTDU10Bh1ZviQomHgiTjiUvOO0iR1X95rq61Snrg@mail.gmail.com>
References: <20200809023548.684217-1-xie.he.0141@gmail.com>
 <CA+FuTSe-FaQFn4WNvVPJ1v+jVZAghgd1AZc-cWn2+GjPR4GzVQ@mail.gmail.com> <CAJht_EOao3-kA-W-SdJqKRiFMAFUxw7OARFGY5DL8pXvKd4TLw@mail.gmail.com>
Mime-Version: 1.0
Return-path: <netdev-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZuLaH0X1DjxkMIYvUZjBNQpk5tuEvtJPSM7s3zpgVA=;
        b=Vqsl98sYIlry7YsaqgssuM5FYIzcM1D1osf7noHDmEMsN0q9nuXfpONaiOGWw4ZjNC
         GxhEAINLCMhMJDXOQSwp0eT1EuzFIPK7K9sBVCA7MqB9w8S9as0fdMVPzkQztlI+7WOt
         /rNLveVzyktnS6wtY82qfRfX2+vhRGoSTiY3sFsqzzrUVCALKkg6UEDeAAEwvLaSoBsr
         XI4q4keaf/eP45qsUCtETI3Z8DZP3nBImstSbgruJmYJ4/vZGz2l0dj4nlPSEblvxSRT
         6WN9Zy9y9GA/sLzBO/UHTY4UZ6sLECmSe7Fky3fjpNkkWQyi3isxhpzHbDgcYc+Njtee
         WPtA==
In-Reply-To: <CAJht_EOao3-kA-W-SdJqKRiFMAFUxw7OARFGY5DL8pXvKd4TLw@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Xie He <xie.he.0141@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Network Development <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

On Sun, Aug 9, 2020 at 8:08 PM Xie He <xie.he.0141@gmail.com> wrote:
>
> On Sun, Aug 9, 2020 at 2:13 AM Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> wrote:
> >
> > The patch is analogous to commit c7ca03c216ac
> > ("drivers/net/wan/lapbether: Added needed_headroom and a skb->len
> > check").

Acked-by: Willem de Bruijn <willemb@google.com>

> >
> > Seems to make sense based on call stack
> >
> >   x25_asy_xmit               // skb_pull(skb, 1)
> >   lapb_data_request
> >   lapb_kick
> >   lapb_send_iframe        // skb_push(skb, 2)
> >   lapb_transmit_buffer    // skb_push(skb, 1)
> >   lapb_data_transmit
> >   x25_asy_data_transmit
> >   x25_asy_encaps
>
> Thank you!
>
> > But I frankly don't know this code and would not modify logic that no
> > one has complained about for many years without evidence of a real
> > bug.
>
> Maybe it's better to submit this patch to "net-next"?

That depends on whether this solves a bug. If it is possible to send a
0 byte packet and make ndo_start_xmit read garbage, then net is the
right target.

> I want to do this change because:
>
> 1) I hope to set needed_headroom properly for all three X.25 drivers
> (lapbether, x25_asy, hdlc_x25) in the kernel. So that the upper layer
> (net/x25) can be changed to use needed_headroom to allocate skb,
> instead of the current way of using a constant to estimate the needed
> headroom.

Which constant, X25_MAX_L2_LEN?

> 2) The code quality of this driver is actually very low, and I also
> hope to improve it gradually. Actually this driver had been completely
> broken for many years and no one had noticed this until I fixed it in
> commit 8fdcabeac398 (drivers/net/wan/x25_asy: Fix to make it work)
> last month.

Just curious: how come that netif_rx could be removed?

> This driver has a lot of other issues and I wish I can
> gradually fix them, too.
>
> > Were you able to actually exercise this path, similar to lapb_ether:
> > configure the device, send data from a packet socket? If so, can you
> > share the configuration steps?
>
> Yes, I can run this driver. The driver is a software driver that runs
> over TTY links. We can set up a x25_asy link over a virtual TTY link
> using this method:
>
> First:
>   sudo modprobe lapb
>   sudo modprobe x25_asy
>
> Then set up a virtual TTY link:
>   socat -d -d pty,cfmakeraw pty,cfmakeraw &
> This will open a pair of PTY ports.
> (The "socat" program can be installed from package managers.)
>
> Then use a C program to set the line discipline for the two PTY ports:
> Simplified version for reading:
>   int ldisc = N_X25;
>   int fd = open("path/to/pty", O_RDWR);
>   ioctl(fd, TIOCSETD, &ldisc);
>   close(fd);
> Complete version for running:
>   https://github.com/hyanggi/testing_linux/blob/master/network_x25/lapb/set_ldisc.c
> Then we'll get two network interfaces named x25asy0 and x25asy1.
>
> Then we do:
>   sudo ip link set x25asyN up
> to bring them up.
>
> After we set up this x25_asy link, we can test it using AF_PACKET sockets:
>
> In the connected-side C program:
> Complete version for running:
>   https://github.com/hyanggi/testing_linux/blob/master/network_x25/lapb/receiver.c
> Simplified version for reading:
>   int sockfd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_ALL));
>
>   /* Get interface index */
>   struct ifreq ifr;
>   strcpy(ifr.ifr_name, "interface_name");
>   ioctl(sockfd, SIOCGIFINDEX, &ifr);
>   int ifindex = ifr.ifr_ifindex;
>
>   struct sockaddr_ll sender_addr;
>   socklen_t sender_addr_len = sizeof sender_addr;
>   char buffer[1500];
>
>   while (1) {
>       ssize_t length = recvfrom(sockfd, buffer, sizeof buffer, 0,
>                                 (struct sockaddr *)&sender_addr,
>                                 &sender_addr_len);
>       if (sender_addr.sll_ifindex != ifindex)
>           continue;
>       else if (buffer[0] == 0)
>           printf("Data received.\n");
>       else if (buffer[0] == 1)
>           printf("Connected by the other side.\n");
>       else if (buffer[0] == 2) {
>           printf("Disconnected by the other side.\n");
>           break;
>       }
>   }
>
>   close(sockfd);
>
> In the connecting-side C program:
> Complete version for running:
>   https://github.com/hyanggi/testing_linux/blob/master/network_x25/lapb/sender.c
> Simplified version for reading:
>   int sockfd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_ALL));
>
>   /* Get interface index */
>   struct ifreq ifr;
>   strcpy(ifr.ifr_name, "interface_name");
>   ioctl(sockfd, SIOCGIFINDEX, &ifr);
>   int ifindex = ifr.ifr_ifindex;
>
>   struct sockaddr_ll addr = {
>       .sll_family = AF_PACKET,
>       .sll_ifindex = ifindex,
>   };
>
>   /* Connect */
>   sendto(sockfd, "\x01", 1, 0, (struct sockaddr *)&addr, sizeof addr);
>
>   /* Send data */
>   sendto(sockfd, "\x00" "data", 5, 0, (struct sockaddr *)&addr,
>          sizeof addr);
>
>   sleep(1); /* Wait a while before disconnecting */
>
>   /* Disconnect */
>   sendto(sockfd, "\x02", 1, 0, (struct sockaddr *)&addr, sizeof addr);
>
>   close(sockfd);
>
> I'm happy to answer any questions. Thank you so much!

Thanks very much for the detailed reproducer.

One thing to keep in mind is that AF_PACKET sockets are not the normal
datapath. AF_X25 sockets are. But you mention that you also exercise
the upper layer? That gives confidence that these changes are not
accidentally introducing regressions for the default path while fixing
oddly crafted packets with (root only for a reason) packet sockets.
