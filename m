From: Jean-Francois Gobin <gobin@gobinjf.be>
Subject: Re: Help with X.25 tests
Date: Sun, 8 Jan 2006 08:45:43 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0601080844450.11793@ik118.ikexpress.com>
References: <20060107185036.24242.qmail@web54113.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <20060107185036.24242.qmail@web54113.mail.yahoo.com>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
Content-Transfer-Encoding: 7bit
To: linux-x25@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I must miss something :

# lsmod

Module                  Size  Used by
x25                    61552  0
x25_asy                15088  0
lapb                   26097  1 x25_asy
ipv6                  371552  10
ohci_hcd               26428  0
usbcore               161452  3 ohci_hcd
cy82c693                6928  0
tulip                  71016  0
de4x5                  73904  0
crc32                   5376  2 tulip,de4x5
tsdev                  10216  0
evdev                  12664  0
psmouse                28824  0
ide_disk               26360  0
ide_cd                 56640  0
ide_core              175468  3 cy82c693,ide_disk,ide_cd
cdrom                  53920  1 ide_cd
ext3                  170448  3
jbd                    79992  1 ext3
sd_mod                 26985  9
qla1280               136448  0
scsi_mod              161000  2 sd_mod,qla1280
unix                   37640  46
font                    9224  0
tgafb                  23632  0
cfbcopyarea             7968  1 tgafb
cfbimgblt               4712  1 tgafb
cfbfillrect             6912  1 tgafb

# slattach -s 9600 -p x25 /dev/ttyS0
Cannot change line discipline to `x25'.





On Sat, 7 Jan 2006, Bahri Okuroglu wrote:



- ----------
Jean-Francois Gobin - Administrateur gobinjf.be
http://www.gobinjf.be   mailto:gobin@gobinjf.be
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Made with pgp4pine 1.76

iD8DBQFDwMMrkkg3QInH2uURAqdfAKDYaBlsPHkEt97Ulqe1DF0+06hkRgCgveTA
WnXb46KmZ1kzC+2dZlnGuZ8=
=d5dk
-----END PGP SIGNATURE-----

