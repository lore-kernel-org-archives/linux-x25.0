From: Yuan ChunYang <cyyuanml@sonata.iscas.ac.cn>
Subject: Difference of building modules between kernel 2.4.XX and 2.5.XX ???
Date: 07 Jul 2003 20:46:49 +0800
Sender: lartc-admin@mailman.ds9a.nl
Message-ID: <1057582009.1172.16.camel@sonata>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <lartc-admin@mailman.ds9a.nl>
Errors-To: lartc-admin@mailman.ds9a.nl
List-Help: <mailto:lartc-request@mailman.ds9a.nl?subject=help>
List-Post: <mailto:lartc@mailman.ds9a.nl>
List-Subscribe: <http://mailman.ds9a.nl/mailman/listinfo/lartc>,
	<mailto:lartc-request@mailman.ds9a.nl?subject=subscribe>
List-Id: <linux-x25.vger.kernel.org>
List-Unsubscribe: <http://mailman.ds9a.nl/mailman/listinfo/lartc>,
	<mailto:lartc-request@mailman.ds9a.nl?subject=unsubscribe>
List-Archive: <http://mailman.ds9a.nl/pipermail/lartc/>
Content-Type: text/plain; charset="us-ascii"
To: ml_users <users@lists.freeswan.org>, design_lsm_bounces <linux-security-module-bounces@wirex.com>, ml_design-request <design-request@lists.freeswan.org>, ml_lartc <lartc@mailman.ds9a.nl>, ml_linux-net <linux-net@vger.kernel.org>, ml_linux-x25 <linux-x25@vger.kernel.org>

In kernel 2.5, the implementation of building modules  must be changed.
As fellow, i programed a test .
In kernel 2.4.20 ,it's OK! 
But in kenel 2.5.72,you can see:

# insmod testdemo.o
Error inserting 'testdemo.o': -1 Unknown symbol in module

demo: no version magic, tainting kernel.
demo: Unknown symbol myprintk

Now i already installed module_init_tools 0.9.12.

can somebody tell me why?
how to resolve this problem.
thanx firstly. :)
                                                        yuan
                                        


#################################################################################
# Makefile:
#
LINUX_DIR = /usr/src/lsm-2.5
#LINUX_DIR = /usr/src/linux-2.4.20-8
CC=gcc

MODCFLAGS       = -D__KERNEL__ -I$(LINUX_DIR)/include
-I$(LINUX_DIR)/include/asm-i386/mach-default -Wall -DMODULE -O2 
-DKBUILD_MODNAME=$* -DKBUILD_BASENAME=$*  -Wstrict-prototypes -o $*.o

testdemo.o:	demo.o myprintk.o
	ld -m elf_i386 -r -o testdemo.o demo.o myprintk.o
demo.o:		demo.c myprintkp.c $(LINUX_DIR)/include/linux/version.h
	$(CC) $(MODCFLAGS) -c demo.c 
myprintk.o:	myprintk.c myprintk.h $(LINUX_DIR)/include/linux/version.h
	$(CC) $(MODCFLAGS) -c myprintk.c

clean:
	rm -f *.o  *.o.d

#######################################################################
/*
 * demo.c
 */


#include <linux/config.h>
#include <linux/kernel.h>
#include <linux/module.h>
#include <linux/init.h>


extern int myprintk (void);

static int __init demo_init(void) {
        printk("initializing..\n");
	myprintk();
        return 0;
}

static void __exit demo_exit(void) {
        printk("goodbye!\n");
}

module_init(demo_init);
module_exit(demo_exit);
MODULE_LICENSE("GPL");
###################################################################################
/*
* myprintk.c
*/

#include <linux/version.h>
#include <linux/config.h>
#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/init.h>

#include "myprintk.h"

static int myprintk (void)
{
	printk(KERN_INFO "This is my printk!\n");				

	return 0;
}

##################################################################################
/*
* myprintk.h
*/
#define MODULE_NAME   "HELLO"
static int myprintk (void);


###########################################################################

_______________________________________________
LARTC mailing list / LARTC@mailman.ds9a.nl
http://mailman.ds9a.nl/mailman/listinfo/lartc HOWTO: http://lartc.org/
