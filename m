From: "Kevin Curtis" <kevin.curtis@farsite.co.uk>
Subject: X25.h
Date: Wed, 14 Apr 2004 17:33:48 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <7C078C66B7752B438B88E11E5E20E72E15A7EA@general.hq.farsitecommunications.com>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-x25-owner@vger.kernel.org>
content-class: urn:content-classes:message
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-x25@vger.kernel.org

Hi,
	has anyone noticed that the x25.h in /usr/src/linux/include/linux and =
/usr/include/linux/ are different in the way that they define x25_addre=
ss, i.e.

typedef struct {
	char		x25_addr[16];
} x25_address;

And

struct x25_address {
	char x25_addr[16];
};

I assume the kernel version is correct.

I am using Fedora Core 2 test1, so I guess the error could be there?


Kevin

-----Original Message-----
=46rom: linux-x25-owner@vger.kernel.org [mailto:linux-x25-owner@vger.ke=
rnel.org] On Behalf Of Herve Gautier
Sent: 26 March 2004 13:17
To: linux-x25@vger.kernel.org
Subject: Re: Is the kernel X.25 support still actively maintained?


un@roo wrote:
> Hello All,
>=20
>       Is anybody working with x.25 now?
>       Is anybody use Eicon cards in Linux?

Yes ! With the GCOM LiS streams and the Eicon X25 libraries. But I'm no=
t=20
an X.25 expert :-/

>       Can anybody help in setting up x.25 in there?

You can make a try !

>=20
>       Nicolay
>=20

--=20
Herv=E9 Gautier

-
To unsubscribe from this list: send the line "unsubscribe linux-x25" in=
 the body of a message to majordomo@vger.kernel.org More majordomo info=
 at  http://vger.kernel.org/majordomo-info.html
