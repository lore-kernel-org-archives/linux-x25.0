From: Marc Kleine-Budde <mkl@pengutronix.de>
Subject: Re: [RFC PATCH 28/28] sock: Remove ->sendpage*() in favour of
 sendmsg(MSG_SPLICE_PAGES)
Date: Thu, 16 Mar 2023 16:57:58 +0100
Message-ID: <20230316155758.5ylpybqjma7x4lbs@pengutronix.de>
References: <20230316152618.711970-1-dhowells@redhat.com>
 <20230316152618.711970-29-dhowells@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="km5oeoth2y26yqyc"
Return-path: <bpf-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20230316152618.711970-29-dhowells@redhat.com>
List-ID: <linux-x25.vger.kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>, Jeff Layton <jlayton@kernel.org>, Christian Brauner <brauner@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, netdev@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org, dccp@vger.kernel.org, linux-afs@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-can@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-hams@vger.kernel.org, linux-rdma@vger.kernel.org, linux-sctp


--km5oeoth2y26yqyc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16.03.2023 15:26:18, David Howells wrote:
> [!] Note: This is a work in progress.  At the moment, some things won't
>     build if this patch is applied.  nvme, kcm, smc, tls.
>=20
> Remove ->sendpage() and ->sendpage_locked().  sendmsg() with
> MSG_SPLICE_PAGES should be used instead.  This allows multiple pages and
> multipage folios to be passed through.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>

> cc: linux-can@vger.kernel.org

Acked-by: Marc Kleine-Budde <mkl@pengutronix.de> # for net/can

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--km5oeoth2y26yqyc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEDs2BvajyNKlf9TJQvlAcSiqKBOgFAmQTPIMACgkQvlAcSiqK
BOj6JAgAtfBV5yq+uNvtDfdNTDCgUnr0pkrsEqo0Ygt0A84TUlJF1K9QFkFTlvFo
NEtegJFeDvbE8EmvRgOnpoTRcMQwDClaw5c7O7TquCr3SEAcXECesFYUVLWR7hsf
Mk3DzSWUNIqMeSUOAEPBPfWNGGQWdjut5IQHdhuIs2/irjgsb5GZJ27rYyV9F/+l
daE1Ac6RGnKq9zV/UszZ7AbfKA7bI9TVioWBVmIFCQZeWJprHq5rD0LTH6+QjdyQ
5AdUTjTbZ/YRTjr4KQQkISfoq8oMC/zVENiagYZ89SGTbciIaCeqBpvdgUVKTob6
2Uoo/o+yUY90Dy8JPw9/gLSsthDGaw==
=IhKV
-----END PGP SIGNATURE-----

--km5oeoth2y26yqyc--
