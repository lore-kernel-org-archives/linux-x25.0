Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602AC34251B;
	Mon,  3 Aug 2026 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756197; cv=fail; b=ri7otxOIbT5V5KC1+OoTwEFzMW3ymiWrKQN0j5RKMyGoayDvr8bcd2ULu5X9OFhFVYy5LsN02ZQvXnsBICgZhlolKSCjzyiVsSX82JlDvUdpguzo1GUo8CtpNvt2WuwILKxPNNeg9hfV6RJEccxcCMwf21WCchMg06NmOHxkLQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756197; c=relaxed/simple;
	bh=pndmx137MpB8CoN0MbKLOnzg4LcxQCHwLRU7q/2/7rE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hiI1A0FMbKhfaItvMz2zDhCdHx+7HWCKMdDrH1hjKRHkQlMzXglERENdoMkiKZjch3Rh0tWcG9/Ks/sxPTCsV8MmsjMcEvtMOCfb1wZpQqc75agTXU1DU9227Bf/uwqTiP/AC+lCTXTN9HhPWSwIb9Cya38X29BcLHpnaeeTm6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hCGfZPO7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hCGfZPO7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785756196; x=1817292196;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pndmx137MpB8CoN0MbKLOnzg4LcxQCHwLRU7q/2/7rE=;
  b=hCGfZPO7f1Dx2unkvO4xesCV1VHv7CwaiwfDNGE4+HZ4gfgLJPzPrvzl
   mBWKg50MLSzWjbGZJkerp9xPtLypr5TQ1G9Kp4uh7vMvjyOnvtTAMokm7
   t4q+HdQGohA7J4K70r4tYNY0QbMagxSG6uhdB3XGa5Jl2j/R8QZ9ZwbRp
   +01g05tFwStAJ8dIdunOnch4NMcT00RHE/92+viFq+QYu7aZLEQW+VF64
   qjvxE5GmVp4amW2H5TogRB8Fq4UcRAwkTZRxZT28bFesVGyl1/XGxRMI8
   q8MhhCe6YwgSjdY9xddPws46SBJyojfbHw08gs3GXCRF7QtS5rOLd7f1N
   A==;
X-CSE-ConnectionGUID: BEQmruXPTL2Acx750G4gYQ==
X-CSE-MsgGUID: JBf+nVWqSiKgwek76bOncg==
X-IronPort-AV: E=McAfee;i="6800,10657,11863"; a="97801836"
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="97801836"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 04:23:15 -0700
X-CSE-ConnectionGUID: EaMxMNw2SRyXiVZRDq+kbg==
X-CSE-MsgGUID: VjccSUFgQAiwXWegDnImEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,202,1779174000"; 
   d="scan'208";a="259396883"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 04:23:14 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 04:23:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 3 Aug 2026 04:23:14 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 3 Aug 2026 04:23:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBXjpX4gWTIKttRqlRFEpmao0l/KFwZ1jT50CAdvD9bNhxdiiVPRsdMBPz4HQ6V+VB6P3pQpAkYkUg/l8IP5iJLFplxNGoz28AuZAwCf34PvvrrVFGnHNe6o0yphNEP+gbSGBlGMQ9vkgQvnN/RGeuKntAGdSNJNV772M7wZWeRllvBtc7RqwrIZR4OmoZm0nekWEtTnDzwGpWhzB3ZI4meA0HODKoYAukv5QEea1+tkcjACepXIwCH/KKeuzjGqzJc25o/gBXWnHrneZWVkTVLgBCG1QQmU60JePSS9v+FTvhVF7kKgx/OP3v6TlChRbrrPGxS29Yeq0E6Mxpqchg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pndmx137MpB8CoN0MbKLOnzg4LcxQCHwLRU7q/2/7rE=;
 b=x8rG6jBCO7FHgYh/I3yO/pklH7xCnwoTt5Yb2WDKJTWPbOhn/W0w/FMra5AQJVJ/2Br2favEOxtJNYoyNWqVI/wmnarT5mZG0K2xr/LZ6xkxuXA52qrxTHTGKkfRAIwh82glg1kniTSRd//N4MjVdFA1oJCS6eM5jnbCCc+Ovrf8c3fSwsb0Szqr+xv+eFFG2BivACODlCOXoGQAo/pSt4NEQ3iNQJVyT6OQ5QTL3ky5ssu+3gRkxX8q2i5Buhm1QsG37UXLAN0BQDtdhkC5jnwGHUAkOyRrcEhNetNldEApvQ3rU6Kgeo3nz13F3FIh12K70qbdI+H3UR33ktSzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5902.namprd11.prod.outlook.com (2603:10b6:510:14d::19)
 by DS0PR11MB7190.namprd11.prod.outlook.com (2603:10b6:8:132::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Mon, 3 Aug
 2026 11:23:11 +0000
Received: from PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37]) by PH0PR11MB5902.namprd11.prod.outlook.com
 ([fe80::f95a:602a:34d3:5d37%4]) with mapi id 15.21.0270.016; Mon, 3 Aug 2026
 11:23:11 +0000
From: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>
To: Minhong He <heminhong@kylinos.cn>, Martin Schiller <ms@dev.tdt.de>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "linux-x25@vger.kernel.org" <linux-x25@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: lapbether: check register_netdevice_notifier()
 error in lapbeth_init_driver()
Thread-Topic: [PATCH net] net: lapbether: check register_netdevice_notifier()
 error in lapbeth_init_driver()
Thread-Index: AQHdIyat2ElwCtyXIkyeW4HwdaqcK7aMLbHA
Date: Mon, 3 Aug 2026 11:23:11 +0000
Message-ID: <PH0PR11MB5902AD4B873E7F99D36A9DB3F0D52@PH0PR11MB5902.namprd11.prod.outlook.com>
References: <20260803085936.142160-1-heminhong@kylinos.cn>
In-Reply-To: <20260803085936.142160-1-heminhong@kylinos.cn>
Accept-Language: pl-PL, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR11MB5902:EE_|DS0PR11MB7190:EE_
x-ms-office365-filtering-correlation-id: 20973ec3-0000-4022-353a-08def1519a1a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|38070700021|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: N+a0syPs6Hf3LdH3BK1jPst0PmIdsWKgWRcPfObxvyadkkw7Ih4MFvO9j4IicBOnD4+xmiMOj+69/tnoZRmzqJn2UQ+5q7bVKnMsBoYNukveGObBsgsw8l9V820gQ3QYNei8nhVRhoN1eNTClVUrM57mQiz/qo92l8W6M2JiM0Gh2CLLn9P8a2Z7WAYwzVKR8+Q3QLkYAZTi1U+nhD8EqxSwI7molNfPUVNp/E6IsayAWd/0gR1KGLJjy5jwdKcmUwZT8pvQHJ9dtDm94P/GMu9RNW4ecWJm6Gq+d2S3gzlhVlfDI3yiOKXUL4Kt5VhdWpOaYDR0EUtoWbtGbrhGvXWSNdgfMbbY105Z+itjrtRtGg4k1MRTRMH+IjyAEUYXfiPn4g/IWPxMdd0z64yOcJ8zbRUho+U5U6fjJd+bkaScFl+NnHjswm25MVmrRrR3wR2EuAP3ED0NzZ+QuI51acipUDg+FdSyUUYgCwfnhgUxtbpa3yTKkNWNKhQbb9b6eeMGyxs2cB/JAjXlo6OLPH1NWIRAg6h4Bt6cX7TwLmNC17WbDAA6b9MvIkTSyI+wfSVjH0VMtVUUFezbbUIPBc93dGMqpWvEoGy/B2xmZ3NKC4mB1szvbZ+KjrSQHUro5LqMYdAUciR1BFFoqAxJBmCeI8M89Fu+JLihgfeqpJskVNJG8PeQIgDwD9b8UEA2xOwRL28B2oifap+lfE517dHUks0sYRKuNueCM+z3rEo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5902.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b41ZwZy6Ptj2o3bXAp9WQ4WSQCvhjc8L64tifvCQp88VIOJNTVsZ1q1PzHJ7?=
 =?us-ascii?Q?ga86xjM0R2yL4y9tTNJzor/e6dv8jzkoi3JSGcTQr5+F81p5DULVywkPpaOw?=
 =?us-ascii?Q?9mPge5jtJMUErFTQ0RlvrxfDLiI2PrR3nkfeqzMep/oBY3BHj4ot0u9jU9W5?=
 =?us-ascii?Q?3fRb0S9SvB4mSPvVCRP1aWv3Lh4RGUEid2HxuJ3h8QbKR+MU33nd1JouRE1s?=
 =?us-ascii?Q?bnNQDXTebVzHZLybckn3AGavJebXHcgRMykoBQvNF0C+GYxmcYXy9QJlTwJc?=
 =?us-ascii?Q?soZoTJUNyxhHLseWeL6RWo8nDUSkxvLmIzEjhr8dRZAH2rWIHndpBGNBu624?=
 =?us-ascii?Q?tnIHn4TmhBBJ8YvK4oYD1FFYsrcppkNou5VNukKFoMCxnyRX7KAMbCS9x7T/?=
 =?us-ascii?Q?7uKhcvO9Zaq+ZXVxEPW9czf+A3/Z/bXMcE7durbUyqP0ipJARv7512R7Havw?=
 =?us-ascii?Q?uz02fxSUy2VfJpjISH+ZBf193K7sJSI8Y8M6Vo+r8N94v5UkqoHtXRz+lOMq?=
 =?us-ascii?Q?qKbrmfOWZR9j+JntMp4yPb7E+ft3oGKeDfY8iP1HPyIXeuoRzSd/KbcT6aSg?=
 =?us-ascii?Q?vGLVmLz0yLQrna+Oqx+RaoY7A5cYBbrWnRomct7UjzQD2sgxVtErbJdtHqyu?=
 =?us-ascii?Q?fqbLDzuwxCFVn8Z4CNclStsDqYKaiEu86+OP8RPBQfFAmbzTG07gNpob9d2M?=
 =?us-ascii?Q?t+iv221WyonIKlewN0EVTjbK4n4t7oeSHomx/XZfwXZyi66G0LzXx9/lv4bn?=
 =?us-ascii?Q?OMDUUnmLbsVxbm1EHWPg8k3vpRqKhmfPqjC1I9H8axF7pQw9FsdjwGAhJTCN?=
 =?us-ascii?Q?r6LXWiow5Qd6upvUB7MxCV6bQgOZj+8KbTWGMwvrbIjHL20yQexaTgBeweeq?=
 =?us-ascii?Q?tap4sMYQohBz5kZBkotd1/Sl9TfAc8Y9Abg8O8+8bUU+YxqvuwO6p0ynmPaI?=
 =?us-ascii?Q?Skom5s4DU/KhXh/2XjL7LgxytZMyBG9cD7NSqut/Uha5Y3CmywJPgwnk7kIc?=
 =?us-ascii?Q?sIbiUS2I4MTNCNj6k/3VrSfUQDvWQIVja4qumifHqkomG02aw56vXgw5oyk0?=
 =?us-ascii?Q?KvNQUUY2ARU5nYsAt7BRZTYEUsSviDxPGrVYl/Cm8PYcm3XPPZsyaLW8NVdk?=
 =?us-ascii?Q?bBNqkbEiLnkP+IX9heGZnsPHGb+fiXbTWbpwDjWY7CNLuknUwDzfM/m3PzwY?=
 =?us-ascii?Q?jCL0B3NCsyJ9tEoXATSHU4riwlNlBaD76YLSjX5zih0Yk28sktiqrQcneR3q?=
 =?us-ascii?Q?YfNKOeMU2gG6hm1GDaaq3m0ixW9INJrw28UaHS2XiuEHhgeENRhcdCWwKZCt?=
 =?us-ascii?Q?8gRZdn9Daf9tHnVZrwB17/C8P+yStIe6YPgxnKLRkkWBtFVp1vtEfxq7/P98?=
 =?us-ascii?Q?8BAd4Ax73B1eO7v6nArLC8ndC0Dys3d+J5BCeUXJVWKkEx/AUe7eCLRhz9hF?=
 =?us-ascii?Q?ALyTaMBs8zDxR7pmOt5KkxwTNNcF7mccuxIJdb8I+i8UUZ9Ba5laj1bPjxyZ?=
 =?us-ascii?Q?Ugqy8gRqCNFVdEoUxOR5XBT6gKYIfTuTAAoCdK7LgS/Q2Rxr3SnnDMnvTBZi?=
 =?us-ascii?Q?GBCH9T90Xud5wWnIkptYGFGfDL77kRRQy6sqE0i6W6gXS5nRoAJQiS94V44c?=
 =?us-ascii?Q?ma+elRPcNdQDn4FnO4/AU3P+tAyDZGUuCi1m7JOKGCdzGBXUmDVbRyb0C4O0?=
 =?us-ascii?Q?uT7AP3QOzxoIb11VKFSPQSG6AYTfhunTDw59shyuGQey5cpBnQWrD7yP79tb?=
 =?us-ascii?Q?CcSuQjw4xA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: DNXoaF2G1P+h+cXaEfrxm5aXj/wRHcdDZxb5tXv+gMeUPdU2vUgOskZ5dayOREqun/g1giu3KuVZHgOT8Jtcd8pqypRlFFXLrgOPlBZ8T0MPMwJm0SFRLrTkv/Ec6I9jnk6wvsUuQqCQ7FtDXsrTOViPXfLiqgAouAkFgqwfreRAIkrjGzsZ28onF518DXakckMRU+IPzP+vhH8zXpf/5OBBl4wVxnmxUvX+nmdjP9DFjM6/2LH1PrUiB/BCt4N3v/aTBCYVlhrpXBMtRYNcOgbgjVp/Jim06A27ZljYspffVkhHs473lLaz/Mjkoae3WKxVgCrpjoWaRCTIH9KfzQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5902.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20973ec3-0000-4022-353a-08def1519a1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2026 11:23:11.2924
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dD0IK6W6296Qnf+MjPXpqkDMOQt3B3ejkYVa1i72+8Rwa1g+mvXO3SM3hjYhWNSpxECW93XSfvoDRddoBQnXmOVBK6wic+Znx31rd63mncM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7190
X-OriginatorOrg: intel.com

From: Minhong He <heminhong@kylinos.cn>=20
Sent: Monday, August 3, 2026 11:00 AM

>lapbeth_init_driver() ignores register_netdevice_notifier() errors and
>always returns success, which can leave the module loaded without its
>netdev notifier registered.
>
>Check the error and remove the packet type on failure.
>
>Signed-off-by: Minhong He <heminhong@kylinos.cn>


Hi Minhong

why do not gather all the patches into single series, all of them seem
to be doing similar things. that could help to deal with them in more
organized way

I believe also fixes tags might be missing
