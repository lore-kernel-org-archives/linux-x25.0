From: Jakub Kicinski <kubakici@wp.pl>
Subject: Re: [PATCH 1/2] wan/hdlc_x25: make lapb params configurable
Date: Tue, 14 Jan 2020 05:45:43 -0800
Message-ID: <20200114054543.576dbf8b@cakuba.hsd1.ca.comcast.net>
References: <20200113124551.2570-1-ms@dev.tdt.de>
        <20200113055316.4e811276@cakuba>
        <83f60f76a0cf602c73361ccdb34cc640@dev.tdt.de>
        <20200114045149.4e97f0ac@cakuba>
        <3b439730f93e29c9e823126b74c2fbd3@dev.tdt.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1579009550; bh=1OCCshn/NahZBP1gvKTaGqss5mpmUoD2DAPD0KfhKvo=;
          h=From:To:Cc:Subject;
          b=B/JnFwJP0YTQ5MWEM8Xjp9XJbCCGcxPqRvYh6grlUxxIwM/8vzqBbR2XVnHyR3gRg
           Y7GFZFp2v/91NdDqQ+NgP+hZkA+uiATwvzF3lnKuecSMTZpZ1BiNen91iCBN1Dv10A
           awohaKHajJnNbkae8aglEM90VbUWmAxTdmPY7Yak=
In-Reply-To: <3b439730f93e29c9e823126b74c2fbd3@dev.tdt.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>
Cc: khc@pm.waw.pl, davem@davemloft.net, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, 14 Jan 2020 14:33:51 +0100, Martin Schiller wrote:
> On 2020-01-14 13:51, Jakub Kicinski wrote:
> > On Tue, 14 Jan 2020 06:37:03 +0100, Martin Schiller wrote:  
> >> >> diff --git a/include/uapi/linux/hdlc/ioctl.h
> >> >> b/include/uapi/linux/hdlc/ioctl.h
> >> >> index 0fe4238e8246..3656ce8b8af0 100644
> >> >> --- a/include/uapi/linux/hdlc/ioctl.h
> >> >> +++ b/include/uapi/linux/hdlc/ioctl.h
> >> >> @@ -3,7 +3,7 @@
> >> >>  #define __HDLC_IOCTL_H__
> >> >>
> >> >>
> >> >> -#define GENERIC_HDLC_VERSION 4	/* For synchronization with sethdlc
> >> >> utility */
> >> >> +#define GENERIC_HDLC_VERSION 5	/* For synchronization with sethdlc
> >> >> utility */  
> >> >
> >> > What's the backward compatibility story in this code?  
> >> 
> >> Well, I thought I have to increment the version to keep the kernel 
> >> code
> >> and the sethdlc utility in sync (like the comment says).  
> > 
> > Perhaps I chose the wrong place for asking this question, IOCTL code
> > was my real worry. I don't think this version number is validated so
> > I think bumping it shouldn't break anything?  
> 
> sethdlc validates the GENERIC_HDLC_VERSION at compile time.
>
> https://mirrors.edge.kernel.org/pub/linux/utils/net/hdlc/

Aw, okay, best not to bump it then.
 
> Another question:
> Where do I have to send my patch for sethdlc to?

No idea :)
