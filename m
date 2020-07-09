From: Xie He <xie.he.0141@gmail.com>
Subject: Re: [PATCH] drivers/net/wan/x25_asy: Fix to make it work
Date: Wed, 8 Jul 2020 21:15:21 -0700
Message-ID: <CAJht_EO8dgKzU5tpME446EXWNnDTkiWh_Mmoo9vO_goiS--FwA@mail.gmail.com>
References: <20200708043754.46554-1-xie.he.0141@gmail.com> <20200708.101321.1049330296069021543.davem@davemloft.net>
 <CAJht_EOqgWh0dShG258C3uoYdQga+EUae34tvL9HhqpztAv1PQ@mail.gmail.com>
Mime-Version: 1.0
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/+XXglinKvqEh9HpB9kPOVAnc92K+0mf/lvX8EuPGnw=;
        b=RFzLDBSA9s/W2HtdLYTctjQX3o9r9h287h9imW3l/GVScYafUZ5QJkNqGiS8NLyrpP
         +XMypprhjFOJcnkKJOFuheEDg6HYuEI1v9rqVbyprEAfbcMHQGNmC20SmkeM+WrGk+Lg
         bMjYoHQqrVRxILJy8wetWRtttgctBS6I5cqv0IxLg21wcFjGZSetXCuKx+espEg/8LOU
         kJjfE5GoowNETl+drB1d9KgBlXjrxjiCHyMOImXZXoDBz54SaUN1BX6mNR1wSJCNVM7z
         GzLk3WpanlGaCeps4FkA04HrAeVD/0bEiHYivk/J5sw/BIbfW+X3T3TtYfA7t4vNpYF0
         ICvw==
In-Reply-To: <CAJht_EOqgWh0dShG258C3uoYdQga+EUae34tvL9HhqpztAv1PQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, Shannon Nelson <snelson@pensando.io>, Martin Habets <mhabets@solarflare.com>, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org

This email is a detailed explanation of how to test the LAPB drivers,
just in case you have time to check. Thanks!

This email has 4 parts.
  1) How to set up "lapbether" links (for comparison)
  2) How to set up "x25_asy" links
  3) How to test using AF_X25 sockets
  4) How to test using AF_PACKET sockets (for simpler debugging)

You can compare the behavior of "lapbether" and "x25_asy".
You can also compare the behavior of "x25_asy" before and after
my change.

For the C code in this email, I'm sorry that for brevity, I didn't
include error checking. Declarations and statements are also mixed
which doesn't conform to the style in the Linux kernel. I won't
produce this kind of code when I am actually doing programming.

If you have any issue using or understanding my code. Please feel free
to ask me. Thanks!

--------------------------------------------------------
1) How to set up "lapbether" links

First set up a virtual Ethernet link:
  sudo ip link add veth1 type veth peer name veth0
  sudo ip link set veth0 up
  sudo ip link set veth1 up

Then:
  sudo modprobe lapb
  sudo modprobe lapbether

The lapbether driver will set up an LAPB interface for each Ethernet
interface, named lapb0, lapb1, lapb2, ...

Find the LAPB interfaces corresponding to veth0 and veth1, and use
  sudo ip link set lapbN up
to bring them up.

--------------------------------------------------------
2) How to set up "x25_asy" links

First:
  sudo modprobe lapb
  sudo modprobe x25_asy

Then set up a virtual TTY link:
  socat -d -d pty,cfmakeraw pty,cfmakeraw &
This will open a pair of PTY ports.
(The "socat" program can be installed from package managers.)

Then use a C program to set the line discipline for the two PTY ports:
  int ldisc = N_X25;
  int fd = open("path/to/pty", O_RDWR);
  ioctl(fd, TIOCSETD, &ldisc);
  close(fd);
Then we'll get two network interfaces named x25asy0 and x25asy1.

Then we do:
  sudo ip link set x25asyN up
to bring them up.

--------------------------------------------------------
3) How to test using AF_X25 sockets

Note that don't test a "lapbether" link and a "x25_asy" link at the
same time using AF_X25 sockets. There would be a kernel panic because
of bugs in the x25 module. I don't know how to fix this issue now but
may be able to in the future.

First:
  sudo modprobe x25

Then set up the routing table:
  sudo route -A x25 add 1/1 lapb1
or
  sudo route -A x25 add 1/1 x25asy0

Then in the server C program:
  int sockfd = socket(AF_X25, SOCK_SEQPACKET, 0);

  /* Bind local address */
  struct sockaddr_x25 serv_addr = {
      .sx25_family = AF_X25,
  };
  strcpy(serv_addr.sx25_addr.x25_addr, "111"); /* 111: server addr */
  bind(sockfd, (struct sockaddr *)&serv_addr, sizeof serv_addr);

  /* Wait for connections */
  listen(sockfd, 5);

  /* Accept connection */
  struct sockaddr_x25 client_addr;
  socklen_t client_addr_len = sizeof client_addr;
  int connected_sockfd = accept(sockfd, (struct sockaddr *)&client_addr,
                                &client_addr_len);

  char buffer[1000];
  ssize_t length = recv(connected_sockfd, buffer, sizeof buffer, 0);

  close(connected_sockfd);
  close(sockfd);

And in the client C program:
  int sockfd = socket(AF_X25, SOCK_SEQPACKET, 0);

  /* Bind local address */
  struct sockaddr_x25 local_addr = {
      .sx25_family = AF_X25,
  };
  strcpy(local_addr.sx25_addr.x25_addr, "777"); /* 777: local addr */
  bind(sockfd, (struct sockaddr *)&local_addr, sizeof local_addr);

  /* Connect to the server */
  struct sockaddr_x25 serv_addr = {
      .sx25_family = AF_X25,
  };
  strcpy(serv_addr.sx25_addr.x25_addr, "111"); /* 111: server addr */
  connect(sockfd, (struct sockaddr *)&serv_addr, sizeof serv_addr);

  send(sockfd, "data", 4, MSG_EOR);

  usleep(10000); /* Wait a while before closing */

  close(sockfd);

--------------------------------------------------------
4) How to test using AF_PACKET sockets

In the connected-side C program:
  int sockfd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_ALL));

  /* Get interface index */
  struct ifreq ifr;
  strcpy(ifr.ifr_name, "interface_name");
  ioctl(sockfd, SIOCGIFINDEX, &ifr);
  int ifindex = ifr.ifr_ifindex;

  struct sockaddr_ll sender_addr;
  socklen_t sender_addr_len = sizeof sender_addr;
  char buffer[1500];

  while (1) {
      ssize_t length = recvfrom(sockfd, buffer, sizeof buffer, 0,
                                (struct sockaddr *)&sender_addr,
                                &sender_addr_len);
      if (sender_addr.sll_ifindex != ifindex)
          continue;
      else if (buffer[0] == 0)
          printf("Data received.\n");
      else if (buffer[0] == 1)
          printf("Connected by the other side.\n");
      else if (buffer[0] == 2) {
          printf("Disconnected by the other side.\n");
          break;
      }
  }

  close(sockfd);

In the connecting-side C program:
  int sockfd = socket(AF_PACKET, SOCK_DGRAM, htons(ETH_P_ALL));

  /* Get interface index */
  struct ifreq ifr;
  strcpy(ifr.ifr_name, "interface_name");
  ioctl(sockfd, SIOCGIFINDEX, &ifr);
  int ifindex = ifr.ifr_ifindex;

  struct sockaddr_ll addr = {
      .sll_family = AF_PACKET,
      .sll_ifindex = ifindex,
  };

  /* Connect */
  sendto(sockfd, "\x01", 1, 0, (struct sockaddr *)&addr, sizeof addr);

  /* Send data */
  sendto(sockfd, "\x00" "data", 5, 0, (struct sockaddr *)&addr,
         sizeof addr);

  sleep(1); /* Wait a while before disconnecting */

  /* Disconnect */
  sendto(sockfd, "\x02", 1, 0, (struct sockaddr *)&addr, sizeof addr);

  close(sockfd);
