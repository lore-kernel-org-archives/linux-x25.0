Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=43.163.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795582787;
	b=omI1yAPTzJMk6Wm5O75dY1bSoBjq5AtegIOCeMGB6mvSOKXs1R5UHLTW2Auc7wjk0k5G
	 AT5DIHH/SF5ECBEboDnrjiWYKEWLUt63wCHYkffxUpIUuOXRl0vrzAw1PKs/YJya3i5CN
	 xKybde6SSJ91aq+LtbnOu6/nP5fKXswGEhgkH8mKYWAj1BL77g2UzFozHHULtdWO+LS3Z
	 pKtEyWAp57tv3mPsVaftkQnH2HMP6vekBn0eJ9kBv8Zs77AaI3isApQBB4YJR37cv3jpX
	 9j3jxW17GkCUrK+nnt556l/JdrPUjQWTji5MpjFtFRx36p1IlIjKleQC1nLtdIY8AMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795582787;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:Sender:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BgdStbMane67Ahh1dGa8fdGEQVba1CPuymVqjHDDqxE=;
	b=jda/JMEQj0iO8VUfKFqyD2fB2VF43KCVIcEYRFV7fiJLoLeoiQZh7dtlM43QG+bnwTgz
	 kv0+1jH7JgopbufvkrT7QifgCJDt7a8J/TKEfTKH6y8wCgsO6cJCup/Idi8o/5tGZ0lGZ
	 EIanKklxKeh4WPw1l7/uEnxeq6CV5hsXQv+BmUWqKiU6v0uFZVQBwXtrznn7vsMaWf4xz
	 uuipjvLxfgNHakkKGwIyXfnWUnL5xFqn+IwQQ65NNB5Q8XAR7yEMdOjsU7b5x/o47Abat
	 EPeigw2y6gp72+nO/G7dxUig6W1HPnJAhdpqiOCJQpkTDYov+Kp08zr7s4O44cOM/kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=q8pbGwio;
	arc=none smtp.remote-ip=43.163.128.53
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD19E606A31E;
	Wed, 25 Nov 2026 04:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD19E606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=q8pbGwio
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795582783; bh=BgdStbMane67Ahh1dGa8fdGEQVba1CPuymVqjHDDqxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=q8pbGwiom2Wrc+0v1+ZyWUGD4CIYDi8fPZ/3HBuwoIgcSz9GIySEbbQc2saxo898j
	 4dwUN/0NanxfQ4ixWWNd7uGVEchuzcLHp/l3vdaXDR8pbZI8Aajmx99d9A0qNj5T8f
	 BdAWwxy1NYrzEwtQ4xWUW7yNi9aoLDbweqoRgjZU=
Received: from localhost.localdomain ([240e:360:b507:6a00:cdc3:f6f1:3f3d:301])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id ECD3BE27; Wed, 25 Nov 2026 12:59:13 +0800
X-QQ-mid: xmsmtpt1795582761tc1w4i3r5
Message-ID: <tencent_81EE31BA79E5206415DCD8EE76690A171D08@qq.com>
X-QQ-XMAILINFO: MAzZFSpB7aMJM8YMAeI0tSkT1k8hVyyOxIx/6QYtPvqoPJINCcftzEoDGgBm/2
	 aSm3dmmIVRA4yTg79ELIW8wmSLTtrFv+iX7P8cKATSKbdTDmUbjDaDD2ojITxv2WlmsqK1EXV2QH
	 J7kR4oPB4yTYtF069ZC8bmphCHlW4f0hkoJAa1q0U/XjomrFWBqzWvLez4ji6POkV2AixL6b4N7r
	 TbCJcfIINDe13ed0ADMy2x37c34YehWqs8I5usui/9xUqBfoZ5wzlQErvAVbQWJPuZ40Ro79zf4F
	 49S/8ijzBaYjbEHJ8t/kESOLpKXfHxe/0RF+fYHs1C6V3aPyTH0D7O33pGfWWnHbZSRjngxXKSTn
	 2eB4FAPv2itawXbs9ijSCuigxZZdBlmcUwrRhxrX7W1+KIdjPaZwZmmXnloUvidEgSveUA9zzc4s
	 EVr1kiwrZ9Bq1SrwYkzLY31AY2+tzN9pIxHF0l7EYQKI6WNxVbL4qylpghgBxTJlY1ID7Pyd6NJP
	 C960ED9oeSPcjZe8nclDeIvNHx0iR+u8Rn0WE1oTO3kaMQfnmPlH+CgYMdyHL1w2QZrDUCLP/mAl
	 OmDPEbQMGVHDVJgQf0lVair24uHbIe8kwua3D/d8fMuvD601IXqgFNG6akVRuP2fWrBpsWKVTeFe
	 Eo3yuaxTWbGa7eFE10Ks2C5S10dTBt5wyNSMR8xIT0DZW/pUy1hyHP5SrTkiz99p/R/GByfXyQgE
	 f30z/sfh0BuHbJqN1gaGZTPDmmBWswxLaZ8HMc0Em2765EpSycVQA4UzSjSzjymYNociAoGSmVX1
	 h1FG9lem27UXt4nEFKJoJ1rQPRao8tHyc4HtTVHd2nB8yHldWxLWtdhjKhhOxBW0PlUU5VIAp2PB
	 e2bZ1JRdmm6j8xLB1nS5QdKjNPPCLRGiPea49+MZjtUqWL48agLIq6r+Uk+QwgMvYlM/PUtoqnnk
	 cn23b6P6tkiavLl188dq8xqVTg79aVg/lZEAk2EjIWCKIwqFFcUP1iJwIOGZ5oQPMtdoeKjllZ6C
	 HSSRwku1UKBkm5gZJlyycNry/ed6hMqzykyQ64BWDClcLaUrfbX8BIAUutoIlQt4zQxiE4hZi59D
	 RBaSPFLW0fSJNvdNLTIUJl33/Z1XG1NEnF3ybxJTT3QEhtQPoK+6da5JqQ9ob63vEBcg/MTrdHXq
	 3qAdmJWTDqcr1YpQ/IuUj1h8856uft99hyj6HxScWnlxEGqi9mh3ER3Xrx
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
Sender: superskidder@qq.com
From: Yu Gao <SuperSkidder@qq.com>
To: Martin Schiller <ms@dev.tdt.de>,
	netdev@vger.kernel.org
Cc: linux-x25@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Xie He <xie.he.0141@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	syzbot+059a2795ad4cff2a2695@syzkaller.appspotmail.com,
	syzbot+8328573e4d0514392471@syzkaller.appspotmail.com,
	Yu Gao <SuperSkidder@qq.com>
Subject: [PATCH net 1/2] net: lapbether: don't hold up_lock while calling into LAPB
Date: Wed, 25 Nov 2026 12:59:08 +0800
X-OQ-MSGID: <20261125045909.77644-2-SuperSkidder@qq.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125045909.77644-1-SuperSkidder@qq.com>
References: <20261125045909.77644-1-SuperSkidder@qq.com>
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Post: <mailto:linux-x25@vger.kernel.org>
List-Help: <mailto:linux-x25+help@vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-x25+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lapbeth_xmit() and lapbeth_rcv() hold up_lock while they call into
LAPB, which looks up the device under lapb_list_lock.
lapb_unregister() takes lapb->lock with lapb_list_lock held for
writing, and LAPB transmits frames through lapbeth_data_transmit() with
lapb->lock held. When the Ethernet device under a lapbeth device is a
tunnel whose packets are routed through a lapbeth device, such a frame
reaches lapbeth_xmit() again, under the TX lock of that device and
with its up_lock taken. syzbot reports the resulting cycle as a
possible deadlock in lapb_data_received():

  lapb_list_lock --> _xmit_X25#2 --> &lapbeth->up_lock

up_lock only makes sure that lapbeth_xmit() and lapbeth_rcv() see the
device as up and finish their LAPB calls before lapbeth_close() calls
lapb_unregister(). The same can be had without holding a lock across
the LAPB calls. Both functions run inside an RCU read-side critical
section: lapbeth_rcv() takes rcu_read_lock() and ndo_start_xmit is
called with BH disabled. So clear "up" in lapbeth_close() and wait for
them with synchronize_net() before calling lapb_unregister(), and drop
up_lock.

This also keeps lapbeth_rcv() from deadlocking on up_lock when a frame
that LAPB sends in reply is routed back into the same lapbeth device.

The core still takes the TX lock around lapbeth_xmit(), so a cycle
through _xmit_X25 remains. The next patch removes it.

Fixes: 5acd0cfbfbb5 ("net: lapbether: Prevent racing when checking whether the netif is running")
Reported-by: syzbot+059a2795ad4cff2a2695@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=059a2795ad4cff2a2695
Signed-off-by: Yu Gao <SuperSkidder@qq.com>
---
 drivers/net/wan/lapbether.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/drivers/net/wan/lapbether.c b/drivers/net/wan/lapbether.c
index c3630a8..b4dde9b 100644
--- a/drivers/net/wan/lapbether.c
+++ b/drivers/net/wan/lapbether.c
@@ -53,8 +53,7 @@ struct lapbethdev {
 	struct list_head	node;
 	struct net_device	*ethdev;	/* link to ethernet device */
 	struct net_device	*axdev;		/* lapbeth device (lapb#) */
-	bool			up;
-	spinlock_t		up_lock;	/* Protects "up" */
+	bool			up;		/* See lapbeth_close() */
 	struct sk_buff_head	rx_queue;
 	struct napi_struct	napi;
 };
@@ -126,11 +125,8 @@ static int lapbeth_rcv(struct sk_buff *skb, struct net_device *dev,
 
 	rcu_read_lock();
 	lapbeth = lapbeth_get_x25_dev(dev);
-	if (!lapbeth)
+	if (!lapbeth || !READ_ONCE(lapbeth->up))
 		goto drop_unlock_rcu;
-	spin_lock_bh(&lapbeth->up_lock);
-	if (!lapbeth->up)
-		goto drop_unlock;
 
 	len = skb->data[0] + skb->data[1] * 256;
 	dev->stats.rx_packets++;
@@ -142,15 +138,10 @@ static int lapbeth_rcv(struct sk_buff *skb, struct net_device *dev,
 	err = lapb_data_received(lapbeth->axdev, skb);
 	if (err != LAPB_OK) {
 		printk(KERN_DEBUG "lapbether: lapb_data_received err - %d\n", err);
-		goto drop_unlock;
+		goto drop_unlock_rcu;
 	}
-out:
-	spin_unlock_bh(&lapbeth->up_lock);
 	rcu_read_unlock();
 	return 0;
-drop_unlock:
-	kfree_skb(skb);
-	goto out;
 drop_unlock_rcu:
 	rcu_read_unlock();
 drop:
@@ -188,8 +179,7 @@ static netdev_tx_t lapbeth_xmit(struct sk_buff *skb,
 	struct lapbethdev *lapbeth = netdev_priv(dev);
 	int err;
 
-	spin_lock_bh(&lapbeth->up_lock);
-	if (!lapbeth->up)
+	if (!READ_ONCE(lapbeth->up))
 		goto drop;
 
 	/* There should be a pseudo header of 1 byte added by upper layers.
@@ -226,12 +216,10 @@ static netdev_tx_t lapbeth_xmit(struct sk_buff *skb,
 		pr_err("lapb_data_request error - %d\n", err);
 		goto drop;
 	}
-out:
-	spin_unlock_bh(&lapbeth->up_lock);
 	return NETDEV_TX_OK;
 drop:
 	kfree_skb(skb);
-	goto out;
+	return NETDEV_TX_OK;
 }
 
 static void lapbeth_data_transmit(struct net_device *ndev, struct sk_buff *skb)
@@ -331,9 +319,7 @@ static int lapbeth_open(struct net_device *dev)
 		return -ENODEV;
 	}
 
-	spin_lock_bh(&lapbeth->up_lock);
-	lapbeth->up = true;
-	spin_unlock_bh(&lapbeth->up_lock);
+	WRITE_ONCE(lapbeth->up, true);
 
 	return 0;
 }
@@ -343,9 +329,13 @@ static int lapbeth_close(struct net_device *dev)
 	struct lapbethdev *lapbeth = netdev_priv(dev);
 	int err;
 
-	spin_lock_bh(&lapbeth->up_lock);
-	lapbeth->up = false;
-	spin_unlock_bh(&lapbeth->up_lock);
+	/* lapbeth_xmit() and lapbeth_rcv() only call into LAPB after seeing
+	 * "up" set, from within an RCU read-side critical section. Wait for
+	 * them to finish so that none of these calls races with
+	 * lapb_unregister().
+	 */
+	WRITE_ONCE(lapbeth->up, false);
+	synchronize_net();
 
 	err = lapb_unregister(dev);
 	if (err != LAPB_OK)
@@ -411,7 +401,6 @@ static int lapbeth_new_device(struct net_device *dev)
 	lapbeth->ethdev = dev;
 
 	lapbeth->up = false;
-	spin_lock_init(&lapbeth->up_lock);
 
 	skb_queue_head_init(&lapbeth->rx_queue);
 	netif_napi_add_weight(ndev, &lapbeth->napi, lapbeth_napi_poll, 16);
-- 
2.54.0 (Apple Git-157)

