From: Xie He <xie.he.0141@gmail.com>
Subject: [PATCH net-next] net: lapb: Make "lapb_t1timer_running" able to detect an already running timer
Date: Sun, 21 Mar 2021 00:53:16 -0700
Message-ID: <20210321075316.90385-1-xie.he.0141@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-x25-owner@vger.kernel.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YMMQWqv0WQD77AlOgo+glNplzrUfg5GTEMFWXwVjL0=;
        b=IPuWVof6WPFXhMXb4yA4nsWGYwzZqcCkry3NLfhR26kRgj4egffTt3VhVVwXNM/Lhp
         FsZB2Auj2IQUp78Tf5QMlDELd66RtrLS6vRdXEekT1zvlZgrJzSZkBtUy6v4xYRYJLr2
         6g95gTJO/PEXmqbRYuPF5pYN9q9okPXdE05tNJ21iRSHztf1/vZxoXt/L9+LOgYT8JMq
         N8MXglHLG+cYCgeYynBxMA13BjCoaJOQ1eUDDITTdo7p7N0PcVBOeQGOT18n1htK7Uv/
         gsND702wGZZeiQNuQxitH0eUmE9pzdCpIZDTamvcWWFhCm64HI4uqq/iUiMYmrGBofOP
         xEOA==
List-ID: <linux-x25.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Martin Schiller <ms@dev.tdt.de>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, linux-x25@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Xie He <xie.he.0141@gmail.com>

Problem:

The "lapb_t1timer_running" function in "lapb_timer.c" is used in only
one place: in the "lapb_kick" function in "lapb_out.c". "lapb_kick" calls
"lapb_t1timer_running" to check if the timer is already pending, and if
it is not, schedule it to run.

However, if the timer has already fired and is running, and is waiting to
get the "lapb->lock" lock, "lapb_t1timer_running" will not detect this,
and "lapb_kick" will then schedule a new timer, which causes the old
timer to be aborted.

I think this is not right. The purpose of "lapb_kick" should be ensuring
that the actual work of the timer function is scheduled to be done.
If the timer function is already running but waiting for the lock,
"lapb_kick" should not abort and reschedule it.

Changes made:

I added a new field "t1timer_running" in "struct lapb_cb" for
"lapb_t1timer_running" to use. "t1timer_running" will accurately reflect
whether the actual work of the timer is pending. If the timer has fired
but is still waiting for the lock, "t1timer_running" will still correctly
reflect whether the actual work is waiting to be done.

The old "t1timer_stop" field, whose only responsibility is to ask a timer
(that is already running but waiting for the lock) to abort, is no longer
needed, because the new "t1timer_running" field can fully take over its
responsibility. Therefore "t1timer_stop" is deleted.

"t1timer_running" is not simply a negation of the old "t1timer_stop".
At the end of the timer function, if it does not reschedule itself,
"t1timer_running" is set to false to indicate that the timer is stopped.

For consistency of the code, I also added "t2timer_running" and deleted
"t2timer_stop".

Signed-off-by: Xie He <xie.he.0141@gmail.com>
---
 include/net/lapb.h    |  2 +-
 net/lapb/lapb_iface.c |  4 ++--
 net/lapb/lapb_timer.c | 19 ++++++++++++-------
 3 files changed, 15 insertions(+), 10 deletions(-)

diff --git a/include/net/lapb.h b/include/net/lapb.h
index eee73442a1ba..124ee122f2c8 100644
--- a/include/net/lapb.h
+++ b/include/net/lapb.h
@@ -92,7 +92,7 @@ struct lapb_cb {
 	unsigned short		n2, n2count;
 	unsigned short		t1, t2;
 	struct timer_list	t1timer, t2timer;
-	bool			t1timer_stop, t2timer_stop;
+	bool			t1timer_running, t2timer_running;
 
 	/* Internal control information */
 	struct sk_buff_head	write_queue;
diff --git a/net/lapb/lapb_iface.c b/net/lapb/lapb_iface.c
index 0511bbe4af7b..1078e14f1acf 100644
--- a/net/lapb/lapb_iface.c
+++ b/net/lapb/lapb_iface.c
@@ -122,8 +122,8 @@ static struct lapb_cb *lapb_create_cb(void)
 
 	timer_setup(&lapb->t1timer, NULL, 0);
 	timer_setup(&lapb->t2timer, NULL, 0);
-	lapb->t1timer_stop = true;
-	lapb->t2timer_stop = true;
+	lapb->t1timer_running = false;
+	lapb->t2timer_running = false;
 
 	lapb->t1      = LAPB_DEFAULT_T1;
 	lapb->t2      = LAPB_DEFAULT_T2;
diff --git a/net/lapb/lapb_timer.c b/net/lapb/lapb_timer.c
index 0230b272b7d1..5be68869064d 100644
--- a/net/lapb/lapb_timer.c
+++ b/net/lapb/lapb_timer.c
@@ -40,7 +40,7 @@ void lapb_start_t1timer(struct lapb_cb *lapb)
 	lapb->t1timer.function = lapb_t1timer_expiry;
 	lapb->t1timer.expires  = jiffies + lapb->t1;
 
-	lapb->t1timer_stop = false;
+	lapb->t1timer_running = true;
 	add_timer(&lapb->t1timer);
 }
 
@@ -51,25 +51,25 @@ void lapb_start_t2timer(struct lapb_cb *lapb)
 	lapb->t2timer.function = lapb_t2timer_expiry;
 	lapb->t2timer.expires  = jiffies + lapb->t2;
 
-	lapb->t2timer_stop = false;
+	lapb->t2timer_running = true;
 	add_timer(&lapb->t2timer);
 }
 
 void lapb_stop_t1timer(struct lapb_cb *lapb)
 {
-	lapb->t1timer_stop = true;
+	lapb->t1timer_running = false;
 	del_timer(&lapb->t1timer);
 }
 
 void lapb_stop_t2timer(struct lapb_cb *lapb)
 {
-	lapb->t2timer_stop = true;
+	lapb->t2timer_running = false;
 	del_timer(&lapb->t2timer);
 }
 
 int lapb_t1timer_running(struct lapb_cb *lapb)
 {
-	return timer_pending(&lapb->t1timer);
+	return lapb->t1timer_running;
 }
 
 static void lapb_t2timer_expiry(struct timer_list *t)
@@ -79,13 +79,14 @@ static void lapb_t2timer_expiry(struct timer_list *t)
 	spin_lock_bh(&lapb->lock);
 	if (timer_pending(&lapb->t2timer)) /* A new timer has been set up */
 		goto out;
-	if (lapb->t2timer_stop) /* The timer has been stopped */
+	if (!lapb->t2timer_running) /* The timer has been stopped */
 		goto out;
 
 	if (lapb->condition & LAPB_ACK_PENDING_CONDITION) {
 		lapb->condition &= ~LAPB_ACK_PENDING_CONDITION;
 		lapb_timeout_response(lapb);
 	}
+	lapb->t2timer_running = false;
 
 out:
 	spin_unlock_bh(&lapb->lock);
@@ -98,7 +99,7 @@ static void lapb_t1timer_expiry(struct timer_list *t)
 	spin_lock_bh(&lapb->lock);
 	if (timer_pending(&lapb->t1timer)) /* A new timer has been set up */
 		goto out;
-	if (lapb->t1timer_stop) /* The timer has been stopped */
+	if (!lapb->t1timer_running) /* The timer has been stopped */
 		goto out;
 
 	switch (lapb->state) {
@@ -127,6 +128,7 @@ static void lapb_t1timer_expiry(struct timer_list *t)
 				lapb->state = LAPB_STATE_0;
 				lapb_disconnect_indication(lapb, LAPB_TIMEDOUT);
 				lapb_dbg(0, "(%p) S1 -> S0\n", lapb->dev);
+				lapb->t1timer_running = false;
 				goto out;
 			} else {
 				lapb->n2count++;
@@ -151,6 +153,7 @@ static void lapb_t1timer_expiry(struct timer_list *t)
 				lapb->state = LAPB_STATE_0;
 				lapb_disconnect_confirmation(lapb, LAPB_TIMEDOUT);
 				lapb_dbg(0, "(%p) S2 -> S0\n", lapb->dev);
+				lapb->t1timer_running = false;
 				goto out;
 			} else {
 				lapb->n2count++;
@@ -169,6 +172,7 @@ static void lapb_t1timer_expiry(struct timer_list *t)
 				lapb_stop_t2timer(lapb);
 				lapb_disconnect_indication(lapb, LAPB_TIMEDOUT);
 				lapb_dbg(0, "(%p) S3 -> S0\n", lapb->dev);
+				lapb->t1timer_running = false;
 				goto out;
 			} else {
 				lapb->n2count++;
@@ -186,6 +190,7 @@ static void lapb_t1timer_expiry(struct timer_list *t)
 				lapb->state = LAPB_STATE_0;
 				lapb_disconnect_indication(lapb, LAPB_TIMEDOUT);
 				lapb_dbg(0, "(%p) S4 -> S0\n", lapb->dev);
+				lapb->t1timer_running = false;
 				goto out;
 			} else {
 				lapb->n2count++;
-- 
2.27.0

