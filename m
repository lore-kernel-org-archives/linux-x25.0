From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [PATCH net] net: lapb: Copy the skb before sending a packet
Date: Tue, 2 Feb 2021 09:04:07 +0000
Message-ID: <6da2329e69d247daac6c6d7d442f0e38@AcuMS.aculab.com>
References: <20210201055706.415842-1-xie.he.0141@gmail.com>
 <4d1988d9-6439-ae37-697c-d2b970450498@linux.ibm.com>
 <CAJht_EOw4d9h7LqOsXpucADV5=gAGws-fKj5q7BdH2+h0Yv9Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <CAJht_EOw4d9h7LqOsXpucADV5=gAGws-fKj5q7BdH2+h0Yv9Vg@mail.gmail.com>
Content-Language: en-US
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'Xie He' <xie.he.0141@gmail.com>, Julian Wiedmann <jwi@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Linux X25 <linux-x25@vger.kernel.org>, Linux Kernel Network Developers <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Martin Schiller <ms@dev.tdt.de>

RnJvbTogWGllIEhlDQo+IFNlbnQ6IDAxIEZlYnJ1YXJ5IDIwMjEgMTY6MTUNCj4gDQo+IE9uIE1v
biwgRmViIDEsIDIwMjEgYXQgNjoxMCBBTSBKdWxpYW4gV2llZG1hbm4gPGp3aUBsaW51eC5pYm0u
Y29tPiB3cm90ZToNCj4gPg0KPiA+IFRoaXMgc291bmRzIGEgYml0IGxpa2UgeW91IHdhbnQgc2ti
X2Nvd19oZWFkKCkgLi4uID8NCj4gDQo+IENhbGxpbmcgInNrYl9jb3dfaGVhZCIgYmVmb3JlIHdl
IGNhbGwgInNrYl9jbG9uZSIgd291bGQgaW5kZWVkIHNvbHZlDQo+IHRoZSBwcm9ibGVtIG9mIHdy
aXRlcyB0byBvdXIgY2xvbmVzIGFmZmVjdGluZyBjbG9uZXMgaW4gb3RoZXIgcGFydHMgb2YNCj4g
dGhlIHN5c3RlbS4gQnV0IHNpbmNlIHdlIGFyZSBzdGlsbCB3cml0aW5nIHRvIHRoZSBza2IgYWZ0
ZXINCj4gInNrYl9jbG9uZSIsIGl0J2Qgc3RpbGwgYmUgYmV0dGVyIHRvIHJlcGxhY2UgInNrYl9j
bG9uZSIgd2l0aA0KPiAic2tiX2NvcHkiIHRvIGF2b2lkIGludGVyZmVyZW5jZSBiZXR3ZWVuIG91
ciBvd24gY2xvbmVzLg0KDQpXaGF0IGlzIHRoZSBmYXN0ZXN0IGxpbmsgbGFwYiBpcyBhY3R1YWxs
eSB1c2VkIG9uIHRoZXNlIGRheXM/DQo2NGsgdXNlZCB0byBiZSAnZmFzdCcgLSBzbyBjb3B5aW5n
IHRoZSBza2IgaXNuJ3QgZ29pbmcgdG8gaGF2ZQ0KYSBub3RpY2VhYmxlIGVmZmVjdCBvbiBzeXN0
ZW0gcGVyZm9ybWFuY2UuDQoNCldlIGRpZCBvbmNlIGdldCBhICdmcmVlJyB1cGdyYWRlIG9mIG91
ciBYLjI1IGxpbmsgZnJvbSAyNDAwIHRvIDk2MDAuDQpQcm9iYWJseSBkdWUgdG8gdGhlIHBvd2Vy
IGNvbnN1bXB0aW9uIGFuZCByYWNrIHNwYWNlIG5lZWRlZCBmb3INCnRoZSBvbGRlciBtb2RlbS4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==

