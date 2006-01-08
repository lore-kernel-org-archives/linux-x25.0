From: Bahri Okuroglu <bahrio@yahoo.com>
Subject: Re: Help with X.25 tests
Date: Sun, 8 Jan 2006 02:41:33 -0800 (PST)
Message-ID: <20060108104133.32263.qmail@web54109.mail.yahoo.com>
References: <Pine.LNX.4.62.0601080844450.11793@ik118.ikexpress.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0601080844450.11793@ik118.ikexpress.com>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Jean-Francois Gobin <gobin@gobinjf.be>, linux-x25@vger.kernel.org

Possibly there is some modified slattach to support
x25_asy, but I never could find it, and I did modified
it for my own purposes.=20

Download the slattach code and put below in a file
(say x25asy.c) in the lib folder. Add your
x25asy_hwtype struct to the hw.c file also, and
re-build slattach.=20

Mine version has a bit more code, to support DCE and
DTE operations, and below code is extracted from my
code and not compiled and not tested. FYI

--------------------------------
#include "config.h"


#include <sys/types.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <linux/if.h>
#include <stdlib.h>
#include <stdio.h>
#include <ctype.h>
#include <errno.h>
#include <fcntl.h>
#include <string.h>
#include <termios.h>
#include <unistd.h>
#include <linux/if_arp.h>
#include "lapb.h"
#include "support.h"
#include "pathnames.h"
#include "intl.h"
#define  EXTERN


/* Set the line discipline of a terminal line. */
static int
X25_set_disc(int fd, int disc)
{
  if (ioctl(fd, TIOCSETD, &disc) < 0) {
	fprintf(stderr, _("X25_set_disc(%d): %s\n"), disc,
strerror(errno));
	return(-errno);
  }
  return(0);
}


static int
do_x25(int fd)
{
  if (X25_set_disc(fd, N_X25) < 0) return(-1);
  return(0);
}


struct hwtype x25asy_hwtype =3D {
  "x25asy",	NULL, 		ARPHRD_X25,	0,
  NULL,		NULL,		NULL,		do_x25
};

---------------------------------------





--- Jean-Francois Gobin <gobin@gobinjf.be> wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> I must miss something :
>=20
> # slattach -s 9600 -p x25 /dev/ttyS0
> Cannot change line discipline to `x25'.
>=20



	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20

