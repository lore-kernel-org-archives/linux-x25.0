From: "John Hughes" <john@Calva.COM>
Subject: =?iso-8859-1?Q?A_=22fixed=22_version_of_St=E9phane_Fillod's_xotd_for_Linux?=
Date: Mon, 9 Dec 2002 13:27:11 +0100
Sender: linux-x25-owner@vger.kernel.org
Message-ID: <008a01c29f7e$4d02ccc0$f70127d5@britannic>
References: <007901c29f7c$535ed480$f70127d5@britannic>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-x25-owner@vger.kernel.org>
In-Reply-To: <007901c29f7c$535ed480$f70127d5@britannic>
List-Id: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: linux-x25@vger.kernel.org

I've been playing around with xotd-0.04 for a while and have come up
with a version that I think fixes some serious bugs, notably some
problems with lost outbound calls.  (I append my earlier message
describing this problem).

It also allows configuration of multiple remote XOT devices.

---

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

