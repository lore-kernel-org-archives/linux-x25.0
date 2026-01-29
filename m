Received: from mail-ua1-f68.google.com (mail-ua1-f68.google.com [209.85.222.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D00E7340A69
	for <linux-x25@vger.kernel.org>; Thu, 29 Jan 2026 10:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681667; cv=none; b=r1c/LMTEpg9lYm/IkQuN+9hgdQz36XcH+1hmEyBgBC8bNi3ZOUEAD82tvPzUZXlrYqXIodwxf84554nB7DnysWFXZnZ/PS63llj/9dKr6kWLagywTJIG8QHlTM1w/yJ30UWu6PTbwmzpxCC73a2bIkD9nZLBfJ1kPXKLRDeY9Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681667; c=relaxed/simple;
	bh=MI+D2Ic6bz3jYMbMxWU4odca96W1KdTlxUzB6WUQDjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Npyg02Jpj26Yjb6UiSt6U88/qgV5mk9AahN3tl+1oOyGXpCw9E7T8DUru1Kle87t3uOWUsqpqSiZclhLtDLIFEW9W/w8cxQWMKffz+hGRXGgyWvAOz8YvHmRsV3H5VYwQOdv1Xjaot4wQZVzuhWBA7RkRjRZ5njlsdiouwOIN6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XX2umLHa; arc=none smtp.client-ip=209.85.222.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XX2umLHa"
Received: by mail-ua1-f68.google.com with SMTP id a1e0cc1a2514c-94120e0acbeso471520241.2
        for <linux-x25@vger.kernel.org>; Thu, 29 Jan 2026 02:14:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769681665; x=1770286465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LEB8Yp/SddLVwrY1R6Js1dQZWhnZcm4xY82a3ZUzWc4=;
        b=XX2umLHaIWjh0KhSOEjYcmWeMyvb0VlS/GRgWfjofEW8cWg2WxRzEN6NkHBn25QEk3
         CamUiSzXUgcMao8TBi41jdravMuHRifbj2wtLOKV431mBaKGhjxmb9mkqt7r3ZHCIUCB
         SjhedrjS5K/nhqbx8zzl/fQPGuVpIZmj0WWQccPdW4Lu/UgufGnue24n16rSpaEiw37H
         Z5n3akIIt4ctEJIln5vxzUPgkPWg1u9ldVKygh0mEoyRvIMLZ6YuzbSOJ1/LTr1bHP05
         5mpnT39TxrwuSSy41JqinWE8NRzKTEa7Dgb84aH1ln+gaVbYig8AQpFOdtRwgUARbffN
         aGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769681665; x=1770286465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LEB8Yp/SddLVwrY1R6Js1dQZWhnZcm4xY82a3ZUzWc4=;
        b=puNe8l7EmGlrgpleSpVttNlMt0C1Cqh4suXIqiKb+JOxa/8z+TWDTgra5gOvkHCjiC
         xSO25neSrnBl8bw+9zznswlQHJ7WoCci39TKFiY9YNzg8FwZrs8AQwfp0XUy2DHnMlkC
         k4+Zz3AkrDHJvqPgoRTS1AyFNWKxWos9TvEMvwV5s8K8yXI8VwgTQtYglkg2SO6yyeK0
         5Cis26ED4XB9+51ohAlacZ8FDhJp+GdE+gXqHknBkZRBxqxzd53V/ZKcD/v+FuDXkCPj
         dFjiitt8iy+RC6+zoAc0viwwMYirEqMMh4uN9CYFoMLlEJ7rQG8gWtQfsVa/BTNYuuv7
         jnVw==
X-Gm-Message-State: AOJu0YxRxTpXsXuFFOIcgw5yeleA9rB5OWzVAumnwYiNKYaTbcjfmyvh
	ph0gyt2M9LD6NOG8c86ekI1SFNpAQ/XFo4vHfqjBSw0GRyxQrgRIdWcpV6PpDPnn
X-Gm-Gg: AZuq6aJOLXHYcSNlgxPT3EA+sRpeYWWZLEXS3k9uCfvpa8pxw4a5qiumJo2ssph08hl
	XbGWe92aRZ2JKjkbld5NZz9TdeLGXJNkwEQWLDCxE3KZsMlVl1zvsG3r3D/+rFV0FW3Oav/eGJk
	E2DSxcNO4+H8mHKEKk7LM2LCsSRsH678zpyjiHIN4jWJQqXsZHHmcT7VfzdBL0jd43cse9dhkns
	0nbKHdF+qkpMNSxq7krg1t7laEh3/7WRIO/uDrWD31OHouMQ3zQOXAaN+ixZUC3fIMgsVo+ehur
	VTg6WaIaQ3hj0RcTJxb8E9x3oo10AehG3iZctQmKU9022PhHJqWU25936cTreDWZ0rjGhXHOZi4
	+93c7htXtVcftiNqH3yrRE+FFuZ2s04NUIhYxTevgRNrqfN+CDXIL9U+63Bltxg3aNaz6ew+UFA
	OQ4k4fQWRP7y96WEjQ7NtVa+k55/GMgubFbiqDGt1KNQpJLoCmBzYICm4eSFBR5fHMjSJOzTwE7
	3UaWJpTAub6q/truI9j1GFoRE6zPj6fQ7XQBZ3A37l6hiQKWnscS5F+X9hHN+5XBO0tu+ORXKo7
	RSz4
X-Received: by 2002:a05:6830:828d:b0:7ab:e111:1a57 with SMTP id 46e09a7af769-7d18512db09mr5036559a34.31.1769674175726;
        Thu, 29 Jan 2026 00:09:35 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c831394sm3317768a34.31.2026.01.29.00.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 00:09:35 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-x25@vger.kernel.org,
	linux-hams@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Joerg Reuter <jreuter@yaina.de>
Subject: [PATCH] net: ax25: remove plumbing for never-implemented DAMA Master support
Date: Thu, 29 Jan 2026 00:09:04 -0800
Message-ID: <20260129080908.44710-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-x25@vger.kernel.org
List-Id: <linux-x25.vger.kernel.org>
List-Subscribe: <mailto:linux-x25+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-x25+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AX25_DAMA_MASTER option has been unimplemented and marked broken
ever since it was introduced in 2007 in commit 954b2e7f4c37 ("[NET]
AX.25 Kconfig and docs updates and fixes"). At this point, it is very
unlikely it will be implemented. Remove it.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 include/net/ax25.h  |  8 ++------
 net/ax25/Kconfig    | 14 --------------
 net/ax25/ax25_dev.c |  2 --
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/include/net/ax25.h b/include/net/ax25.h
index a7bba42dde15..ad3d7626130e 100644
--- a/include/net/ax25.h
+++ b/include/net/ax25.h
@@ -116,10 +116,6 @@ enum {
 	AX25_PROTO_STD_DUPLEX,
 #ifdef CONFIG_AX25_DAMA_SLAVE
 	AX25_PROTO_DAMA_SLAVE,
-#ifdef CONFIG_AX25_DAMA_MASTER
-	AX25_PROTO_DAMA_MASTER,
-#define AX25_PROTO_MAX AX25_PROTO_DAMA_MASTER
-#endif
 #endif
 	__AX25_PROTO_MAX,
 	AX25_PROTO_MAX = __AX25_PROTO_MAX -1
@@ -138,7 +134,7 @@ enum {
 	AX25_VALUES_IDLE,	/* Connected mode idle timer */
 	AX25_VALUES_N2,		/* Default N2 value */
 	AX25_VALUES_PACLEN,	/* AX.25 MTU */
-	AX25_VALUES_PROTOCOL,	/* Std AX.25, DAMA Slave, DAMA Master */
+	AX25_VALUES_PROTOCOL,	/* Std AX.25, DAMA Slave */
 #ifdef CONFIG_AX25_DAMA_SLAVE
 	AX25_VALUES_DS_TIMEOUT,	/* DAMA Slave timeout */
 #endif
@@ -226,7 +222,7 @@ typedef struct ax25_dev {
 	struct net_device	*forward;
 	struct ctl_table_header *sysheader;
 	int			values[AX25_MAX_VALUES];
-#if defined(CONFIG_AX25_DAMA_SLAVE) || defined(CONFIG_AX25_DAMA_MASTER)
+#ifdef CONFIG_AX25_DAMA_SLAVE
 	ax25_dama_info		dama;
 #endif
 	refcount_t		refcount;
diff --git a/net/ax25/Kconfig b/net/ax25/Kconfig
index e23a3dc14b93..310169ce1488 100644
--- a/net/ax25/Kconfig
+++ b/net/ax25/Kconfig
@@ -63,20 +63,6 @@ config AX25_DAMA_SLAVE
 	  be enabled at runtime.  For more about DAMA see
 	  <https://linux-ax25.in-berlin.de>.  If unsure, say Y.
 
-# placeholder until implemented
-config AX25_DAMA_MASTER
-	bool 'AX.25 DAMA Master support'
-	depends on AX25_DAMA_SLAVE && BROKEN
-	help
-	  DAMA is a mechanism to prevent collisions when doing AX.25
-	  networking. A DAMA server (called "master") accepts incoming traffic
-	  from clients (called "slaves") and redistributes it to other slaves.
-	  If you say Y here, your Linux box will act as a DAMA master; this is
-	  transparent in that you don't have to do any special DAMA
-	  configuration. Linux cannot yet act as a DAMA server.  This option
-	  only compiles DAMA slave support into the kernel.  It still needs to
-	  be explicitly enabled, so if unsure, say Y.
-
 config NETROM
 	tristate "Amateur Radio NET/ROM protocol"
 	depends on AX25
diff --git a/net/ax25/ax25_dev.c b/net/ax25/ax25_dev.c
index 3733c0254a50..c504ed9c3a88 100644
--- a/net/ax25/ax25_dev.c
+++ b/net/ax25/ax25_dev.c
@@ -82,9 +82,7 @@ void ax25_dev_device_up(struct net_device *dev)
 
 #ifdef CONFIG_AX25_DAMA_SLAVE
 	ax25_dev->values[AX25_VALUES_DS_TIMEOUT]= AX25_DEF_DS_TIMEOUT;
-#endif
 
-#if defined(CONFIG_AX25_DAMA_SLAVE) || defined(CONFIG_AX25_DAMA_MASTER)
 	ax25_ds_setup_timer(ax25_dev);
 #endif
 
-- 
2.43.0

