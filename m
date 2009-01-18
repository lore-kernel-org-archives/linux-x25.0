From: Roel Kluin <roel.kluin@gmail.com>
Subject: x.25: x25_rx_call_request() skb->len >= 0 is always true
Date: Sun, 18 Jan 2009 22:46:51 +0100
Message-ID: <4973A34B.9060103@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=veuVBOgmomKyolwyc3zyxu7XixaPjIIKSLjGwS9jFCY=;
        b=N0uqzRELF4tNhxaQBC1q5vu8zKne46yaxBg+ePUJnq/UVK8j0fnu0a9xXEGpL4aWCU
         Q6sAjTmiR248p2wwgMcxCzItWKNp26ju6QoEHaJuoRjtCRas812zR0dUUl20sBYw9I4x
         sktGlDV4fbuvznEAUab7jpCEwhQZaf+PiDLUk=
Sender: linux-x25-owner@vger.kernel.org
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: eis@baty.hanse.de
Cc: linux-x25@vger.kernel.org

since skb->len is unsigned this is always true.

vi net/x25/af_x25.c +954

        if (skb->len >= 0) {
                skb_copy_from_linear_data(skb, makex25->calluserdata.cuddata, skb->len);
                makex25->calluserdata.cudlength = skb->len;
        }

shouldn't we instead do something like 

if (skb->len < LEN_MAX)

and what should LEN_MAX be?
