From: John Hughes <john@Calva.COM>
Subject: Re: Linux's X.25 and Isode
Date: Tue, 26 Oct 2004 14:44:41 +0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <417E46B9.5050208@Calva.COM>
References: <I66JXT01.009@metrored-telecom.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <I66JXT01.009@metrored-telecom.com>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: "Francisco A. Lozano Lopez" <francisco.lozano@metrored-telecom.com>
Cc: 'Andrew Hendry' <ahendry@tusc.com.au>, linux-x25@vger.kernel.org

Francisco A. Lozano Lopez wrote:

>This patch enables ISODE to work under Linux, but I thought it was only for
>ISO/OSI through TCP/IP. 
>Has anyone managed to make it work with Linux's X.25? In the config.h file,
>if you define X_25 it doesn't compile :(
>  
>
All you have to do is write the X.25 interface routines in the compat 
directory.

Make a linuxx25.c based on  ubcx25.c, patch x25addr.c to know about the 
Linux X.25 socket level.

You might have problems with Linux X.25's stupid non-handling of the M bit.


