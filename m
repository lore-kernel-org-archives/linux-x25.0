From: "John Hughes" <John@Calva.COM>
Subject: RE : XOT
Date: Tue, 8 Oct 2002 17:04:38 +0200
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <008001c26edc$06596ea0$f70127d5@britannic>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: 
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: 'John Hughes' <John@Calva.COM>, 'Ian Cass' <ian.cass@mblox.com>
Cc: linux-x25@vger.kernel.org

I said:

> I'm having a little problem making Linux xotd work with my
> home grown implementation, but I think I've tracked it down
> to a difference of opinion about when the TCP call should be
> cleared.

The way xotd works is that it clears the TCP call if it
recieves an X.25 CLEAR CONFIRMATION:

	void *tap_writer(void *arg)
	{
	...
	    while (1) {

	        nread = readn(sockfd,(unsigned char*)&header,
	                      sizeof(struct xot_header));
	        if (nread != sizeof(struct xot_header)) {
	...
	             break;  /* abort */
	        }
	...

	    }

	    if (isVerbose)
	        printd("TCP connection closed (tap writer), 
	               lci=%d.",curr_lci);

	    hash_remove(&hash_table, sockfd, lci);

	    close(sockfd);      /* TODO: add to a spare list, 
	                           for use by tap_reader */

This seems reasonable.  *BUT* if xotd SENDS a CLEAR CONFIRMATION,
in the other direction it does not clear the call, it keeps it
open and will re-use it for new connections.  (It used to clear
the call, but as of version 0.04 this is commented out).

Now imagine what happens when two of these xotd's are talking
together - 

xotd#1                            xotd#2         
send clear conf >----\
                      \----------> Get clear conf
                                           |
                        /--------< Clear TCP call
Send new call >----\   /
                    \ /
                     X
                    / 
Eurgh          <---/

Whoops! the new call has been sent on a socket that has been
closed by the other side.
                    


