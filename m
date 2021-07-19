From: <Christian.Gromm@microchip.com>
Subject: Re: [PATCH 4/6 v2] MOST: cdev: rename 'mod_init' & 'mod_exit'
 functions to be module-specific
Date: Mon, 19 Jul 2021 06:45:35 +0000
Message-ID: <787d71b4cb5174bda5a35d5ea44777d994b85e59.camel@microchip.com>
References: <20210711223148.5250-1-rdunlap@infradead.org>
         <20210711223148.5250-5-rdunlap@infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: base64
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1626677139; x=1658213139;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=B9v9LjHyS48ozO8cqr/qcGZJmzCzPKbnmZIM54WmnJQ=;
  b=fhasOlmu0O6X6mtg0qR8cKSW3zFS+ua0DpbPBu6aIXKAdigCK4a8/75h
   6HhcCsViIet6mz3ezQjxn9beKDSSfx0HFZ0FAcFUXyY+N9qbAhLK6ANO3
   TZk8lUPeo4FHsKUAOSQPv34VDwXPAMY45tsx7+ugwj9awKnuE9PKOlEb3
   3AZZOiA8h4H/2rIFWqAreB9XI4mMK6vtdu78kZgWM8oukUyPnENG319Bc
   y+Dhf1TlJ9MMDh/zKKQ3KWg9KVrjeXLGjAcv26MMa9y/qITq/Bfi5i8jO
   GxMSjhDQUoZRD+7AnlDUlFcWsaLfPN6wBmOKl3U2jMt0e27kEbYOhEXWO
   A==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9v9LjHyS48ozO8cqr/qcGZJmzCzPKbnmZIM54WmnJQ=;
 b=MhIUGSrJarc+uzkCMjPkY34UW2pSa8Q96jlU/bH3yzSqVw7gF3CVV1VgqmdtpG831vhCpmMOfj3yYpKmM5/siEMSG9upoWCAXE2D4qi1DV3v9AFpb9xwGmd5Ot5e41jHzE2+jIygqcQ9l69MfuPzFmPIYHfRKx9waCKJ75lHHXw=
In-Reply-To: <20210711223148.5250-5-rdunlap@infradead.org>
Content-Language: en-US
Content-ID: <0B683033EA9D2145B7F6D9BD1097AF7E@namprd11.prod.outlook.com>
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: rdunlap@infradead.org, linux-kernel@vger.kernel.org
Cc: linux-x25@vger.kernel.org, ms@dev.tdt.de, mpm@selenic.com, linux@armlinux.org.uk, wireguard@lists.zx2c4.com, Jason@zx2c4.com, khc@pm.waw.pl, kuba@kernel.org, dilinger@queued.net, linux-arm-kernel@lists.infradead.org, gregkh@linuxfoundation.org, netdev@vger.kernel.org, davem@davemloft.net, arnd@arndb.de, herbert@gondor.apana.org.au, linux-geode@lists.infradead.org, linux-crypto@vger.kernel.org

DQpPbiBTdW4sIDIwMjEtMDctMTEgYXQgMTU6MzEgLTA3MDAsIFJhbmR5IER1bmxhcCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBSZW5hbWUgbW9kdWxl
X2luaXQgJiBtb2R1bGVfZXhpdCBmdW5jdGlvbnMgdGhhdCBhcmUgbmFtZWQNCj4gIm1vZF9pbml0
IiBhbmQgIm1vZF9leGl0IiBzbyB0aGF0IHRoZXkgYXJlIHVuaXF1ZSBpbiBib3RoIHRoZQ0KPiBT
eXN0ZW0ubWFwIGZpbGUgYW5kIGluIGluaXRjYWxsX2RlYnVnIG91dHB1dCBpbnN0ZWFkIG9mIHNo
b3dpbmcNCj4gdXAgYXMgYWxtb3N0IGFub255bW91cyAibW9kX2luaXQiLg0KPiANCj4gVGhpcyBp
cyBoZWxwZnVsIGZvciBkZWJ1Z2dpbmcgYW5kIGluIGRldGVybWluaW5nIGhvdyBsb25nIGNlcnRh
aW4NCj4gbW9kdWxlX2luaXQgY2FsbHMgdGFrZSB0byBleGVjdXRlLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IENjOiBDaHJpc3Rp
YW4gR3JvbW0gPGNocmlzdGlhbi5ncm9tbUBtaWNyb2NoaXAuY29tPg0KPiBDYzogR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4NCj4gLS0tDQo+IHYyOiBubyBj
aGFuZ2UNCj4gDQo+ICBkcml2ZXJzL21vc3QvbW9zdF9jZGV2LmMgfCAgICA4ICsrKystLS0tDQo+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQ0KPiANCj4g
LS0tIGxpbnV4LW5leHQtMjAyMTA3MDgub3JpZy9kcml2ZXJzL21vc3QvbW9zdF9jZGV2LmMNCj4g
KysrIGxpbnV4LW5leHQtMjAyMTA3MDgvZHJpdmVycy9tb3N0L21vc3RfY2Rldi5jDQo+IEBAIC00
ODYsNyArNDg2LDcgQEAgc3RhdGljIHN0cnVjdCBjZGV2X2NvbXBvbmVudCBjb21wID0gew0KPiAg
ICAgICAgIH0sDQo+ICB9Ow0KPiANCj4gLXN0YXRpYyBpbnQgX19pbml0IG1vZF9pbml0KHZvaWQp
DQo+ICtzdGF0aWMgaW50IF9faW5pdCBtb3N0X2NkZXZfaW5pdCh2b2lkKQ0KPiAgew0KPiAgICAg
ICAgIGludCBlcnI7DQo+IA0KPiBAQCAtNTE4LDcgKzUxOCw3IEBAIGRlc3RfaWRhOg0KPiAgICAg
ICAgIHJldHVybiBlcnI7DQo+ICB9DQo+IA0KPiAtc3RhdGljIHZvaWQgX19leGl0IG1vZF9leGl0
KHZvaWQpDQo+ICtzdGF0aWMgdm9pZCBfX2V4aXQgbW9zdF9jZGV2X2V4aXQodm9pZCkNCj4gIHsN
Cj4gICAgICAgICBzdHJ1Y3QgY29tcF9jaGFubmVsICpjLCAqdG1wOw0KPiANCj4gQEAgLTUzNCw4
ICs1MzQsOCBAQCBzdGF0aWMgdm9pZCBfX2V4aXQgbW9kX2V4aXQodm9pZCkNCj4gICAgICAgICBj
bGFzc19kZXN0cm95KGNvbXAuY2xhc3MpOw0KPiAgfQ0KPiANCj4gLW1vZHVsZV9pbml0KG1vZF9p
bml0KTsNCj4gLW1vZHVsZV9leGl0KG1vZF9leGl0KTsNCj4gK21vZHVsZV9pbml0KG1vc3RfY2Rl
dl9pbml0KTsNCj4gK21vZHVsZV9leGl0KG1vc3RfY2Rldl9leGl0KTsNCj4gIE1PRFVMRV9BVVRI
T1IoIkNocmlzdGlhbiBHcm9tbSA8Y2hyaXN0aWFuLmdyb21tQG1pY3JvY2hpcC5jb20+Iik7DQo+
ICBNT0RVTEVfTElDRU5TRSgiR1BMIik7DQo+ICBNT0RVTEVfREVTQ1JJUFRJT04oImNoYXJhY3Rl
ciBkZXZpY2UgY29tcG9uZW50IGZvciBtb3N0Y29yZSIpOw0KDQpBY2tlZC1ieTogQ2hyaXN0aWFu
IEdyb21tIChjaHJpc3RpYW4uZ3JvbW1AbWljcm9jaGlwLmNvbSkNCg0K
