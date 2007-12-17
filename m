From: Bahri Okuroglu <bahrio@yahoo.com>
Subject: Re: X.25 in linux
Date: Mon, 17 Dec 2007 05:51:01 -0800 (PST)
Message-ID: <344966.27604.qm@web54106.mail.re2.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Matti Aarnio <matti.aarnio@zmailer.org>, ven swe <venkat_p257@yahoo.co.in>
Cc: linux-x25@vger.kernel.org

I was playing with a modified version of X25ASY module with COM1 and  COM2 looped back on the same PC. Here is my modified version of slattach  to support x25asy but with DCE and DTE modes:  http://dreamsware.info/slattach-1.2.0a-modified-for-custom-x25asy.rar 



Basically, I've copied slip module for X25 as x25asy.c:





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

    fprintf(stderr, _("X25_set_disc(%d): %s\n"), disc,  strerror(errno));

    return(-errno);

  }

  return(0);

}





/* Set the encapsulation type of a terminal line. */

static int

X25_set_dte(int fd, char *lapb_mode)

{

   struct lapb_parms_struct parms;

   

   if (ioctl(fd, SIOCGIFMAP, &parms) < 0) {

      fprintf(stderr, _("Can't get LAPB parms: %s\n"),  strerror(errno));

      return(-errno);

   }

   fprintf(stderr, "lapb mode: 0x%02X\n", parms.mode);   

   if (!strcmp(lapb_mode, "dce")) {

      parms.mode = (parms.mode | LAPB_DCE);

      fprintf(stderr, "  will set to DCE");

   } else {

      parms.mode = (parms.mode & ~LAPB_DCE);

      fprintf(stderr, "  will set to DTE");

   }

   fprintf(stderr, "lapb mode: 0x%02X\n", parms.mode);   

   if (ioctl(fd, SIOCSIFMAP, &parms) < 0) {

      fprintf(stderr, _("Can't set LAPB parms: %s\n"),  strerror(errno));

      return(-errno);

   }



   return(0);

}





/* Start the VJ-SLIP encapsulation on the file descriptor. */

static int

do_x25_dte(int fd)

{

  if (X25_set_disc(fd, N_X25) < 0) return(-1);

  if (X25_set_dte(fd, "dte") < 0) return(-1);

  return(0);

}



/* Start the VJ-SLIP encapsulation on the file descriptor. */

static int

do_x25_dce(int fd)

{

  if (X25_set_disc(fd, N_X25) < 0) return(-1);

  if (X25_set_dte(fd, "dce") < 0) return(-1);

  return(0);

}







struct hwtype x25asydte_hwtype = {

  "x25asydte",    NULL, /*"VJ Serial Line IP",*/        ARPHRD_X25,     0,

  NULL,        NULL,        NULL,        do_x25_dte

};



struct hwtype x25asydce_hwtype = {

  "x25asydce",    NULL, /*"VJ Serial Line IP",*/        ARPHRD_X25,     0,

  NULL,        NULL,        NULL,        do_x25_dce

};









and updated hw.c for hwtypes[] array:



static struct hwtype *hwtypes[] = {

  &loop_hwtype,

#if HAVE_HWSLIP

  &slip_hwtype,

  &cslip_hwtype,

  &slip6_hwtype,

  &cslip6_hwtype,

  &adaptive_hwtype,

#endif

  &unspec_hwtype,

#if HAVE_HWETHER

  &ether_hwtype,

#endif

#if HAVE_HWAX25

  &ax25_hwtype,

#endif

#if HAVE_HWPPP

  &ppp_hwtype,

#endif  

#if HAVE_HWARC

  &arcnet_hwtype,

#endif  

  &x25asydce_hwtype,

  &x25asydte_hwtype,

  NULL

};





Hope this helps,







----- Original Message ----

From: Matti Aarnio <matti.aarnio@zmailer.org>

To: ven swe <venkat_p257@yahoo.co.in>

Cc: linux-x25@vger.kernel.org

Sent: Monday, December 17, 2007 2:57:42 PM

Subject: Re: X.25 in linux



 On Mon, Dec 17, 2007 at 12:25:14PM +0000, ven swe wrote:

> 

> Thanks for your reply Matti.

> 

> I already configured my kernel (version 2.6.22.8) with  "X25_ASY" .

> And I am getting the error message.

> 

> I think this is because slattach is not supporting X25.

> 

> -venkat



It should be trivialish to add that support, if same thing

is enough what SLIP and PPP do  -- turn on the serial discipline

and let driver do everything.



Current slattach man-page tells that known disciplines are:



    slip, cslip, adaptive, ppp





SLIP is really trivial thing in terms of what the slattach

command does.  External scripts and programs then do ifconfig

and other magic for the network interfaces.



You could, probably, do the required moves with e.g. few lines

of perl script.  (Or C)



/Matti Aarnio

-

To unsubscribe from this list: send the line "unsubscribe linux-x25" in

the body of a message to majordomo@vger.kernel.org

More majordomo info at  http://vger.kernel.org/majordomo-info.html











      ____________________________________________________________________________________
Never miss a thing.  Make Yahoo your home page. 
http://www.yahoo.com/r/hs
