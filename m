From: Bahri Okuroglu <bahrio@yahoo.com>
Subject: Re: Help with X.25 tests
Date: Sat, 7 Jan 2006 10:56:49 -0800 (PST)
Message-ID: <20060107185649.65178.qmail@web54101.mail.yahoo.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-x25-owner@vger.kernel.org>
Sender: linux-x25-owner@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="windows-1252"
To: Jean-Francois Gobin <gobin@gobinjf.be>
Cc: linux-x25@vger.kernel.org

=46irst, you need to use slattach to set the line
discipline of the port, you're interested in, to X25.
After that you'll have a network interface like
x25asy0, which you should take up and set some routes.


In the kernel, LAPB is configured as DTE by default (
http://lxr.linux.no/source/net/lapb/lapb_iface.c#L135
and http://lxr.linux.no/source/include/net/lapb.h#L58
). If you need your box to act as DCE, you either need
to change this default behavior or enable the user to
be able to change it.=20

I'm not an expert on these issues, but the code looks
like for testing issues as noted at the top of the
source code. For example it does not implement CRC and
does only byte stuff=C4=B1ng, not bit stuffing. Do you
know that Cisco can talk to it?=20

Good luck,

> Jean-Francois Gobin <gobin@gobinjf.be> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>=20
> Hello all,
>=20
> I'm trying to setup a X.25 connection between a
> Cisco and a linux box=20
> through a serial port (Async /dev/ttyS0)
>=20
> I'have the following configuration :
>=20
> Cisco --Cisco Cable DCE--> Linux BOX
>=20
> So, for now what I'm looking for is that I can't
> manage to even have my=20
> interface set up in X.25.
>=20
> I'm trying using x25_asy, but I didn't find where to
> specify the serial=20
> line to use.
>=20
> Help! Help! Help!
>=20
> Regards,
> jF
>=20
> - ----------
> Jean-Francois Gobin - Administrateur gobinjf.be
> http://www.gobinjf.be   mailto:gobin@gobinjf.be
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.1 (GNU/Linux)
> Comment: Made with pgp4pine 1.76
>=20
>
iD8DBQFDwAKDkkg3QInH2uURAu00AJ0WYFFxSbaFXqLVfKTDIn/zRy4cRQCfSV/B
> Uh63S3+cgkBfbIRwHycxgLU=3D
> =3DX64R
> -----END PGP SIGNATURE-----
>=20
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-x25" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at=20
> http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
> 	=09
> ---------------------------------
>  Yahoo! DSL Something to write home about. Just
> $16.99/mo. or less



	=09
__________________________________________=20
Yahoo! DSL =96 Something to write home about.=20
Just $16.99/mo. or less.=20
dsl.yahoo.com=20

