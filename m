From: John Hughes <john@Calva.COM>
Subject: Re: X25 application problem
Date: Tue, 13 Jan 2004 10:59:59 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <4003C19F.1030208@Calva.COM>
References: <4002D64B.2040601@ati.com.br>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <4002D64B.2040601@ati.com.br>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: Frederico Faria <frederico@ati.com.br>
Cc: linux-x25@vger.kernel.org

Frederico Faria wrote:

> Hi,
>
> I have a client/server application using the X25 in Linux over lapb - 
> ethernet.
>
> I loaded the modules, added the x25 routes  and runs my applications.
>
> My client application dont find the server application. I thinks that 
> I need to associate the server application ( X.121 address = 33 ) with 
> the lapb interface . Is it correct ?
> Any help ?
>
Your X.25 server needs to do a bind to address 33 and a listen.

Just like tcp.

